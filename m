From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Fri, 13 Feb 2009 14:21:00 -0800
Message-ID: <20090213222100.GJ7562@atomide.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58303 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZBMWVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 17:21:03 -0500
Content-Disposition: inline
In-Reply-To: <20090213085827.d516d6aa.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jarkko Nikula <jarkko.nikula@nokia.com> [090212 22:58]:
> On Thu, 12 Feb 2009 15:10:29 +0100
> "Shargorodsky Atal (EXT-Teleca/Helsinki)"
> <ext-atal.shargorodsky@nokia.com> wrote:
> 
> > This patch allows I2C_OMAP to be compiled as a module.
> > Only drivers/i2c/busses/i2c-omap.c can be compiled as a module,
> > but not arch/arm/plat-omap/i2c.c , so let the contents of i2c.c
> > to compile into the kernel if either I2C_OMAP was selected to compile
> > in or as a module.
> > 
> > Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
> > ---
> >  arch/arm/plat-omap/Makefile |    3 +--
> >  arch/arm/plat-omap/i2c.c    |    4 ++++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> Tony,
> 
> You can add this to your 2.6.29-rc series since the same build error is
> in mainline as well if CONFIG_I2C_OMAP=m.
> 
>   Building modules, stage 2.
>   GZIP    arch/arm/boot/compressed/piggy.gz
>   MODPOST 6 modules
> ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Subject needs a "ARM: OMAP: " prefix, otherwise ok from me.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Sounds like a fix, except I posted a shorter version of the patch that
should do the trick (untested). Attached here too for reference.

Tony

--ncSAzJYg3Aa9+CRW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-omap-module.patch"

--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -21,7 +21,10 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
+
+ifneq ($(CONFIG_I2C_OMAP),)
+	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
+endif
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o

--ncSAzJYg3Aa9+CRW--
