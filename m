From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Mon, 25 Jan 2010 10:59:07 -0600
Message-ID: <4B5DCDDB.10409@ti.com>
References: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59302 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab0AYQ7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jan 2010 11:59:40 -0500
In-Reply-To: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "mika.kukkonen@nokia.com" <mika.kukkonen@nokia.com>

Patch looks good, just one question:

> This patch contains indentation fixes and cleans up various warnings
> uncovered with extra warning flags:
>
>   - empty if() bodies

am i missing something? which hunk fix this?

>   - incorrect use of unsigned variables
>   - bad comparison of pointer value
>   - pointless check of unsigned value being smaller than zero
>   - keyword 'extern' has to be first one in variable declaration
>
> Signed-off-by: Mika Kukkonen <mika.kukkonen@nokia.com>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +++---
>  arch/arm/plat-omap/include/dspbridge/dbg.h |    4 ++--
>  arch/arm/plat-omap/include/dspbridge/gt.h  |   16 +++++++++-------
>  arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
>  drivers/dsp/bridge/wmd/io_sm.c             |    2 +-
>  drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
>  6 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
> index ac5d178..1b3ac44 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
> @@ -43,9 +43,9 @@
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
> diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
> index 2f61dab..4d01eca 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dbg.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
> @@ -80,9 +80,9 @@
>  	extern DSP_STATUS DBG_Trace(IN u8 bLevel, IN char *pstrFormat, ...);
>  #else
>
> -#define DBG_Exit(void)
> +#define DBG_Exit(void) do {} while (0)
>  #define DBG_Init(void) true
> -#define DBG_Trace(bLevel, pstrFormat, args...)
> +#define DBG_Trace(bLevel, pstrFormat, args...) do {} while (0)
>
>  #endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
> index 6082d15..9097910 100644
> --- a/arch/arm/plat-omap/include/dspbridge/gt.h
> +++ b/arch/arm/plat-omap/include/dspbridge/gt.h
> @@ -252,13 +252,15 @@ extern struct GT_Config _GT_params;
>
>  #define GT_query(mask, class)     false
>
> -#define GT_0trace(mask, class, format)
> -#define GT_1trace(mask, class, format, arg1)
> -#define GT_2trace(mask, class, format, arg1, arg2)
> -#define GT_3trace(mask, class, format, arg1, arg2, arg3)
> -#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4)
> -#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5)
> -#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6)
> +#define GT_0trace(mask, class, format) do {} while (0)
> +#define GT_1trace(mask, class, format, arg1) do {} while (0)
> +#define GT_2trace(mask, class, format, arg1, arg2) do {} while (0)
> +#define GT_3trace(mask, class, format, arg1, arg2, arg3) do {} while (0)
> +#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4) do {} while (0)
> +#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5) \
> +	do {} while (0)
> +#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6) \
> +	do {} while (0)
>
>  #else				/* GT_TRACE == 1 */
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
> index 03b419a..353ffb0 100644
> --- a/arch/arm/plat-omap/include/dspbridge/mem.h
> +++ b/arch/arm/plat-omap/include/dspbridge/mem.h
> @@ -286,7 +286,7 @@
>   *  Ensures:
>   *      - pBaseAddr no longer points to a valid linear address.
>   */
> -#define MEM_UnmapLinearAddress(pBaseAddr)
> +#define MEM_UnmapLinearAddress(pBaseAddr) {}
>
>  /*
>   *  ======== MEM_ExtPhysPoolInit ========
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
> index e35ce57..64eba5a 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -1210,7 +1210,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
>  			    pChnlMgr->uWordSize;
>  	chnlId = IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputId);
>  	dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, sm, arg);
> -	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
> +	if (chnlId >= CHNL_MAXCHANNELS) {
>  		/* Shouldn't be here: would indicate corrupted SHM. */
>  		DBC_Assert(chnlId);
>  		goto func_end;
> diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
> index 6166d97..2c3a2cd 100644
> --- a/drivers/dsp/bridge/wmd/ue_deh.c
> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> @@ -189,7 +189,7 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
>  	DSP_STATUS status = DSP_SOK;
>  	u32 memPhysical = 0;
>  	u32 HW_MMU_MAX_TLB_COUNT = 31;
> -	u32 extern faultAddr;
> +	extern u32 faultAddr;
>  	struct CFG_HOSTRES resources;
>  	HW_STATUS hwStatus;
>
> -- 1.6.3.3

- omar
