From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox
 sysconfig
Date: Thu, 16 Jul 2009 01:37:13 +0300 (EEST)
Message-ID: <20090716.013713.102561568.Hiroshi.DOYU@nokia.com>
References: <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
	<496565EC904933469F292DDA3F1663E602A32025B9@dlee06.ent.ti.com>
	<4A5E51A7.6040907@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42042 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbZGOWhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 18:37:20 -0400
In-Reply-To: <4A5E51A7.6040907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: x0095840@ti.com, ameya.palande@nokia.com, linux-omap@vger.kernel.org, omar.ramirez@ti.com

From: ext Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
Date: Thu, 16 Jul 2009 00:01:11 +0200

> Guzman Lugo, Fernando had written, on 07/15/2009 04:59 PM, the following:
> >> diff --git a/drivers/dsp/bridge/hw/hw_mbox.c
> >> b/drivers/dsp/bridge/hw/hw_mbox.c
> >> index ee79032..5a87597 100644
> >> --- a/drivers/dsp/bridge/hw/hw_mbox.c
> >> +++ b/drivers/dsp/bridge/hw/hw_mbox.c
> >> @@ -33,7 +33,9 @@
> >>  /* width in bits of MBOX Id */
> >>  #define HW_MBOX_ID_WIDTH	   2
> >>
> >> -struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
> >> +static struct MAILBOX_CONTEXT mboxsetting = {
> >> +	.sysconfig = 2 << 3 | 1, /* SMART/AUTO-IDLE */
> >> +};
> >>
> >>  /* Saves the mailbox context */
> >>  HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
> >> diff --git a/drivers/dsp/bridge/hw/hw_mbox.h
> >> b/drivers/dsp/bridge/hw/hw_mbox.h
> >> index ad1a89c..8a5f6bd 100644
> >> --- a/drivers/dsp/bridge/hw/hw_mbox.h
> >> +++ b/drivers/dsp/bridge/hw/hw_mbox.h
> >> @@ -320,4 +320,9 @@ extern HW_STATUS HW_MBOX_saveSettings(void __iomem
> >> *baseAddres);
> >>  */
> >>  extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);
> >>
> >> +static inline void HW_MBOX_initSettings(void __iomem *baseAddres)
> >> +{
> >> +	HW_MBOX_restoreSettings(baseAddres);
> >> +}
> >> +
> >>  #endif  /* __MBOX_H */
> >> diff --git a/drivers/dsp/bridge/wmd/io_sm.c
> >> b/drivers/dsp/bridge/wmd/io_sm.c
> >> index 39c34f7..d8ae1f1 100644
> >> --- a/drivers/dsp/bridge/wmd/io_sm.c
> >> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> >> @@ -282,6 +282,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
> >>  		pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
> >>  		IO_DisableInterrupt(hWmdContext);
> >>  		if (devType == DSP_UNIT) {
> >> +			HW_MBOX_initSettings(hostRes.dwMboxBase);
> > 
> > What do think about doing a call to __raw_writel to avoid a new function wrapper as Omar suggested? Something like that:
> > 				
> > 			/* Enabling mailbox SMART/AUTO-IDLE */
> > 			__raw_writel(2 << 3 | 1, hostRes.dwMboxBase + 10);
> > 
> > 
> I think this is cleaner than piggybacking on the context save/restore 
> structure.

Hm....let me know your comment on my explanation in another reply.

> We should use macros though for 2<<3 | 1 etc.. just my 2Cents 
> for readability.

Agree.

Considering the encapsulation of hw_mbox to conceal the direct h/w
manipulation, introducing those macros for register bit definition
would be located in "hw_mbox.c", I guess.....


> 
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
