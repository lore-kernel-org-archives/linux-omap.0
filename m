From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 207/493] i2c: remove use of __devinit
Date: Wed, 21 Nov 2012 19:02:28 +0800
Message-ID: <CAGsJ_4y7zFmTZ4c6VsKbzyVsbivFQGXM4uv87obMXyrqfg5HLg@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353349642-3677-207-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2012/11/20 Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: "Ben Dooks " <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
> Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
> Cc: Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>
> Cc: "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> ---

Acked-by: Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>

>  drivers/i2c/busses/i2c-ali1535.c            |  4 ++--
>  drivers/i2c/busses/i2c-ali1563.c            |  4 ++--
>  drivers/i2c/busses/i2c-ali15x3.c            |  4 ++--
>  drivers/i2c/busses/i2c-amd756.c             |  2 +-
>  drivers/i2c/busses/i2c-amd8111.c            |  2 +-
>  drivers/i2c/busses/i2c-at91.c               |  6 +++---
>  drivers/i2c/busses/i2c-au1550.c             |  2 +-
>  drivers/i2c/busses/i2c-cpm.c                |  4 ++--
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
>  drivers/i2c/busses/i2c-eg20t.c              |  2 +-
>  drivers/i2c/busses/i2c-elektor.c            |  4 ++--
>  drivers/i2c/busses/i2c-gpio.c               |  4 ++--
>  drivers/i2c/busses/i2c-highlander.c         |  2 +-
>  drivers/i2c/busses/i2c-hydra.c              |  2 +-
>  drivers/i2c/busses/i2c-i801.c               | 14 +++++++-------
>  drivers/i2c/busses/i2c-ibm_iic.c            |  4 ++--
>  drivers/i2c/busses/i2c-intel-mid.c          |  2 +-
>  drivers/i2c/busses/i2c-isch.c               |  2 +-
>  drivers/i2c/busses/i2c-mpc.c                | 20 ++++++++++----------
>  drivers/i2c/busses/i2c-mv64xxx.c            | 12 ++++++------
>  drivers/i2c/busses/i2c-mxs.c                |  2 +-
>  drivers/i2c/busses/i2c-nforce2.c            |  4 ++--
>  drivers/i2c/busses/i2c-nuc900.c             |  2 +-
>  drivers/i2c/busses/i2c-ocores.c             |  2 +-
>  drivers/i2c/busses/i2c-octeon.c             |  6 +++---
>  drivers/i2c/busses/i2c-omap.c               |  2 +-
>  drivers/i2c/busses/i2c-parport-light.c      |  2 +-
>  drivers/i2c/busses/i2c-pasemi.c             |  2 +-
>  drivers/i2c/busses/i2c-pca-isa.c            |  4 ++--
>  drivers/i2c/busses/i2c-pca-platform.c       |  2 +-
>  drivers/i2c/busses/i2c-piix4.c              | 10 +++++-----
>  drivers/i2c/busses/i2c-pmcmsp.c             |  2 +-
>  drivers/i2c/busses/i2c-pnx.c                |  2 +-
>  drivers/i2c/busses/i2c-powermac.c           | 12 ++++++------
>  drivers/i2c/busses/i2c-puv3.c               |  2 +-
>  drivers/i2c/busses/i2c-pxa-pci.c            |  2 +-
>  drivers/i2c/busses/i2c-rcar.c               |  2 +-
>  drivers/i2c/busses/i2c-s6000.c              |  4 ++--
>  drivers/i2c/busses/i2c-sh7760.c             |  4 ++--
>  drivers/i2c/busses/i2c-sirf.c               |  2 +-
>  drivers/i2c/busses/i2c-sis5595.c            |  4 ++--
>  drivers/i2c/busses/i2c-sis630.c             |  4 ++--
>  drivers/i2c/busses/i2c-sis96x.c             |  2 +-
>  drivers/i2c/busses/i2c-tegra.c              |  2 +-
>  drivers/i2c/busses/i2c-via.c                |  2 +-
>  drivers/i2c/busses/i2c-viapro.c             |  2 +-
>  drivers/i2c/busses/i2c-xiic.c               |  2 +-
>  drivers/i2c/busses/i2c-xlr.c                |  2 +-
>  drivers/i2c/busses/scx200_acb.c             | 10 +++++-----
>  drivers/i2c/muxes/i2c-mux-gpio.c            |  4 ++--
>  drivers/i2c/muxes/i2c-mux-pinctrl.c         |  2 +-
>  52 files changed, 103 insertions(+), 103 deletions(-)
>
