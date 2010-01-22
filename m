From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/7] usb: musb: Add context save and restore support
Date: Fri, 22 Jan 2010 22:18:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F11BC@dbde02.ent.ti.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
 <1264080838-9452-2-git-send-email-felipe.balbi@nokia.com>
 <FCCFB4CDC6E5564B9182F639FC35608703007F229A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874Ab0AVQs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 11:48:28 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703007F229A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> >+#ifdef CONFIG_PM
> >+void musb_platform_save_context(struct musb_context_registers
> >+		*musb_context)
> >+{
> >+	musb_context->otg_sysconfig = omap_readl(OTG_SYSCONFIG);
> >+	musb_context->otg_forcestandby = omap_readl(OTG_FORCESTDBY);
> 
> Any reason not to store: OTG_INTERFSEL
> Depending on reset value is not a good idea.
> 

Good point - on OMAP3, it would not matter, but on OMAP4 for
sure, this is configurable for multiple modes.

Someone care to spin a patch later?

- Anand
