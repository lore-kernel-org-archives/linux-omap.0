From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [RFC] [PATCH 6/7] usb: ehci: Introduce CONFIG_USB_EHCI_HCD_OMAP3
Date: Fri, 20 Aug 2010 12:02:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324222BA9@dbde02.ent.ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
 <20100820054507.GE15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B65@dbde02.ent.ti.com>
 <20100820061322.GG15196@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab0HTGcJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 02:32:09 -0400
In-Reply-To: <20100820061322.GG15196@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> >> >@@ -126,6 +126,14 @@ config USB_EHCI_MXC
> >> > 	---help---
> >> > 	  Variation of ARC USB block used in some Freescale chips.
> >> >
> >> >+config USB_EHCI_HCD_OMAP3
> >> >+	bool "EHCI support for OMAP3 and later chips"
> >> >+	depends on USB_EHCI_HCD && (ARCH_OMAP3 || ARCH_OMAP4)
> >>
> >> this line doesn't scale. When we have another omap release this will
> >> become e.g. ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5 || ARCH_OMAP6 etc
> >> etc, so instead of depending on ARCH_OMAPX, depend only on ARCH_OMAP and
> >> make the architecture select the USB_ARCH_HAS_EHCI like this:
> >
> >ARCH_OMAP includes OMAP1/2, and these chips do not have any EHCI controllers.
> >
> >Is this okay?
> 
> as long as noone selects USB_ARCH_HAS_EHCI for omap1/2 it's fine.
> 

We have the ability to support OMAP2 and OMAP3 in the same kernel
image (for example when you build with omap3_defconfig).

So USB_ARCH_HAS_EHCI will get selected due to OMAP3 being present.

However, no platform devices will be registered in the OMAP2 board files,
so this should be okay (will try this on OMAP2 to check).

- Anand
