From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Smart Card(SC) interface, TI USIM & NxP SC phy
 driver
Date: Thu, 30 Jan 2014 05:05:15 -0800
Message-ID: <20140130130515.GC23970@kroah.com>
References: <1390192434-19386-1-git-send-email-satish.patel@ti.com>
 <52E9E8B0.2020000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52E9E8B0.2020000-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 30, 2014 at 11:22:48AM +0530, Satish Patel wrote:
> 
> On 1/20/2014 10:03 AM, Satish Patel wrote:
> > Changes from v1:
> > * RFC(v1) comments are fixed
> >
> > ** removed "gpio_to_irq" as GPIO controller process  cell from DT and
> > give it to DT node
> > ** comments on documentation
> > ** few other comments on null checks are resolved
> >
> > * BWT timing configuration is added to ti-usim driver
> >
> > v1 cover letter link#
> > https://lkml.org/lkml/2014/1/6/250
> >
> > Satish Patel (5):
> >   sc_phy:SmartCard(SC) PHY interface to SC controller
> >   misc: tda8026: Add NXP TDA8026 PHY driver
> >   char: ti-usim: Add driver for USIM module on AM43xx
> >   ARM: dts: AM43xx: DT entries added for ti-usim
> >   ARM: dts: AM43xx-epos-evm: DT entries  for ti-usim and phy
> >
> >  Documentation/devicetree/bindings/misc/tda8026.txt |   19 +
> >  .../devicetree/bindings/ti-usim/ti-usim.txt        |   31 +
> >  Documentation/sc_phy.txt                           |  171 ++
> >  arch/arm/boot/dts/am4372.dtsi                      |   10 +
> >  arch/arm/boot/dts/am43x-epos-evm.dts               |   43 +
> >  drivers/char/Kconfig                               |    7 +
> >  drivers/char/Makefile                              |    1 +
> >  drivers/char/ti-usim-hw.h                          |  863 +++++++++
> >  drivers/char/ti-usim.c                             | 1859 ++++++++++++++++++++
> >  drivers/misc/Kconfig                               |    7 +
> >  drivers/misc/Makefile                              |    1 +
> >  drivers/misc/tda8026.c                             | 1255 +++++++++++++
> >  include/linux/sc_phy.h                             |  132 ++
> >  include/linux/ti-usim.h                            |   98 +
> >  14 files changed, 4497 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/misc/tda8026.txt
> >  create mode 100644 Documentation/devicetree/bindings/ti-usim/ti-usim.txt
> >  create mode 100644 Documentation/sc_phy.txt
> >  create mode 100644 drivers/char/ti-usim-hw.h
> >  create mode 100644 drivers/char/ti-usim.c
> >  create mode 100644 drivers/misc/tda8026.c
> >  create mode 100644 include/linux/sc_phy.h
> >  create mode 100644 include/linux/ti-usim.h
> Any comments on this patch series ?
> 
> If not,
> Can you accept these patches for next merge window

It's the middle of this merge window, and I can't accept any patches
until after 3.14-rc1 is out, at which point I'll start to work on my
patch backlog.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
