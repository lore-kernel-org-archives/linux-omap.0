From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 7/7] DSPBRIDGE: remove WCD_Cmd structure
Date: Mon, 11 Jan 2010 19:09:10 -0600
Message-ID: <4B4BCBB6.1010702@ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com> <1263258041-16836-2-git-send-email-omar.ramirez@ti.com> <1263258041-16836-3-git-send-email-omar.ramirez@ti.com> <1263258041-16836-4-git-send-email-omar.ramirez@ti.com> <1263258041-16836-5-git-send-email-omar.ramirez@ti.com> <1263258041-16836-6-git-send-email-omar.ramirez@ti.com> <1263258041-16836-7-git-send-email-omar.ramirez@ti.com> <1263258041-16836-8-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48103 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315Ab0ALBJO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 20:09:14 -0500
In-Reply-To: <1263258041-16836-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Ramirez Luna, Omar had written, on 01/11/2010 07:00 PM, the following:
> Remove WCD_Cmd structure given that only one member is being
> used (fxn call), this structure is replaced for a definition
> of an array of function pointers for each dspbridge ioctl
> module.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
> CC: Ameya Palande <ameya.palande@nokia.com>
> CC: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |  134 +++++++++++++++++++---------------------
>  1 files changed, 64 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 27e8e8e..37d1f8a 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -147,12 +147,6 @@
>  /* Used to get dspbridge ioctl table */
>  #define DB_GET_IOC_TABLE(cmd)	(DB_GET_MODULE(cmd) >> DB_MODULE_SHIFT)
>  
> -/* Device IOCtl function pointer */
> -struct WCD_Cmd {
> -	u32(*fxn)(union Trapped_Args *args, void *pr_ctxt);
> -	u32 dwIndex;
> -} ;
> -
>  /*  ----------------------------------- Globals */
>  #if GT_TRACE
>  static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
> @@ -167,80 +161,80 @@ static u32 WCD_cRefs;
>   */
>  
>  /* MGR wrapper functions */
> -static struct WCD_Cmd mgr_cmd[] = {
> -	{MGRWRAP_EnumNode_Info},		/* MGR_ENUMNODE_INFO */
> -	{MGRWRAP_EnumProc_Info},		/* MGR_ENUMPROC_INFO */
> -	{MGRWRAP_RegisterObject},		/* MGR_REGISTEROBJECT */
> -	{MGRWRAP_UnregisterObject},		/* MGR_UNREGISTEROBJECT */
> -	{MGRWRAP_WaitForBridgeEvents},		/* MGR_WAIT */
> +static u32 (*mgr_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {

agreed that we dont need dwIndex anymore and struct wrapper is an 
overhead, but, just being a nitpick again, but is'nt typedef a necessary 
evil at this point to ensure that all cmd_ function pointers are of the 
same style for each of the arrays?

-- 
Regards,
Nishanth Menon
