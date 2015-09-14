From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio
 support
Date: Mon, 14 Sep 2015 09:28:51 -0700
Message-ID: <20150914162851.GM4215@atomide.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68A60.6050900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F68A60.6050900-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150914 01:54]:
> Hi Tony,
>=20
> On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
> > Hi,
> >=20
> > this series will enable analog audio (via onboard aic310x codec) fo=
r dra7-evm,
> > dra72-evm and am57xx-beagle-x15 boards.
> > In these board McASP3 is connected to the codec and for the McASP3 =
we needed to
> > have the DMA crossbar in place since the request lines are not mapp=
ed by
> > default.
>=20
> Did you had a chance to look at this series?

Looks OK to me, will look at it more once we have the fixes merged.

Paul may have comments on the hwmod chage, looks like you forgot
to Cc him on it. Can you please resend that one with Paul in Cc?

Regards,

Tony
=20
> > Regars,
> > Peter
> > ---
> > Peter Ujfalusi (11):
> >   ARM: OMAP: DRA7: hwmod: Add data for McASP3
> >   ARM: DTS: dra7: Add McASP3 node
> >   ARM: DTS: dra7-evm: Rename mmc2_3v3 supply to evm_3v3_sw
> >   ARM: DTS: dra7-evm: Add fixed regulator to be used by aic3106's D=
VDD
> >   ARM: DTS: dra7-evm: Enable pcf8575 (0x26 address) on i2c2 bus
> >   ARM: DTS: dra7-evm: Audio support
> >   ARM: DTS: dra72-evm: Add fixed regulator representing DVDD supply=
 for
> >     aic3106
> >   ARM: DTS: dra72-evm: Add gpio hog for vin6_sel_s0 to select audio
> >   ARM: DTS: dra72-evm: Audio support
> >   ARM: DTS: am57xx-beagle-x15: Add fixed regulator for aic3104's DV=
DD
> >   ARM: DTS: am57xx-beagle-x15: Enable analog audio support
> >=20
> >  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  95 ++++++++++++++++++=
++
> >  arch/arm/boot/dts/dra7-evm.dts            | 142 ++++++++++++++++++=
+++++++++++-
> >  arch/arm/boot/dts/dra7.dtsi               |  15 ++++
> >  arch/arm/boot/dts/dra72-evm.dts           | 138 ++++++++++++++++++=
+++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  41 +++++++++
> >  5 files changed, 428 insertions(+), 3 deletions(-)
> >=20
>=20
>=20
> --=20
> P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
