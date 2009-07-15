From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox
 sysconfig
Date: Wed, 15 Jul 2009 16:59:22 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A32025B9@dlee06.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38181 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbZGOV7c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 17:59:32 -0400
In-Reply-To: <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>


Hi,

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Wednesday, July 15, 2009 9:56 AM
> To: linux-omap@vger.kernel.org
> Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Menon, Nishanth;
> hiroshi.doyu@nokia.com
> Subject: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox
> sysconfig
> 
> From: Doyu Hiroshi (Nokia-D/Helsinki) <hiroshi.doyu@nokia.com>
> 
> Reported-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/bridge/hw/hw_mbox.c |    4 +++-
>  drivers/dsp/bridge/hw/hw_mbox.h |    5 +++++
>  drivers/dsp/bridge/wmd/io_sm.c  |    1 +
>  3 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c
> b/drivers/dsp/bridge/hw/hw_mbox.c
> index ee79032..5a87597 100644
> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> @@ -33,7 +33,9 @@
>  /* width in bits of MBOX Id */
>  #define HW_MBOX_ID_WIDTH	   2
> 
> -struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
> +static struct MAILBOX_CONTEXT mboxsetting = {
> +	.sysconfig = 2 << 3 | 1, /* SMART/AUTO-IDLE */
> +};
> 
>  /* Saves the mailbox context */
>  HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h
> b/drivers/dsp/bridge/hw/hw_mbox.h
> index ad1a89c..8a5f6bd 100644
> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> @@ -320,4 +320,9 @@ extern HW_STATUS HW_MBOX_saveSettings(void __iomem
> *baseAddres);
>  */
>  extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);
> 
> +static inline void HW_MBOX_initSettings(void __iomem *baseAddres)
> +{
> +	HW_MBOX_restoreSettings(baseAddres);
> +}
> +
>  #endif  /* __MBOX_H */
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c
> b/drivers/dsp/bridge/wmd/io_sm.c
> index 39c34f7..d8ae1f1 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -282,6 +282,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>  		pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
>  		IO_DisableInterrupt(hWmdContext);
>  		if (devType == DSP_UNIT) {
> +			HW_MBOX_initSettings(hostRes.dwMboxBase);

What do think about doing a call to __raw_writel to avoid a new function wrapper as Omar suggested? Something like that:
				
			/* Enabling mailbox SMART/AUTO-IDLE */
			__raw_writel(2 << 3 | 1, hostRes.dwMboxBase + 10);


>  			/* Plug the channel ISR:. */
>  			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
>  				"DspBridge\tmailbox", (void *)pIOMgr)) == 0)
> --
> 1.6.2.4
> 

Regards,
Fernando
Guzman
Lugo.

