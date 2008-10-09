From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected
 functions
Date: Thu, 09 Oct 2008 07:48:29 +0300 (EEST)
Message-ID: <20081009.074829.58089276.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344D13167@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58783 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879AbYJIEsi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 00:48:38 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344D13167@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com
Cc: vikram.pandita@ti.com, linux-omap@vger.kernel.org

Hi Omar,

This patch has been added to l-o tidspbridge patchset for its easy
integration against l-o:

http://4869037.web.fc2.com/tidspbridge-20081010.tgz

	Hiroshi DOYU

It has been sync'ed with omapzoom("o-z") bridge patches[1] and rebased
on the latest l-o.  Most of the patches come from o-z(Thanks TI bridge
team!) and I just collected them;)

So steps are:

  $ git clone http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
  $ cd linux-omap-2.6
  $ wget http://4869037.web.fc2.com/tidspbridge-<date>.tgz
  $ tar xvzf tidspbridge-<date>.tgz
  $ git am *.patch
  $ make <your omap3 board>_defconfig
  $ make menuconfig # add the following options in the menuconfig
 ...
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=14
 ...
 CONFIG_MPU_BRIDGE=m
 CONFIG_DISABLE_BRIDGE_DVFS=y
 ...

You can get bridge sample binaries as below:

  https://omapzoom.org/gf/download/frsrelease/132/632/dspbridge_binaries.tar.bz2

And extract it somewhere on target rootfs.

After kernel booted up:

 $ depmod -a
 $ modprobe bridgedriver base_img=ddbase_tiomap3430.dof64P
 $ <Thy some sample applications>


From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected functions
Date: Wed, 8 Oct 2008 17:07:15 -0500

> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Fri, 3 Oct 2008 12:20:45 -0500
> Subject: [PATCH] BRIDGE Add preemption support to unprotected functions
> 
> This patch protects the critical sections in bridge
> driver that otherwise might end in unexpected behavior.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/sync.h |   15 +++++++-----
>  drivers/dsp/bridge/rmgr/proc.c              |   31 ++++++++++++++++++++------
>  drivers/dsp/bridge/services/sync.c          |    9 +-------
>  3 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/sync.h b/arch/arm/plat-omap/include/dspbridge/sync.h
> index e340c88..26aa370 100644
> --- a/arch/arm/plat-omap/include/dspbridge/sync.h
> +++ b/arch/arm/plat-omap/include/dspbridge/sync.h
> @@ -55,6 +55,11 @@
>  #ifndef _SYNC_H
>  #define _SYNC_H
>  
> +#include <asm/semaphore.h>
> +
> +#define SIGNATURECS     0x53435953	/* "SYCS" (in reverse) */
> +#define SIGNATUREDPCCS  0x53445953	/* "SYDS" (in reverse) */
> +
>  /* Special timeout value indicating an infinite wait: */
>  #define SYNC_INFINITE  0xffffffff
>  
> @@ -63,14 +68,12 @@
>  
>  /* Generic SYNC object: */
>  	struct SYNC_OBJECT;
> -	/*typedef struct SYNC_OBJECT *SYNC_HOBJECT;*/
>  
>  /* Generic SYNC CS object: */
> -	struct SYNC_CSOBJECT;
> -	/*typedef struct SYNC_CSOBJECT *SYNC_HCSOBJECT;*/
> -
> -/* Used SYNC_CSOBJECT instead of SYNC_DPCCSOBJECT to avoid warnings */
> -	/*typedef struct SYNC_CSOBJECT *SYNC_HDPCCSOBJECT;*/
> +struct SYNC_CSOBJECT {
> +	u32 dwSignature;	/* used for object validation */
> +	struct semaphore sem;
> +} ;
>  
>  /* SYNC object attributes: */
>  	struct SYNC_ATTRS {
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index b60fd3a..4464c62 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -118,7 +118,7 @@
>  #include <dspbridge/list.h>
>  #include <dspbridge/mem.h>
>  #include <dspbridge/ntfy.h>
> -
> +#include <dspbridge/sync.h>
>  /*  ----------------------------------- Mini Driver */
>  #include <dspbridge/wmd.h>
>  
> @@ -197,6 +197,8 @@ static struct GT_Mask PROC_DebugMask = { NULL, NULL };	/* WCD MGR Mask */
>  
>  static u32 cRefs;
>  
> +struct SYNC_CSOBJECT *hProcLock;	/* For critical sections */
> +
>  #ifndef CONFIG_DISABLE_BRIDGE_PM
>  #ifndef CONFIG_DISABLE_BRIDGE_DVFS
>  #ifdef CONFIG_OMAP3_PM
> @@ -733,12 +735,13 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
>  		 "Entered PROC_FlushMemory, args:\n\t"
>  		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
>  		 hProcessor, pMpuAddr, ulSize, ulFlags);
> -
> +	/* Critical section */
> +	(void)SYNC_EnterCS(hProcLock);
>  	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
> +	(void)SYNC_LeaveCS(hProcLock);
>  
>  	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_FlushMemory [0x%x]",
>  		 status);
> -
>  	return status;
>  }
>  
> @@ -759,7 +762,10 @@ DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
>  		 "Entered PROC_InvalidateMemory, args:\n\t"
>  		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x\n", hProcessor,
>  		 pMpuAddr, ulSize);
> +	(void)SYNC_EnterCS(hProcLock);
>  	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
> +	(void)SYNC_LeaveCS(hProcLock);
> +
>  	GT_1trace(PROC_DebugMask, GT_ENTER,
>  		 "Leaving PROC_InvalidateMemory [0x%x]", status);
>  	return status;
> @@ -847,6 +853,9 @@ void PROC_Exit(void)
>  {
>  	DBC_Require(cRefs > 0);
>  
> +	if (hProcLock)
> +		(void)SYNC_DeleteCS(hProcLock);
> +
>  	cRefs--;
>  
>  	GT_1trace(PROC_DebugMask, GT_5CLASS,
> @@ -992,6 +1001,8 @@ bool PROC_Init(void)
>  		DBC_Assert(!PROC_DebugMask.flags);
>  		GT_create(&PROC_DebugMask, "PR");  /* "PR" for Processor */
>  
> +		MEM_AllocObject(hProcLock, struct SYNC_CSOBJECT, SIGNATURECS);
> +		(void)SYNC_InitializeCS(&hProcLock);
>  	}
>  
>  	if (fRetval)
> @@ -1384,6 +1395,8 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
>  	GT_3trace(PROC_DebugMask, GT_ENTER, "PROC_Map: vaAlign %x, paAlign %x, "
>  		 "sizeAlign %x\n", vaAlign, paAlign, sizeAlign);
>  
> +	/* Critical section */
> +	(void)SYNC_EnterCS(hProcLock);
>  	status = DMM_GetHandle(pProcObject, &hDmmMgr);
>  	if (DSP_FAILED(status)) {
>  		GT_1trace(PROC_DebugMask, GT_7CLASS,
> @@ -1406,6 +1419,8 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
>  	} else {
>  		DMM_UnMapMemory(hDmmMgr, vaAlign, &sizeAlign);
>  	}
> +	(void)SYNC_LeaveCS(hProcLock);
> +
>  #ifndef RES_CLEANUP_DISABLE
>  	if (DSP_SUCCEEDED(status)) {
>  		/* Update the node and stream resource status */
> @@ -1532,9 +1547,9 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
>  	if (DSP_FAILED(status)) {
>  		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
>  			 "Failed to get DMM Mgr handle: 0x%x\n", status);
> -	} else {
> +	} else
>  		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
> -	}
> +
>  	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
>  		 status);
>  	return status;
> @@ -1743,6 +1758,8 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
>  	vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);
>  
>  	status = DMM_GetHandle(hProcessor, &hDmmMgr);
> +	/* Critical section */
> +	(void)SYNC_EnterCS(hProcLock);
>  	if (DSP_FAILED(status)) {
>  		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
>  			 "Failed to get DMM Mgr handle: 0x%x\n", status);
> @@ -1751,12 +1768,12 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
>  		 This function returns error if the VA is not mapped */
>  		status = DMM_UnMapMemory(hDmmMgr, (u32) vaAlign, &sizeAlign);
>  	}
> -
>  	/* Remove mapping from the page tables. */
>  	if (DSP_SUCCEEDED(status)) {
>  		status = (*pProcObject->pIntfFxns->pfnBrdMemUnMap)
>  			 (pProcObject->hWmdContext, vaAlign, sizeAlign);
>  	}
> +	(void)SYNC_LeaveCS(hProcLock);
>  #ifndef RES_CLEANUP_DISABLE
>  	GT_1trace(PROC_DebugMask, GT_ENTER,
>  		   "PROC_UnMap DRV_GetDMMResElement "
> @@ -1804,7 +1821,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
>  	status = DMM_GetHandle(pProcObject, &hDmmMgr);
>  	if (DSP_FAILED(status))
>  		GT_1trace(PROC_DebugMask, GT_7CLASS,
> -			 "PROC_Map: Failed to get DMM Mgr "
> +			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
>  			 "handle: 0x%x\n", status);
>  	else
>  		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
> diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
> index 40c832f..d3453fa 100644
> --- a/drivers/dsp/bridge/services/sync.c
> +++ b/drivers/dsp/bridge/services/sync.c
> @@ -15,7 +15,7 @@
>   */
>  
>  /*
> - *  ======== syncce.c ========
> + *  ======== sync.c ========
>   *  Purpose:
>   *      Synchronization services.
>   *
> @@ -68,8 +68,6 @@
>  
>  /*  ----------------------------------- Defines, Data Structures, Typedefs */
>  #define SIGNATURE       0x434e5953	/* "SYNC" (in reverse) */
> -#define SIGNATURECS     0x53435953	/* "SYCS" (in reverse) */
> -#define SIGNATUREDPCCS  0x53445953	/* "SYDS" (in reverse) */
>  
>  enum wait_state {
>  	wo_waiting,
> @@ -95,11 +93,6 @@ struct SYNC_OBJECT {
>  	struct WAIT_OBJECT *pWaitObj;
>  };
>  
> -struct SYNC_CSOBJECT {
> -	u32 dwSignature;	/* used for object validation */
> -	struct semaphore sem;
> -} ;
> -
>  struct SYNC_DPCCSOBJECT {
>  	u32 dwSignature;	/* used for object validation */
>  	spinlock_t sync_dpccs_lock;
> -- 
> 1.5.6.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
