From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH v2 2/4] dsp-bridge: remove UTIL_Wait wrapper
Date: Mon, 23 Feb 2009 16:22:03 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E21180809@dlee03.ent.ti.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
 <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
 <1235295144-22097-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60798 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbZBWWWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:22:17 -0500
In-Reply-To: <1235295144-22097-2-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>

Looks good.
We will do some internal validation and push this change to omapzoom tree.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, February 22, 2009 3:32 AM
> To: linux-omap@vger.kernel.org
> Cc: Hiroshi DOYU; Kanigeri, Hari; ameya.palande@nokia.com; Felipe
> Contreras
> Subject: [PATCH v2 2/4] dsp-bridge: remove UTIL_Wait wrapper
> 
> Wrappers only hurt readability, use native kernel functions instead
> (udelay, mdelay).
> 
> Also remove useless defines.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/util.h |   33 ----------------------
> -----
>  drivers/dsp/bridge/wmd/_tiomap_pwr.h        |    4 ---
>  drivers/dsp/bridge/wmd/_tiomap_util.h       |    1 -
>  drivers/dsp/bridge/wmd/tiomap3430.c         |   10 ++++----
>  drivers/dsp/bridge/wmd/tiomap3430_pwr.c     |    4 +-
>  drivers/dsp/bridge/wmd/tiomap_sm.c          |    4 +-
>  6 files changed, 9 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-
> omap/include/dspbridge/util.h
> index 9d8842a..e6815ca 100644
> --- a/arch/arm/plat-omap/include/dspbridge/util.h
> +++ b/arch/arm/plat-omap/include/dspbridge/util.h
> @@ -26,7 +26,6 @@
>   *      UTIL_Exit
>   *      UTIL_GetSysInfo
>   *      UTIL_Init
> - *      UTIL_Wait
>   */
> 
>  #ifndef _UTIL_H
> @@ -120,36 +119,4 @@
>  		return true;
>  	}
> 
> -/*
> - *  ======== UTIL_Wait ========
> - *  Purpose:
> - *      This fucntion busy waits given a certain number of micro seconds
> - *      independent of the processor speed. This is acheived by the
> - *      OEM functions QueryPerformanceCounter and
> QueryPerformanceFrequency.
> - *  Parameters:
> - *      u32   Number of Micro seconds to busy wait
> - *  Returns:
> - *          Nothing
> - *  Requires:
> - *          UTIL_Initalized.
> - *  Ensures:
> - *      Busy waits x Micro seconds or Sleeps X milli seconds; in that
> - *      case, it is a blocking call there will be a context switching
> - *      hence it may not represent the absolute busy wait time.
> - */
> -	static inline void UTIL_Wait(IN u32 dwMicroSeconds)
> -	{
> -		if (dwMicroSeconds / 1000 <= 1) {
> -			/* <= 1 millisecond delay */
> -			udelay(dwMicroSeconds);
> -		} else if (dwMicroSeconds * HZ / 1000000 <= 1) {
> -			/* <= 10 millisecond delay */
> -			mdelay(dwMicroSeconds / 1000);
> -		} else {
> -			/* > 10 millisecond delay */
> -			set_current_state(TASK_INTERRUPTIBLE);
> -			schedule_timeout(dwMicroSeconds * HZ / 1000000);
> -		}
> -	}
> -
>  #endif				/* _UTIL_H */
> diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
> b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
> index 15ff2d3..8a7cf1b 100644
> --- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
> +++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
> @@ -28,10 +28,6 @@
>  #ifndef _TIOMAP_PWR_
>  #define _TIOMAP_PWR_
> 
> -/* Wait time between MBX and IDLE checks for PWR */
> -#define PWR_WAIT_USECS          500
> -#define PWR_WAIT_MSECS          50
> -
>  /*
>   * ======== WakeDSP =========
>   * Wakes up the DSP from DeepSleep
> diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h
> b/drivers/dsp/bridge/wmd/_tiomap_util.h
> index b655409..47e1e5d 100644
> --- a/drivers/dsp/bridge/wmd/_tiomap_util.h
> +++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
> @@ -30,7 +30,6 @@
> 
>  /* Time out Values in uSeconds*/
>  #define TIHELEN_ACKTIMEOUT  10000
> -#define TIHELEN_WRITE_DELAY 10
> 
>  /*  Time delay for HOM->SAM transition. */
>  #define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
> b/drivers/dsp/bridge/wmd/tiomap3430.c
> index 94ad786..670ca14 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -459,9 +459,9 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT
> *hDevContext,
>  		/* Reset and Unreset the RST2, so that BOOTADDR is copied to
>  		 * IVA2 SYSC register */
>  		HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
> -		UTIL_Wait(100);
> +		udelay(100);
>  		HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
> -		UTIL_Wait(100);
> +		udelay(100);
>  		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start 0 ****** \n");
>  		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
>  		/* Disbale the DSP MMU */
> @@ -736,7 +736,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT
> *hDevContext)
> 
>  			IO_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
> 
> -			UTIL_Wait(10000);	/* 10 msec */
> +			mdelay(10);
> 
>  			GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
> 
> @@ -1052,7 +1052,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct
> WMD_DEV_CONTEXT **ppDevContext,
>  				 "WMD_DEV_create:Reset mail box and "
>  				 "enable the clock Fail\n");
>  		}
> -		UTIL_Wait(5);
> +		udelay(5);
>  		/* 24xx-Linux MMU address is obtained from the host
>  		 * resources struct */
>  		pDevContext->dwDSPMmuBase = resources.dwDmmuBase;
> @@ -2171,7 +2171,7 @@ bool WaitForStart(struct WMD_DEV_CONTEXT
> *pDevContext, u32 dwSyncAddr)
> 
>  	/*  Wait for response from board */
>  	while (*((volatile u16 *)dwSyncAddr) && --usCount)
> -		UTIL_Wait(TIHELEN_WRITE_DELAY);
> +		udelay(10);
> 
>  	/*  If timed out: return FALSE */
>  	if (!usCount) {
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> index f3e7645..95a89b3 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -122,7 +122,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct
> WMD_DEV_CONTEXT *pDevContext)
>  	/* Wait for DSP to move into Off state,  how much time should
>  	 * we wait? */
>  	while ((pwrState != HW_PWR_STATE_OFF) && --usCount) {
> -		UTIL_Wait(PWR_WAIT_USECS);
> +		udelay(500);
>  		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
>  				    &pwrState);
>  	}
> @@ -243,7 +243,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT
> *pDevContext, IN u32 dwCmd,
>  	/* Wait for DSP to move into Standby state,  how much time
>  	 * should we wait?*/
>  	while ((pwrState != targetPwrState) && --usCount) {
> -		UTIL_Wait(PWR_WAIT_USECS);
> +		udelay(500);
>  		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
>  				    &pwrState);
>  	}
> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c
> b/drivers/dsp/bridge/wmd/tiomap_sm.c
> index 9bc5b54..2f381c8 100644
> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> @@ -120,7 +120,7 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct
> WMD_DEV_CONTEXT *hDevContext)
>  			hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
>  						    MBOX_ARM2DSP, &mbxValue);
>  			numMbxMsg--;
> -			UTIL_Wait(10);
> +			udelay(10);
> 
>  			HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
>  					  HW_MBOX_U1_DSP1,
> @@ -217,7 +217,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT
> *hDevContext)
>  		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
>  					   MBOX_ARM2DSP, &mbxFull);
>  		if (mbxFull)
> -			UTIL_Wait(1000);	/* wait for 1 ms)      */
> +			mdelay(1);
>  		else
>  			break;
>  	}
> --
> 1.6.1.3
> 

