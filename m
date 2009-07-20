From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable
 re-use
Date: Mon, 20 Jul 2009 21:52:54 +0300
Message-ID: <20090720185253.GA7984@gandalf>
References: <1248096671-13828-1-git-send-email-balajitk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753361AbZGTSxN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1248096671-13828-1-git-send-email-balajitk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balajitk@ti.com
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jul 20, 2009 at 07:01:11PM +0530, balajitk@ti.com wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> for OMAP3. The common modules like RTC, Regulator creates opportunity
> to re-use the most of the code from twl4030.
> 
> This patch renames few common drivers twl4030* files to twl* to enable
> the code re-use.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-ldp.c                    |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
>  arch/arm/mach-omap2/board-overo.c                  |    2 +-
>  drivers/gpio/twl4030-gpio.c                        |    2 +-
>  drivers/mfd/Makefile                               |    2 +-
>  drivers/mfd/{twl4030-core.c => twl-core.c}         |    8 +++-----
>  drivers/mfd/twl4030-irq.c                          |    2 +-
>  drivers/regulator/Makefile                         |    2 +-
>  .../{twl4030-regulator.c => twl-regulator.c}       |    6 +++---
>  drivers/rtc/Makefile                               |    2 +-
>  drivers/rtc/{rtc-twl4030.c => rtc-twl.c}           |    2 +-
>  drivers/usb/otg/twl4030-usb.c                      |    2 +-
>  include/linux/i2c/{twl4030.h => twl.h}             |    5 ++++-
>  sound/soc/codecs/twl4030.c                         |    2 +-

this is kinda useless, we can consider twl6030 as being sw compatible
(almost) with twl4030. And twl4030 driver already support plenty of
other devices, just look at drivers/mfd/twl4030-core.c lines 807 - 814.
We have twl4003, twl5030, tps65950, tps65930 and tps65920.

So IMO, renaming the files is unnecessary.

-- 
balbi
