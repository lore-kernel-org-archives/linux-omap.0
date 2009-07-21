From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable
 re-use
Date: Tue, 21 Jul 2009 10:01:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B59502D7@dbde02.ent.ti.com>
References: <1248096671-13828-1-git-send-email-balajitk@ti.com>
 <20090720185253.GA7984@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090720185253.GA7984@gandalf>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org] 
> Sent: Tuesday, July 21, 2009 12:23 AM
> To: Krishnamoorthy, Balaji T
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; 
> khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; 
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org; wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org; 
> timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; 
> lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org; broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org; 
> Shilimkar, Santosh; Nayak, Rajendra
> Subject: Re: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver 
> files to enable re-use
> 
> Hi,
> 
> On Mon, Jul 20, 2009 at 07:01:11PM +0530, balajitk-l0cyMroinI0@public.gmane.org wrote:
> > From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> > 
> > The upcoming TWL6030 is companion chip for OMAP4 like the 
> current TWL4030
> > for OMAP3. The common modules like RTC, Regulator creates 
> opportunity
> > to re-use the most of the code from twl4030.
> > 
> > This patch renames few common drivers twl4030* files to 
> twl* to enable
> > the code re-use.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
> >  arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
> >  arch/arm/mach-omap2/board-ldp.c                    |    2 +-
> >  arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
> >  arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
> >  arch/arm/mach-omap2/board-overo.c                  |    2 +-
> >  drivers/gpio/twl4030-gpio.c                        |    2 +-
> >  drivers/mfd/Makefile                               |    2 +-
> >  drivers/mfd/{twl4030-core.c => twl-core.c}         |    8 +++-----
> >  drivers/mfd/twl4030-irq.c                          |    2 +-
> >  drivers/regulator/Makefile                         |    2 +-
> >  .../{twl4030-regulator.c => twl-regulator.c}       |    6 +++---
> >  drivers/rtc/Makefile                               |    2 +-
> >  drivers/rtc/{rtc-twl4030.c => rtc-twl.c}           |    2 +-
> >  drivers/usb/otg/twl4030-usb.c                      |    2 +-
> >  include/linux/i2c/{twl4030.h => twl.h}             |    5 ++++-
> >  sound/soc/codecs/twl4030.c                         |    2 +-
> 
> this is kinda useless, we can consider twl6030 as being sw compatible
> (almost) with twl4030. And twl4030 driver already support plenty of
> other devices, just look at drivers/mfd/twl4030-core.c lines 
> 807 - 814.
> We have twl4003, twl5030, tps65950, tps65930 and tps65920.
> 
> So IMO, renaming the files is unnecessary.
Well tps* are just catalog names of the twl4* family. So you can keep adding whatever names there as long it's a same IC.

Perhaps you look in hurry to comment about this. Please look at the intention of these patches. TWL6030 has PM IC similar to TWL4030 with bit different interrupt management. Audio IC is a separate one as compared to combined in case of TWL4030.

If it allows code re-use by renaming files, it should be good. Isn't it ? --
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
