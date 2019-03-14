From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Thu, 14 Mar 2019 07:18:53 -0500
Message-ID: <CAHCN7x+KeHBYH-QxAsRNL2KB_qDud2LTqdtjC4FZ08KvxGtEdA@mail.gmail.com>
References: <20181221011752.25627-1-sre@kernel.org> <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-media@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 14, 2019 at 3:21 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Sebastian,
>
> On 12/21/18 2:17 AM, Sebastian Reichel wrote:
> > Hi,
> >
> > This moves all remaining users of the legacy TI_ST driver to hcill (patches
> > 1-3). Then patches 4-7 convert wl128x-radio driver to a standard platform
> > device driver with support for multiple instances. Patch 7 will result in
> > (userless) TI_ST driver no longer supporting radio at runtime. Patch 8-11 do
> > some cleanups in the wl128x-radio driver. Finally patch 12 removes the TI_ST
> > specific parts from wl128x-radio and adds the required infrastructure to use it
> > with the serdev hcill driver instead. The remaining patches 13 and 14 remove
> > the old TI_ST code.
> >
> > The new code has been tested on the Motorola Droid 4. For testing the audio
> > should be configured to route Ext to Speaker or Headphone. Then you need to
> > plug headphone, since its cable is used as antenna. For testing there is a
> > 'radio' utility packages in Debian. When you start the utility you need to
> > specify a frequency, since initial get_frequency returns an error:
>
> What is the status of this series?
>
> Based on some of the replies (from Adam Ford in particular) it appears that
> this isn't ready to be merged, so is a v2 planned?

If you can leave the Logic PD Torpedo board alone and don't remove the
legacy st driver for now, go ahead and migrate the others.  I know
what you proposed 'should' work on my board, but I don't know why it
doesn't.  In fact other boards I maintain use your method, but it just
doesn't work on the Torpedo and I don't know why.  (it's not for lack
of trying)

adam
>
> Regards,
>
>         Hans
>
> >
> > $ radio -f 100.0
> >
> > Merry Christmas!
> >
> > -- Sebastian
> >
> > Sebastian Reichel (14):
> >   ARM: dts: LogicPD Torpedo: Add WiLink UART node
> >   ARM: dts: IGEP: Add WiLink UART node
> >   ARM: OMAP2+: pdata-quirks: drop TI_ST/KIM support
> >   media: wl128x-radio: remove module version
> >   media: wl128x-radio: remove global radio_disconnected
> >   media: wl128x-radio: remove global radio_dev
> >   media: wl128x-radio: convert to platform device
> >   media: wl128x-radio: use device managed memory allocation
> >   media: wl128x-radio: load firmware from ti-connectivity/
> >   media: wl128x-radio: simplify fmc_prepare/fmc_release
> >   media: wl128x-radio: fix skb debug printing
> >   media: wl128x-radio: move from TI_ST to hci_ll driver
> >   Bluetooth: btwilink: drop superseded driver
> >   misc: ti-st: Drop superseded driver
> >
> >  .../boot/dts/logicpd-torpedo-37xx-devkit.dts  |   8 +
> >  arch/arm/boot/dts/omap3-igep0020-rev-f.dts    |   8 +
> >  arch/arm/boot/dts/omap3-igep0030-rev-g.dts    |   8 +
> >  arch/arm/mach-omap2/pdata-quirks.c            |  52 -
> >  drivers/bluetooth/Kconfig                     |  11 -
> >  drivers/bluetooth/Makefile                    |   1 -
> >  drivers/bluetooth/btwilink.c                  | 350 -------
> >  drivers/bluetooth/hci_ll.c                    | 115 ++-
> >  drivers/media/radio/wl128x/Kconfig            |   2 +-
> >  drivers/media/radio/wl128x/fmdrv.h            |   5 +-
> >  drivers/media/radio/wl128x/fmdrv_common.c     | 211 ++--
> >  drivers/media/radio/wl128x/fmdrv_common.h     |   4 +-
> >  drivers/media/radio/wl128x/fmdrv_v4l2.c       |  55 +-
> >  drivers/media/radio/wl128x/fmdrv_v4l2.h       |   2 +-
> >  drivers/misc/Kconfig                          |   1 -
> >  drivers/misc/Makefile                         |   1 -
> >  drivers/misc/ti-st/Kconfig                    |  18 -
> >  drivers/misc/ti-st/Makefile                   |   6 -
> >  drivers/misc/ti-st/st_core.c                  | 922 ------------------
> >  drivers/misc/ti-st/st_kim.c                   | 868 -----------------
> >  drivers/misc/ti-st/st_ll.c                    | 169 ----
> >  include/linux/ti_wilink_st.h                  | 337 +------
> >  22 files changed, 213 insertions(+), 2941 deletions(-)
> >  delete mode 100644 drivers/bluetooth/btwilink.c
> >  delete mode 100644 drivers/misc/ti-st/Kconfig
> >  delete mode 100644 drivers/misc/ti-st/Makefile
> >  delete mode 100644 drivers/misc/ti-st/st_core.c
> >  delete mode 100644 drivers/misc/ti-st/st_kim.c
> >  delete mode 100644 drivers/misc/ti-st/st_ll.c
> >
>
