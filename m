From: "Girish S G" <girishsg@ti.com>
Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Mon, 19 Oct 2009 13:26:55 -0500
Message-ID: <00f901ca50e9$bcb1a040$841018ac@am.dhcp.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com> <1255690150-16853-2-git-send-email-tero.kristo@nokia.com> <004e01ca4e84$5d0aa9f0$3d1018ac@am.dhcp.ti.com> <1F18D6510CF0474A8C9500565A7E41A210F69EEF6F@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51458 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757160AbZJSS07 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 14:26:59 -0400
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A210F69EEF6F@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Tero.Kristo@nokia.com [mailto:Tero.Kristo@nokia.com]
> Sent: Monday, October 19, 2009 4:23 AM
> To: girishsg@ti.com; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2

> >
> >Agree, IVA2 pwrdm is handled autonomously by bridge. I think
> >this needs some additional change to remove all the redundant
> >configuration of iva pwdm. There are some inconsistencies like,
> >	- Say enable_off_mode is disabled. Before doing system
> >wide suspend if DSP hibernates then IVA2 will be put to OFF. In that
> >case we have IVA2 going to OFF and other domains in RET. This
> >might not be an issue, but it's bad from sytem PM framework integrity
> >perspective.
> 
> This is an issue with bridge driver, and I am not sure how this should be fixed. Currently bridge
> driver does not care whether off mode is enabled or not.

I have seen bridge considering enable_off_mode flag in suspend/resume path. But while hibernation (idle timeout) it goes to OFF,
irrespective of the OFF flag.

> 
> >	- enable_off_mode->omap3_pm_off_mode_enable will also
> >touch IVA2 power domain next state. This we don't want to do if dsp
> >bridge is already taking care of IVA2.
> >
> >IMO, we need to have some mechanism wherein if bridge PM takes
> >care of IVA then PM framework should not configure the IVA
> >powerstate. It should only do if bridge PM is disabled.
> 
> Should we have a Kconfig option for this? Like CONFIG_OMAP3_BRIDGE_PM, and disable all iva2 controls
> from pm34xx.c if it is enabled? Otherwise control IVA2 as currently done.

Yes, this looks ok to me.


-Girish

