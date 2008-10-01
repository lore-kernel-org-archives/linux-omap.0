From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Wed, 1 Oct 2008 09:32:20 -0700
Message-ID: <200810010932.20966.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200810010858.13612.david-b@pacbell.net> <20081001180536.3084b730@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39762 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752516AbYJAQcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 12:32:23 -0400
In-Reply-To: <20081001180536.3084b730@hyperion.delvare>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wednesday 01 October 2008, Jean Delvare wrote:
> On Wed, 1 Oct 2008 08:58:12 -0700, David Brownell wrote:
> > On Wednesday 01 October 2008, Felipe Contreras wrote:
> > > Hmm, I'm seeing two different configs:
> > > CONFIG_TWL4030_GPIO
> > > CONFIG_GPIO_TWL4030
> > > 
> > > I guess the defconfigs are wrong.
> > 
> > Right, they should get fixed.
> > 
> > The same issue will come when drivers/i2c/chips/twl4030-core.c
> > moves to drivers/mfd/twl4030-core.c (...)
> 
> Yes, please! I think I'll kill drivers/i2c/chips soon.

But in the OMAP tree it's still chock-full of goodness:

~/kernel/beagle/drivers/i2c/chips$ ls
at24.c                Kconfig     pca9539.c      tps65010.c      twl4030-power.c
ds1682.c              lp5521.c    pcf8574.c      tsl2550.c       twl4030-poweroff.c
eeprom.c              Makefile    pcf8575.c      tsl2563.c       twl4030-pwrbutton.c
gpio_expander_omap.c  max6875.c   pcf8591.c      twl4030-core.c  twl4030-pwrirq.c
isp1301_omap.c        menelaus.c  tlv320aic23.c  twl4030-madc.c  twl4030-usb.c
~/kernel/beagle/drivers/i2c/chips$ 

So it's not yet ready to be removed ... at least there.  ;)

Although I certainly agree all that twl4030 [1] stuff should move.
It just takes time.

(Quick audit:   the AIC23 seems nearly ready to move to ALSA.
pcf8574/pcf8575/pca9539 have drivers/gpio versions, and that
gpio_expander_omap is yet another pcf8574 helper.  I'm not
sure the LED framework is ready for lp5521 yet (programmable
RGB led support).

- Dave

[1] same as http://focus.ti.com/docs/prod/folders/print/tps65950.html
    fyi ... programming manuals not yet public, but that data sheet
    may be interesting to you for a quick skim (8 pages).  As I2C
    chips go, it's quite powerful; block diagram on page 2.  ;)


