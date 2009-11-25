From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] usb: ehci: Allow EHCI to be built on OMAP3
Date: Wed, 25 Nov 2009 02:56:48 -0600
Message-ID: <20091125085648.GA30331@lixom.net>
References: <1257536793-15291-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:43693 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934054AbZKYIzn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 03:55:43 -0500
Content-Disposition: inline
In-Reply-To: <1257536793-15291-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, tony@atomide.com

OMAP34XX has EHCI, so select USB_ARCH_HAS_EHCI.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Sat, Nov 07, 2009 at 01:16:32AM +0530, Anand Gadiyar wrote:
> usb: ehci: Allow EHCI to be built on OMAP3
> 
> OMAP3 chips have a built-in EHCI controller.
> The recently introduced omap ehci-hcd driver missed
> out on selecting USB_ARCH_HAS_EHCI in Kconfig.
> 
> Without this, the driver cannot be built.

This is a losing battle. It scales much better to select the option
from OMAP34XX, instead of starting to enumerate the various platforms
in drivers/usb.


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 034d990..a913b05 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2430
 config ARCH_OMAP34XX
 	bool "OMAP34xx Based System"
 	depends on ARCH_OMAP3
+	select USB_ARCH_HAS_EHCI
 
 config ARCH_OMAP3430
 	bool "OMAP3430 support"
