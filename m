From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap2plus_defconfig: Enable EXT4 support
Date: Wed, 27 Jun 2012 23:37:34 -0700
Message-ID: <20120628063734.GB19842@atomide.com>
References: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
 <CAAwP0s2eTWk2Uf0HZ13Lq5gA0HNp8V87znjd6rX6Uh0ZPy03PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42505 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab2F1Ghj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 02:37:39 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s2eTWk2Uf0HZ13Lq5gA0HNp8V87znjd6rX6Uh0ZPy03PA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Russell King <linux@arm.linux.org.uk>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Javier Martinez Canillas <martinez.javier@gmail.com> [120627 15:32]:
> On Sun, Jun 24, 2012 at 12:18 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> > On OMAP boards that includes an SD card slot, an EXT4 partition cou=
ld
> > be used to store the root file system. So, the kernel should have
> > built-in support for EXT4 to be able to mount the VFS root on boot.
> >
> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> > ---
> > =C2=A0arch/arm/configs/omap2plus_defconfig | =C2=A0 =C2=A01 +
> > =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/config=
s/omap2plus_defconfig
> > index 9854ff4..f3087cb 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -197,6 +197,7 @@ CONFIG_RTC_DRV_TWL4030=3Dy
> > =C2=A0CONFIG_EXT2_FS=3Dy
> > =C2=A0CONFIG_EXT3_FS=3Dy
> > =C2=A0# CONFIG_EXT3_FS_XATTR is not set
> > +CONFIG_EXT4_FS=3Dy
> > =C2=A0CONFIG_QUOTA=3Dy
> > =C2=A0CONFIG_QFMT_V2=3Dy
> > =C2=A0CONFIG_MSDOS_FS=3Dy
> > --
> > 1.7.7.6
> >
>=20
> Hi,
>=20
> any news about this patch?
>=20
> Is quite annoying to have to enable EXT4 support each time I want to
> try a new kernel on my board.

Eventually we'll be moving into omap2plus_defconfig that pretty much
builds everything as modules and requires use of an initramfs.. But
until we're there yes I agree this makes life easier for booting beagle
and panda devices with the omap2plus_defconfig.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
