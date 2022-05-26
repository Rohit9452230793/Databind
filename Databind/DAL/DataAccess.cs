using Databind.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Databind.DAL
{
    public class DataAccess:DbContext
    {

        #region BindMaster
        public IEnumerable<Master> Proc_BindMaster(int ProcID)
        {
            var query = @"Sp_BindMaster @ProcID";
            var param = new SqlParameter[] {
            new SqlParameter{ParameterName="@ProcID",Value=ProcID}};
            return this.Database.SqlQuery<Master>(query, param);
        }
        #endregion


        #region T_Event 
        public IEnumerable<T_Event> Event(int procid, T_Event Event)
        {
            var sqlQuery = @"Sp_Event @Eid,@Title,@Procid";
            var Epara = new SqlParameter[]
            {
                new SqlParameter {ParameterName="@Eid",Value=Event.Eid==null?0:Event.Eid },
                new SqlParameter {ParameterName="@Title",Value=Event.Title??string.Empty },
                 new SqlParameter {ParameterName="@Procid",Value=procid }

            };

            return this.Database.SqlQuery<T_Event>(sqlQuery, Epara);
        }
        #endregion

        #region M_Event
        public IEnumerable<M_Event> Event_F(int procid, M_Event Event_F)
        {
            var query = @"Sp_M_Event @id,@Eid,@Title,@Name,@Date,@Discription,@Images,@ProcId";
            var Bpara = new SqlParameter[]
                {
                    new SqlParameter{ParameterName = "@id",Value=Event_F.EventId==null?0:Event_F.EventId},
                    new SqlParameter {ParameterName="@Eid",Value=Event_F.Eid==null?0:Event_F.Eid },
                    new SqlParameter{ParameterName = "@Title",Value=Event_F.Title??string.Empty},
                    new SqlParameter {ParameterName="@Name",Value=Event_F.Name??string.Empty },
                    new SqlParameter{ParameterName="@Date",Value=Event_F.Date??string.Empty},
                    new SqlParameter{ParameterName="@Discription",Value=Event_F.Discription??string.Empty},
                    new SqlParameter{ParameterName="@Images",Value=Event_F.Images??string.Empty},
                    new SqlParameter{ParameterName="@ProcId",Value=procid}
                };

            return this.Database.SqlQuery<M_Event>(query, Bpara);
        }

        #endregion


    }
}