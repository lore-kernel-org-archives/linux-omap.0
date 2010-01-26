From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Use enable_off_mode variable instead of
 dsp_test_sleepstate
Date: Tue, 26 Jan 2010 16:23:13 -0600
Message-ID: <4B5F6B51.6050607@ti.com>
References: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com> <1264241986-29071-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37169 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab0AZWXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 17:23:22 -0500
In-Reply-To: <1264241986-29071-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi,

On 1/23/2010 4:19 AM, Felipe Contreras wrote:
> From: Jouni Hogander<jouni.hogander@nokia.com>
>
> Signed-off-by: Jouni Hogander<jouni.hogander@nokia.com>
> Signed-off-by: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>

This patch is missing to export enable_off_mode otherwise it will fail 
while linking.

FTR, I don't like to be exporting symbols of other subsystems, guess the 
same applies to:

http://marc.info/?l=linux-omap&m=126450677527042&w=2

> ---
>   drivers/dsp/bridge/rmgr/drv_interface.c |    5 -----
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    9 ++++-----
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index a02a32a..b20f77e 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -78,8 +78,6 @@ s32 dsp_debug;
>
>   struct platform_device *omap_dspbridge_dev;
>
> -/* This is a test variable used by Bridge to test different sleep states */
> -s32 dsp_test_sleepstate;
>   struct bridge_dev {
>   	struct cdev cdev;
>   };
> @@ -129,9 +127,6 @@ module_param(dsp_debug, int, 0);
>   MODULE_PARM_DESC(dsp_debug, "Wait after loading DSP image. default = false");
>   #endif
>
> -module_param(dsp_test_sleepstate, int, 0);
> -MODULE_PARM_DESC(dsp_test_sleepstate, "DSP Sleep state = 0");
> -
>   module_param(base_img, charp, 0);
>   MODULE_PARM_DESC(base_img, "DSP base image, default = NULL");
>
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> index 084f406..c0e0994 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -54,10 +54,9 @@
>   #include<mach-omap2/cm-regbits-34xx.h>
>
>   #ifdef CONFIG_PM
> -extern s32 dsp_test_sleepstate;
> +extern unsigned short enable_off_mode;
>   #endif
>   extern struct MAILBOX_CONTEXT mboxsetting;
> -
>   /*
>    *  ======== handle_constraints_set ========
>    *  	Sets new DSP constraint
> @@ -196,7 +195,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
>   	switch (pDevContext->dwBrdState) {
>   	case BRD_RUNNING:
>   		status = HW_MBOX_saveSettings(resources.dwMboxBase);
> -		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
> +		if (enable_off_mode) {
>   			CHNLSM_InterruptDSP2(pDevContext,
>   					     MBX_PM_DSPHIBERNATE);
>   			DBG_Trace(DBG_LEVEL7,
> @@ -211,7 +210,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
>   		break;
>   	case BRD_RETENTION:
>   		status = HW_MBOX_saveSettings(resources.dwMboxBase);
> -		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
> +		if (enable_off_mode) {
>   			CHNLSM_InterruptDSP2(pDevContext,
>   					     MBX_PM_DSPHIBERNATE);
>   			targetPwrState = HW_PWR_STATE_OFF;
> @@ -261,7 +260,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
>   			 pwrState);
>
>   		/* Update the Bridger Driver state */
> -		if (dsp_test_sleepstate == HW_PWR_STATE_OFF)
> +		if (enable_off_mode)
>   			pDevContext->dwBrdState = BRD_HIBERNATION;
>   		else
>   			pDevContext->dwBrdState = BRD_RETENTION;

- omar
