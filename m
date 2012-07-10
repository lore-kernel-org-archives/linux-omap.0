From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers/rtc/rtc-twl.c: fix threaded IRQ to use
 IRQF_ONESHOT
Date: Tue, 10 Jul 2012 12:54:19 +0100
Message-ID: <20120710115418.GA2280@sirena.org.uk>
References: <1341592434-4207-1-git-send-email-khilman@ti.com>
 <20120709151527.58f44c3a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120709151527.58f44c3a.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kevin Hilman <khilman@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 09, 2012 at 03:15:27PM -0700, Andrew Morton wrote:

> OK, this is the second such patch I've seen and it's time to wonder if
> we should get grumpy at tglx.  afacit 1c6c6952 broke the following
> drivers:

> sound/soc/codecs/wm8994.c
> drivers/mfd/wm831x-auxadc.c
> drivers/mfd/wm8350-core.c
> drivers/regulator/wm831x-isink.c
> drivers/regulator/wm831x-ldo.c
> drivers/regulator/wm831x-dcdc.c
> drivers/input/misc/wm831x-on.c

> what am I missing here?

At least the above (and possibly a good proportion of the others from
the looks of things) aren't affected by this change because they are
nested IRQs for MFDs where we can guarantee that there will never be a
primary IRQ.  _ONESHOT shouldn't make any odds in these situations.

> drivers/base/regmap/regmap-irq.c

This is using irq_flags passed in by the caller so should be unaffected,
it's always been the responsibility of the caller to set the flags.
