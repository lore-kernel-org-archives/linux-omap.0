From: Venkatraman S <svenkatr@ti.com>
Subject: configuration warnings with omap_3630sdp_defconfig in 2.6.35-rc5
Date: Tue, 20 Jul 2010 15:52:08 +0530
Message-ID: <AANLkTimh0MBzANu1rmLb7q1tYQMywznQd5DJ_mUKp_cZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64190 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0GTKWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 06:22:12 -0400
Received: by iwn7 with SMTP id 7so5621181iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Jul 2010 03:22:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

While trying to build omap_3630sdp_defconfig on Linus's 2.6.35-rc5, I
get these warnings..
I understand these could be related to the recent defconfig changes.
I will try to investigate; posted here to know if anyone has found a
fix already..
------------------------------
scripts/kconfig/conf -s arch/arm/Kconfig
can't copy type 0
warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC ||
USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL)
selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP
&& ARCH_OMAP_OTG && USB_OHCI_HCD)
warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC ||
USB_MUSB_OTG && <choice> && USB && USB_GADGET && PM && EXPERIMENTAL)
selects USB_OTG which has unmet direct dependencies (USB_GADGET_OMAP
&& ARCH_OMAP_OTG && USB_OHCI_HCD)
------------------------------

Regards,
Venkat.
