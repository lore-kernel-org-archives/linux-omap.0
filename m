From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting framework
Date: Tue, 16 Feb 2010 20:42:37 +0200
Message-ID: <94a0d4531002161042r73c89d1crbc892e7f7de6771f@mail.gmail.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
	 <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
	 <21ed5f939111b381f877fd335b3adc2e779ce8ac.1266326009.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178]:61748 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933107Ab0BPTN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 14:13:56 -0500
Received: by qyk8 with SMTP id 8so1289632qyk.24
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 11:13:54 -0800 (PST)
In-Reply-To: <21ed5f939111b381f877fd335b3adc2e779ce8ac.1266326009.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, x0095840@ti.com

On Tue, Feb 16, 2010 at 3:20 PM, Ameya Palande <ameya.palande@nokia.com=
> wrote:
> DSP_RSV_OBJECT is introduced to track reserved memory accounting info=
rmation.
> This will allow us to do proper cleanup for memory reserved using
> PROC_ReserveMemory().
>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
> =C2=A0arch/arm/plat-omap/include/dspbridge/drv.h =C2=A0| =C2=A0 13 ++=
++++
> =C2=A0arch/arm/plat-omap/include/dspbridge/proc.h | =C2=A0 =C2=A05 +-
> =C2=A0drivers/dsp/bridge/pmgr/dmm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +-
> =C2=A0drivers/dsp/bridge/pmgr/wcd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 ++-
> =C2=A0drivers/dsp/bridge/rmgr/drv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 27 +++++++++---
> =C2=A0drivers/dsp/bridge/rmgr/drv_interface.c =C2=A0 =C2=A0 | =C2=A0 =
=C2=A07 ++-
> =C2=A0drivers/dsp/bridge/rmgr/node.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +-
> =C2=A0drivers/dsp/bridge/rmgr/proc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 58 +++++++++++++++++++++-----
> =C2=A08 files changed, 97 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/pl=
at-omap/include/dspbridge/drv.h
> index 3069e74..6e8187d 100644
> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
> @@ -101,6 +101,15 @@ struct DMM_MAP_OBJECT {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DMM_MAP_OBJECT =C2=A0*next;
> =C2=A0} ;
>
> +/*
> + * New structure (member of process context) used for accounting of =
DMM
> + * reserved memory information
> + */
> +struct DMM_RSV_OBJECT {
> + =C2=A0 =C2=A0 =C2=A0 struct =C2=A0list_head =C2=A0 =C2=A0 =C2=A0 li=
nk;
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 dsp_reserved_addr;
> +};
> +
> =C2=A0/* New structure (member of process context) abstracts DMM reso=
urce info */
> =C2=A0struct DSPHEAP_RES_OBJECT {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0heapAllocated; /* DMM status */
> @@ -141,6 +150,10 @@ struct PROCESS_CONTEXT{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DMM mapped memory resources */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DMM_MAP_OBJECT *dmm_map_list;
>
> + =C2=A0 =C2=A0 =C2=A0 /* DMM reserved memory resources */
> + =C2=A0 =C2=A0 =C2=A0 struct list_head dmm_rsv_list;
> + =C2=A0 =C2=A0 =C2=A0 spinlock_t dmm_rsv_list_lock;
> +

Why rsv requires a spinlock, but not map?

I guess it would be needed if somehow PROC_UnReserveMemory() was
called by user-space at the same time than bridge_close, but is that
really possible? If it is, then the same danger is present with
PROC_UnMap() unless I'm missing something.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DSP Heap resources */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/p=
lat-omap/include/dspbridge/proc.h
> index 8dbdaac..558c053 100644
> --- a/arch/arm/plat-omap/include/dspbridge/proc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/proc.h
> @@ -560,7 +560,7 @@
> =C2=A0* =C2=A0Details:
> =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0extern DSP_STATUS PROC_ReserveMemory(DSP_H=
PROCESSOR hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0u32 ulSize, void **ppRsvAddr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 ulSize, void *=
*ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt);
>
> =C2=A0/*
> =C2=A0* =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D PROC_UnMap =3D=3D=3D=3D=3D=3D=3D=
=3D
> @@ -604,6 +604,7 @@
> =C2=A0* =C2=A0Details:
> =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0extern DSP_STATUS PROC_UnReserveMemory(DSP=
_HPROCESSOR hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *pRsvAddr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 void *pRsvAddr, struct PROCESS_CONTEXT *pr_ctxt,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int cleanup);
>
> =C2=A0#endif =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PROC_ */
> diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/=
dmm.c
> index d5a7275..72aee60 100644
> --- a/drivers/dsp/bridge/pmgr/dmm.c
> +++ b/drivers/dsp/bridge/pmgr/dmm.c
> @@ -386,9 +386,10 @@ DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT *=
hDmmMgr, u32 size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node->MappedSi=
ze =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Return the =
chunk's starting address */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pRsvAddr =3D =
rsvAddr;
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*dSP chunk of=
 given size is not available */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D DSP=
_EMEMORY;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SYNC_LeaveCS(pDmmObj->hDmmLock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GT_3trace(DMM_debugMask, GT_4CLASS,
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/=
wcd.c
> index beea23b..747d069 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -1054,12 +1054,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args=
 *args, void *pr_ctxt)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GT_0trace(WCD_debugMask, GT_ENTER, "PROCWR=
AP_ReserveMemory: entered\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D PROC_ReserveMemory(args->ARGS_P=
ROC_RSVMEM.hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args->ARGS_PROC_RSVMEM=
=2EulSize, &pRsvAddr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args->ARGS_PROC_RSVMEM=
=2EulSize, &pRsvAddr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_ctxt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DSP_SUCCEEDED(status)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (put_user(p=
RsvAddr, args->ARGS_PROC_RSVMEM.ppRsvAddr)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0status =3D DSP_EINVALIDARG;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PROC_UnReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pRsvAddr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pRsvAddr, pr_ctxt, 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> @@ -1100,7 +1101,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args=
 *args, void *pr_ctxt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GT_0trace(WCD_debugMask, GT_ENTER,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "PROCWRAP_UnR=
eserveMemory: entered\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D PROC_UnReserveMemory(args->ARGS=
_PROC_UNRSVMEM.hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args->ARGS_PROC=
_UNRSVMEM.pRsvAddr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 args->ARGS_PROC_UNRSVMEM.pRsvAddr, pr_ctxt, 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/=
drv.c
> index 3dc38d0..9d5c077 100644
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -277,25 +277,20 @@ DSP_STATUS =C2=A0DRV_ProcFreeDMMRes(HANDLE hPCt=
xt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (DSP_FAILED(status))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("%s: PROC_UnMap fail=
ed! status =3D"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0" 0x%xn", __func__, status);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 status =3D PROC_UnReserveMemory(pDMMRes->hProcessor,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)pDMMRes->ulDSPResAddr=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (DSP_FAILED(status))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: PROC_UnReserveMemory =
failed!"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " statu=
s =3D 0x%xn", __func__, status);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pDMMRes->dmmAllocated =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> -/* Release all DMM resources and its context
> -* This is called from .bridge_release. */
> +/* Release all Mapped and Reserved DMM resources */
> =C2=A0DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct PROCESS_CONTEXT *pCtxt =3D (struct =
PROCESS_CONTEXT *)hPCtxt;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP_STATUS status =3D DSP_SOK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DMM_MAP_OBJECT *pTempDMMRes2 =3D NU=
LL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DMM_MAP_OBJECT *pTempDMMRes =3D NUL=
L;
> + =C2=A0 =C2=A0 =C2=A0 struct DMM_RSV_OBJECT *temp, *rsv_obj;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_ProcFreeDMMRes(pCtxt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pTempDMMRes =3D pCtxt->dmm_map_list;
> @@ -305,6 +300,24 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hP=
Ctxt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(pTempDMM=
Res2);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pCtxt->dmm_map_list =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Free DMM reserved memory resources */
> + =C2=A0 =C2=A0 =C2=A0 spin_lock(&pCtxt->dmm_rsv_list_lock);
> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(rsv_obj, temp, &pCtxt=
->dmm_rsv_list, link) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Since we h=
ave already acquired spin lock for dmm_rsv_list,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* we don't w=
ant to perform cleanup in PROC_UnReserveMemory.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/

Sure, but why did we acquire a spin lock in the first place?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D PROC_Un=
ReserveMemory(pCtxt->hProcessor,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)rsv_obj->dsp_reserved_addr,=
 pCtxt, 0);

If this behaved similarly to the unmap code, then 'cleanup' could be
one and there wouldn't be any need to manually remove the entries.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (DSP_FAILED(sta=
tus))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_err("%s: PROC_UnReserveMemory failed!"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " statu=
s =3D 0x%xn", __func__, status);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&rsv_obj-=
>link);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(rsv_obj);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&pCtxt->dmm_rsv_list_lock);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
