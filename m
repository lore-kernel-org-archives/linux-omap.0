From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH] [DSPBRIDGE] Various compile warning fixes
Date: Fri, 17 Apr 2009 19:43:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A9985148@dbde02.ent.ti.com>
References: <1239960602-32309-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256AbZDQOOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 10:14:47 -0400
In-Reply-To: <1239960602-32309-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ameya,

Ack, This patch looks good. I tested and not seen any issues.

Regards
Ramesh Gupta G

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ameya Palande
> Sent: Friday, April 17, 2009 3:00 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] [DSPBRIDGE] Various compile warning fixes
> 
> From: Mika Kukkonen <mika.kukkonen@nokia.com>
> 
> This patch cleans up various warnings uncovered with extra 
> warning flags:
>   - empty if() bodies
>   - incorrect use of unsigned variables
>   - bad comparison of pointer value
>   - pointless check of unsigned value being smaller than zero
>   - keyword 'extern' has to be first one in variable declaration
> 
> Signed-off-by: Mika Kukkonen <mika.kukkonen@nokia.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +++---
>  arch/arm/plat-omap/include/dspbridge/dbg.h |    4 ++--
>  arch/arm/plat-omap/include/dspbridge/gt.h  |   14 +++++++-------
>  arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
>  drivers/dsp/bridge/services/kfile.c        |    4 ++--
>  drivers/dsp/bridge/wmd/io_sm.c             |    8 +++-----
>  drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
>  7 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h 
> b/arch/arm/plat-omap/include/dspbridge/dbc.h
> index 0e6a67d..ec55c1d 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
> @@ -57,9 +57,9 @@
>  
>  #else
>  
> -#define DBC_Assert(exp)
> -#define DBC_Require(exp)
> -#define DBC_Ensure(exp)
> +#define DBC_Assert(exp) {}
> +#define DBC_Require(exp) {}
> +#define DBC_Ensure(exp) {}
>  
>  #endif				/* DEBUG */
>  
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h 
> b/arch/arm/plat-omap/include/dspbridge/dbg.h
> index 7f44ff9..59a0a20 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbg.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
> @@ -101,9 +101,9 @@
>  	extern DSP_STATUS DBG_Trace(IN u8 bLevel, IN char 
> *pstrFormat, ...);
>  #else
>  
> -#define DBG_Exit(void)
> +#define DBG_Exit(void) do {} while(0)
>  #define DBG_Init(void) true
> -#define DBG_Trace(bLevel, pstrFormat, args...)
> +#define DBG_Trace(bLevel, pstrFormat, args...) do {} while(0)
>  
>  #endif	     /* (defined(DEBUG) || 
> defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
>  
> diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h 
> b/arch/arm/plat-omap/include/dspbridge/gt.h
> index 456c866..ebe75fe 100644
> --- a/arch/arm/plat-omap/include/dspbridge/gt.h
> +++ b/arch/arm/plat-omap/include/dspbridge/gt.h
> @@ -261,13 +261,13 @@ extern struct GT_Config _GT_params;
>  
>  #define GT_query(mask, class)     false
>  
> -#define GT_0trace(mask, class, format)
> -#define GT_1trace(mask, class, format, arg1)
> -#define GT_2trace(mask, class, format, arg1, arg2)
> -#define GT_3trace(mask, class, format, arg1, arg2, arg3)
> -#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4)
> -#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5)
> -#define GT_6trace(mask, class, format, arg1, arg2, arg3, 
> arg4, arg5, arg6)
> +#define GT_0trace(mask, class, format) do {} while(0)
> +#define GT_1trace(mask, class, format, arg1) do {} while(0)
> +#define GT_2trace(mask, class, format, arg1, arg2) do {} while(0)
> +#define GT_3trace(mask, class, format, arg1, arg2, arg3) do 
> {} while(0)
> +#define GT_4trace(mask, class, format, arg1, arg2, arg3, 
> arg4) do {} while(0)
> +#define GT_5trace(mask, class, format, arg1, arg2, arg3, 
> arg4, arg5) do {} while(0)
> +#define GT_6trace(mask, class, format, arg1, arg2, arg3, 
> arg4, arg5, arg6) do {} while(0)
>  
>  #else				/* GT_TRACE == 1 */
>  
> diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h 
> b/arch/arm/plat-omap/include/dspbridge/mem.h
> index 535ac3a..cc79047 100644
> --- a/arch/arm/plat-omap/include/dspbridge/mem.h
> +++ b/arch/arm/plat-omap/include/dspbridge/mem.h
> @@ -317,7 +317,7 @@
>   *  Ensures:
>   *      - pBaseAddr no longer points to a valid linear address.
>   */
> -#define MEM_UnmapLinearAddress(pBaseAddr)
> +#define MEM_UnmapLinearAddress(pBaseAddr) {}
>  
>  /*
>   *  ======== MEM_ExtPhysPoolInit ========
> diff --git a/drivers/dsp/bridge/services/kfile.c 
> b/drivers/dsp/bridge/services/kfile.c
> index ba1d26f..6356d05 100644
> --- a/drivers/dsp/bridge/services/kfile.c
> +++ b/drivers/dsp/bridge/services/kfile.c
> @@ -262,7 +262,7 @@ KFILE_Read(void __user*pBuffer, s32 
> cSize, s32 cCount,
>  s32 KFILE_Seek(struct KFILE_FileObj *hFile, s32 lOffset, s32 cOrigin)
>  {
>  	s32 cRetVal = 0;	/* 0 for success */
> -	u32 dwCurPos = 0;
> +	s32 dwCurPos = 0;
>  
>  	struct file *fileDesc = NULL;
>  
> @@ -315,7 +315,7 @@ s32 KFILE_Seek(struct KFILE_FileObj 
> *hFile, s32 lOffset, s32 cOrigin)
>   */
>  s32 KFILE_Tell(struct KFILE_FileObj *hFile)
>  {
> -	u32 dwCurPos = 0;
> +	s32 dwCurPos = 0;
>  	s32 lRetVal = E_KFILE_ERROR;
>  
>  	GT_1trace(KFILE_debugMask, GT_ENTER, "KFILE_Tell: hFile 
> 0x%x\n", hFile);
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c 
> b/drivers/dsp/bridge/wmd/io_sm.c
> index 8d106e1..a49eea1 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -236,10 +236,8 @@ DSP_STATUS WMD_IO_Create(OUT struct 
> IO_MGR **phIOMgr,
>         if (ref_count == 0)
>                 bridge_workqueue = 
> create_workqueue("bridge_work-queue");
>  
> -       if (bridge_workqueue <= 0)
> -               DBG_Trace(DBG_LEVEL1, "Workque Create"
> -                       " failed 0x%d \n", bridge_workqueue);
> -
> +       if (!bridge_workqueue)
> +               DBG_Trace(DBG_LEVEL1, "Workqueue creation failed!\n");
>  
>  	/* Allocate IO manager object: */
>  	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
> @@ -1157,7 +1155,7 @@ static void InputChnl(struct IO_MGR 
> *pIOMgr, struct CHNL_OBJECT *pChnl,
>  			    pChnlMgr->uWordSize;
>  	chnlId = IO_GetValue(pIOMgr->hWmdContext, struct SHM, 
> sm, inputId);
>  	dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, sm, arg);
> -	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
> +	if (chnlId >= CHNL_MAXCHANNELS) {
>  		/* Shouldn't be here: would indicate corrupted SHM. */
>  		DBC_Assert(chnlId);
>  		goto func_end;
> diff --git a/drivers/dsp/bridge/wmd/ue_deh.c 
> b/drivers/dsp/bridge/wmd/ue_deh.c
> index d5551cb..0e6cfec 100644
> --- a/drivers/dsp/bridge/wmd/ue_deh.c
> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> @@ -199,7 +199,7 @@ void WMD_DEH_Notify(struct DEH_MGR 
> *hDehMgr, u32 ulEventMask,
>  	DSP_STATUS status = DSP_SOK;
>  	u32 memPhysical = 0;
>  	u32 HW_MMU_MAX_TLB_COUNT = 31;
> -	u32 extern faultAddr;
> +	extern u32 faultAddr;
>  	struct CFG_HOSTRES resources;
>  	u32 dummyVaAddr;
>  	HW_STATUS hwStatus;
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 