From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 00/23] twl4030 patches (v3)
Date: Mon, 29 Sep 2008 13:59:34 -0700
Message-ID: <200809291359.34589.david-b@pacbell.net>
References: <1222705669-18230-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:44145 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752055AbYI2U7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 16:59:37 -0400
In-Reply-To: <1222705669-18230-1-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Well I can confirm that this is stuff I've seen to behave OK,
by diffing the patches against known-working versions.  There
were Overo differences, and some keymap things.

Patch 0002 (don't zero pullup/pulldown configuration) is still
missing the ACK I sent when it first came though.  :)


On the other hand, building against the tarball of patches
you sent gives me:

arch/arm/mach-omap2/board-overo.c:154: error: variable 'overo_usb_data' has initializer but incomplete type
arch/arm/mach-omap2/board-overo.c:155: error: unknown field 'usb_mode' specified in initializer
arch/arm/mach-omap2/board-overo.c:155: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-overo.c:155: warning: (near initialization for 'overo_usb_data')
arch/arm/mach-omap2/board-overo.c:162: warning: initialization from incompatible pointer type
make[1]: *** [arch/arm/mach-omap2/board-overo.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2
make: *** Waiting for unfinished jobs....
  CC      arch/arm/plat-omap/i2c.o

---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -151,7 +151,7 @@ static struct twl4030_gpio_platform_data
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
-static struct twl4030_usb_platform_data overo_usb_data = {
+static struct twl4030_usb_data overo_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
