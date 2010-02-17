From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting framework
Date: Tue, 16 Feb 2010 20:05:45 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B962A@dlee06.ent.ti.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
	 <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
	 <21ed5f939111b381f877fd335b3adc2e779ce8ac.1266326009.git.ameya.palande@nokia.com>
 <94a0d4531002161042r73c89d1crbc892e7f7de6771f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39950 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933968Ab0BQCFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 21:05:52 -0500
In-Reply-To: <94a0d4531002161042r73c89d1crbc892e7f7de6771f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


Hi,

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Tuesday, February 16, 2010 12:43 PM
>To: Ameya Palande
>Cc: linux-omap@vger.kernel.org; felipe.contreras@nokia.com; Menon,
>Nishanth; Chitriki Rudramuni, Deepak; Ramirez Luna, Omar; Guzman Lugo,
>Fernando
>Subject: Re: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting
>framework
>
>On Tue, Feb 16, 2010 at 3:20 PM, Ameya Palande <ameya.palande@nokia.co=
m>
>wrote:
>> DSP_RSV_OBJECT is introduced to track reserved memory accounting
>information.
>> This will allow us to do proper cleanup for memory reserved using
>> PROC_ReserveMemory().
>>
>> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>> ---
>> =A0arch/arm/plat-omap/include/dspbridge/drv.h =A0| =A0 13 ++++++
>> =A0arch/arm/plat-omap/include/dspbridge/proc.h | =A0 =A05 +-
>> =A0drivers/dsp/bridge/pmgr/dmm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 +-
>> =A0drivers/dsp/bridge/pmgr/wcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 ++-
>> =A0drivers/dsp/bridge/rmgr/drv.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
7 +++++++++---
>> =A0drivers/dsp/bridge/rmgr/drv_interface.c =A0 =A0 | =A0 =A07 ++-
>> =A0drivers/dsp/bridge/rmgr/node.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
5 +-
>> =A0drivers/dsp/bridge/rmgr/proc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 5=
8
>+++++++++++++++++++++-----
>> =A08 files changed, 97 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/p=
lat-
>omap/include/dspbridge/drv.h
>> index 3069e74..6e8187d 100644
>> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
>> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>> @@ -101,6 +101,15 @@ struct DMM_MAP_OBJECT {
>> =A0 =A0 =A0 =A0struct DMM_MAP_OBJECT =A0*next;
>> =A0} ;
>>
>> +/*
>> + * New structure (member of process context) used for accounting of=
 DMM
>> + * reserved memory information
>> + */
>> +struct DMM_RSV_OBJECT {
>> + =A0 =A0 =A0 struct =A0list_head =A0 =A0 =A0 link;
>> + =A0 =A0 =A0 u32 =A0 =A0 dsp_reserved_addr;
>> +};
>> +
>> =A0/* New structure (member of process context) abstracts DMM resour=
ce info
>*/
>> =A0struct DSPHEAP_RES_OBJECT {
>> =A0 =A0 =A0 =A0s32 =A0 =A0 =A0 =A0 =A0 =A0heapAllocated; /* DMM stat=
us */
>> @@ -141,6 +150,10 @@ struct PROCESS_CONTEXT{
>> =A0 =A0 =A0 =A0/* DMM mapped memory resources */
>> =A0 =A0 =A0 =A0struct DMM_MAP_OBJECT *dmm_map_list;
>>
>> + =A0 =A0 =A0 /* DMM reserved memory resources */
>> + =A0 =A0 =A0 struct list_head dmm_rsv_list;
>> + =A0 =A0 =A0 spinlock_t dmm_rsv_list_lock;
>> +
>
>Why rsv requires a spinlock, but not map?
>
>I guess it would be needed if somehow PROC_UnReserveMemory() was
>called by user-space at the same time than bridge_close, but is that
>really possible? If it is, then the same danger is present with
>PROC_UnMap() unless I'm missing something.

No, that's not possible. However protection is still needed for PROC_ R=
eserveMemory/UnReserveMemory and also for PROC_Map/UnMap.

Regards,
=46ernando.

>
>> =A0 =A0 =A0 =A0/* DSP Heap resources */
>> =A0 =A0 =A0 =A0struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
>>
>> diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/=
plat-
>omap/include/dspbridge/proc.h
>> index 8dbdaac..558c053 100644
>> --- a/arch/arm/plat-omap/include/dspbridge/proc.h
>> +++ b/arch/arm/plat-omap/include/dspbridge/proc.h
>> @@ -560,7 +560,7 @@
>> =A0* =A0Details:
>> =A0*/
>> =A0 =A0 =A0 =A0extern DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR h=
Processor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0u32 ulSize, void
>**ppRsvAddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ulSize, void **ppRsvAddr, struct P=
ROCESS_CONTEXT
>*pr_ctxt);
>>
>> =A0/*
>> =A0* =A0=3D=3D=3D=3D=3D=3D=3D=3D PROC_UnMap =3D=3D=3D=3D=3D=3D=3D=3D
>> @@ -604,6 +604,7 @@
>> =A0* =A0Details:
>> =A0*/
>> =A0 =A0 =A0 =A0extern DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR=
 hProcessor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0void *pRsvAddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *pRsvAddr, struct=
 PROCESS_CONTEXT *pr_ctxt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int cleanup);
>>
>> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PROC_ *=
/
>> diff --git a/drivers/dsp/bridge/pmgr/dmm.c
>b/drivers/dsp/bridge/pmgr/dmm.c
>> index d5a7275..72aee60 100644
>> --- a/drivers/dsp/bridge/pmgr/dmm.c
>> +++ b/drivers/dsp/bridge/pmgr/dmm.c
>> @@ -386,9 +386,10 @@ DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT
>*hDmmMgr, u32 size,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node->MappedSize =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Return the chunk's starting addres=
s */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pRsvAddr =3D rsvAddr;
>> - =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*dSP chunk of given size is not avai=
lable */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D DSP_EMEMORY;
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0SYNC_LeaveCS(pDmmObj->hDmmLock);
>> =A0 =A0 =A0 =A0GT_3trace(DMM_debugMask, GT_4CLASS,
>> diff --git a/drivers/dsp/bridge/pmgr/wcd.c
>b/drivers/dsp/bridge/pmgr/wcd.c
>> index beea23b..747d069 100644
>> --- a/drivers/dsp/bridge/pmgr/wcd.c
>> +++ b/drivers/dsp/bridge/pmgr/wcd.c
>> @@ -1054,12 +1054,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Arg=
s
>*args, void *pr_ctxt)
>>
>> =A0 =A0 =A0 =A0GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveM=
emory:
>entered\n");
>> =A0 =A0 =A0 =A0status =3D PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.=
hProcessor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
args->ARGS_PROC_RSVMEM.ulSize,
>&pRsvAddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
args->ARGS_PROC_RSVMEM.ulSize,
>&pRsvAddr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pr_ctxt);
>> =A0 =A0 =A0 =A0if (DSP_SUCCEEDED(status)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (put_user(pRsvAddr, args->ARGS_PRO=
C_RSVMEM.ppRsvAddr))
>{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D DSP_EINVAL=
IDARG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PROC_UnReserveMemory(=
args-
>>ARGS_PROC_RSVMEM.hProcessor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pRsvAd=
dr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pRsvAd=
dr, pr_ctxt, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0return status;
>> @@ -1100,7 +1101,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Arg=
s
>*args, void *pr_ctxt)
>> =A0 =A0 =A0 =A0GT_0trace(WCD_debugMask, GT_ENTER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "PROCWRAP_UnReserveMemory: entered\n=
");
>> =A0 =A0 =A0 =A0status =3D PROC_UnReserveMemory(args->ARGS_PROC_UNRSV=
MEM.hProcessor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0args->ARGS_PROC_UNRSVMEM.pRsvAddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 args->ARGS_PROC_UNRSVM=
EM.pRsvAddr, pr_ctxt, 1);
>> =A0 =A0 =A0 =A0return status;
>> =A0}
>>
>> diff --git a/drivers/dsp/bridge/rmgr/drv.c
>b/drivers/dsp/bridge/rmgr/drv.c
>> index 3dc38d0..9d5c077 100644
>> --- a/drivers/dsp/bridge/rmgr/drv.c
>> +++ b/drivers/dsp/bridge/rmgr/drv.c
>> @@ -277,25 +277,20 @@ DSP_STATUS =A0DRV_ProcFreeDMMRes(HANDLE hPCtxt=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DSP_FAILED(status=
))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_de=
bug("%s: PROC_UnMap failed! status =3D"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0" 0x%xn", __func__,
>status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PROC_UnRese=
rveMemory(pDMMRes-
>>hProcessor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(vo=
id *)pDMMRes->ulDSPResAddr);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DSP_FAILED(status)=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_deb=
ug("%s: PROC_UnReserveMemory
>failed!"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 " status =3D 0x%xn", __func__,
>status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pDMMRes->dmmAllocated=
 =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0return status;
>> =A0}
>>
>> -/* Release all DMM resources and its context
>> -* This is called from .bridge_release. */
>> +/* Release all Mapped and Reserved DMM resources */
>> =A0DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
>> =A0{
>> =A0 =A0 =A0 =A0struct PROCESS_CONTEXT *pCtxt =3D (struct PROCESS_CON=
TEXT *)hPCtxt;
>> =A0 =A0 =A0 =A0DSP_STATUS status =3D DSP_SOK;
>> =A0 =A0 =A0 =A0struct DMM_MAP_OBJECT *pTempDMMRes2 =3D NULL;
>> =A0 =A0 =A0 =A0struct DMM_MAP_OBJECT *pTempDMMRes =3D NULL;
>> + =A0 =A0 =A0 struct DMM_RSV_OBJECT *temp, *rsv_obj;
>>
>> =A0 =A0 =A0 =A0DRV_ProcFreeDMMRes(pCtxt);
>> =A0 =A0 =A0 =A0pTempDMMRes =3D pCtxt->dmm_map_list;
>> @@ -305,6 +300,24 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE
>hPCtxt)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(pTempDMMRes2);
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0pCtxt->dmm_map_list =3D NULL;
>> +
>> + =A0 =A0 =A0 /* Free DMM reserved memory resources */
>> + =A0 =A0 =A0 spin_lock(&pCtxt->dmm_rsv_list_lock);
>> + =A0 =A0 =A0 list_for_each_entry_safe(rsv_obj, temp, &pCtxt->dmm_rs=
v_list,
>link) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Since we have already acquired sp=
in lock for
>dmm_rsv_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we don't want to perform cleanup =
in
>PROC_UnReserveMemory.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>
>Sure, but why did we acquire a spin lock in the first place?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PROC_UnReserveMemory(pCtxt-=
>hProcessor,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void =
*)rsv_obj->dsp_reserved_addr,
>pCtxt, 0);
>
>If this behaved similarly to the unmap code, then 'cleanup' could be
>one and there wouldn't be any need to manually remove the entries.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DSP_FAILED(status))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PROC_UnRes=
erveMemory failed!"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 " status =3D 0x%xn", __func__,
>status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&rsv_obj->link);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(rsv_obj);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 spin_unlock(&pCtxt->dmm_rsv_list_lock);
>> +
>> =A0 =A0 =A0 =A0return status;
>> =A0}
>
>Cheers.
>
>--
>Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
