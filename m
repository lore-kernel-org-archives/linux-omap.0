From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [Patch 8/8] DSPBRIDGE: typedef cleanup -CHNL_MODE
Date: Fri, 5 Feb 2010 16:32:54 -0600
Message-ID: <4B6C9C96.3010900@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A6B9678@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933852Ab0BEWcz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Feb 2010 17:32:55 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o15MWt8t023946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:32:55 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o15MWsxv018152
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:32:54 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o15MWsfK023556
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:32:54 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A6B9678@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

On 2/2/2010 6:44 PM, Hebbar, Shivananda wrote:
>  From 23b8b63a9f57c20b3f87ac886623d227d5448e8f Mon Sep 17 00:00:00 2001
> From: Shivananda Hebbar<x0hebbar@ti.com>
> Date: Thu, 28 Jan 2010 20:53:48 -0600
> Subject: [PATCH] DSPBRIDGE: Remove typedef CHNL_MODE and replace it with
>   	   normal C type
>
> This patch removes the typedef CHNL_MODE.
> CHNL_MODE values are well within the range of short int.
> Hence changing it from u32 type to short int.
>
> Signed-off-by: Shivananda Hebbar<x0hebbar@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/chnldefs.h |    2 --
>   arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/wmdchnl.h  |    2 +-
>   drivers/dsp/bridge/rmgr/node.c                  |    2 +-
>   drivers/dsp/bridge/rmgr/strm.c                  |    2 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c                |    8 ++++----
>   6 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/dspbridge/chnldefs.h b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
> index be405ba..43df8b7 100644
> --- a/arch/arm/plat-omap/include/dspbridge/chnldefs.h
> +++ b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
> @@ -45,8 +45,6 @@
>   #define CHNL_IsIOCancelled(ioc) (ioc.status&  CHNL_IOCSTATCANCEL)
>   #define CHNL_IsTimedOut(ioc)    (ioc.status&  CHNL_IOCSTATTIMEOUT)
>
> -/* CHNL types: */
> -	typedef u32 CHNL_MODE;	/* Channel transfer mode.         */
>
>   /* Channel attributes: */
>   	struct CHNL_ATTRS {
> diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
> index 70f3970..95c79f2 100644
> --- a/arch/arm/plat-omap/include/dspbridge/wmd.h
> +++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
> @@ -418,7 +418,7 @@ typedef DSP_STATUS(*WMD_BRD_WRITE)(struct WMD_DEV_CONTEXT *hDevContext,
>          typedef DSP_STATUS(*WMD_CHNL_OPEN) (OUT struct CHNL_OBJECT
>   						   **phChnl,
>   						   struct CHNL_MGR *hChnlMgr,
> -						   CHNL_MODE uMode,
> +						   short int chnlMode,

changing name of variable breaks compilation

>   						   u32 uChnlId,
>   						   CONST IN OPTIONAL struct
>   						   CHNL_ATTRS *pAttrs);
> diff --git a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
> index 4b733d8..9e73516 100644
> --- a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
> +++ b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
> @@ -33,7 +33,7 @@
>
>   	extern DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
>   					struct CHNL_MGR *hChnlMgr,
> -					CHNL_MODE uMode,
> +					short int chnlMode,
>   					u32 uChnlId,
>   					CONST IN OPTIONAL struct CHNL_ATTRS
>   					*pAttrs);
> diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index 5352923..538c806 100644
> --- a/drivers/dsp/bridge/rmgr/node.c
> +++ b/drivers/dsp/bridge/rmgr/node.c
> @@ -895,7 +895,7 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
>   	struct STREAM *pStream;
>   	GB_BitNum pipeId = GB_NOBITS;
>   	GB_BitNum chnlId = GB_NOBITS;
> -	CHNL_MODE uMode;
> +	short int uMode;
>   	u32 dwLength;
>   	DSP_STATUS status = DSP_SOK;
>   	DBC_Require(cRefs>  0);
> diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c index febb6c2..f03064e 100644
> --- a/drivers/dsp/bridge/rmgr/strm.c
> +++ b/drivers/dsp/bridge/rmgr/strm.c
> @@ -524,7 +524,7 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
>   	struct WMD_DRV_INTERFACE *pIntfFxns;
>   	u32 ulChnlId;
>   	struct STRM_OBJECT *pStrm = NULL;
> -	CHNL_MODE uMode;
> +	short int uMode;
>   	struct CHNL_ATTRS chnlAttrs;
>   	DSP_STATUS status = DSP_SOK;
>   	struct CMM_OBJECT *hCmmMgr = NULL;	/* Shared memory manager hndl */
> diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
> index ca5662d..5d3f71e 100644
> --- a/drivers/dsp/bridge/wmd/chnl_sm.c
> +++ b/drivers/dsp/bridge/wmd/chnl_sm.c
> @@ -253,7 +253,7 @@ DSP_STATUS WMD_CHNL_CancelIO(struct CHNL_OBJECT *hChnl)
>   	DSP_STATUS status = DSP_SOK;
>   	struct CHNL_OBJECT *pChnl = (struct CHNL_OBJECT *)hChnl;
>   	u32 iChnl = -1;
> -	CHNL_MODE uMode;
> +	short int chnlMode;

here

>   	struct CHNL_IRP *pChirp;
>   	struct CHNL_MGR *pChnlMgr = NULL;
>
> @@ -483,7 +483,7 @@ DSP_STATUS WMD_CHNL_FlushIO(struct CHNL_OBJECT *hChnl, u32 dwTimeOut)  {
>   	DSP_STATUS status = DSP_SOK;
>   	struct CHNL_OBJECT *pChnl = (struct CHNL_OBJECT *)hChnl;
> -	CHNL_MODE uMode = -1;
> +	short int chnlMode = -1;

and here

>   	struct CHNL_MGR *pChnlMgr;
>   	struct CHNL_IOC chnlIOC;
>   	/* Check args:  */
> @@ -758,7 +758,7 @@ DSP_STATUS WMD_CHNL_GetMgrInfo(struct CHNL_MGR *hChnlMgr, u32 uChnlID,  DSP_STATUS WMD_CHNL_Idle(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
>   			 bool fFlush)
>   {
> -	CHNL_MODE uMode;
> +	short int uMode;
>   	struct CHNL_MGR *pChnlMgr;
>   	DSP_STATUS status = DSP_SOK;
>
> @@ -786,7 +786,7 @@ DSP_STATUS WMD_CHNL_Idle(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
>    *      Open a new half-duplex channel to the DSP board.
>    */
>   DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
> -			 struct CHNL_MGR *hChnlMgr, CHNL_MODE uMode,
> +			 struct CHNL_MGR *hChnlMgr, short int chnlMode,

and here

>   			 u32 uChnlId, CONST IN struct CHNL_ATTRS *pAttrs)  {
>   	DSP_STATUS status = DSP_SOK;
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- omar
