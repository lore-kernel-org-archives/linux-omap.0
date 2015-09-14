From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio
 support
Date: Mon, 14 Sep 2015 11:50:40 +0300
Message-ID: <55F68A60.6050900@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
> Hi,
>=20
> this series will enable analog audio (via onboard aic310x codec) for =
dra7-evm,
> dra72-evm and am57xx-beagle-x15 boards.
> In these board McASP3 is connected to the codec and for the McASP3 we=
 needed to
> have the DMA crossbar in place since the request lines are not mapped=
 by
> default.

Did you had a chance to look at this series?

> Regars,
> Peter
> ---
> Peter Ujfalusi (11):
>   ARM: OMAP: DRA7: hwmod: Add data for McASP3
>   ARM: DTS: dra7: Add McASP3 node
>   ARM: DTS: dra7-evm: Rename mmc2_3v3 supply to evm_3v3_sw
>   ARM: DTS: dra7-evm: Add fixed regulator to be used by aic3106's DVD=
D
>   ARM: DTS: dra7-evm: Enable pcf8575 (0x26 address) on i2c2 bus
>   ARM: DTS: dra7-evm: Audio support
>   ARM: DTS: dra72-evm: Add fixed regulator representing DVDD supply f=
or
>     aic3106
>   ARM: DTS: dra72-evm: Add gpio hog for vin6_sel_s0 to select audio
>   ARM: DTS: dra72-evm: Audio support
>   ARM: DTS: am57xx-beagle-x15: Add fixed regulator for aic3104's DVDD
>   ARM: DTS: am57xx-beagle-x15: Enable analog audio support
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  95 ++++++++++++++++++++
>  arch/arm/boot/dts/dra7-evm.dts            | 142 ++++++++++++++++++++=
+++++++++-
>  arch/arm/boot/dts/dra7.dtsi               |  15 ++++
>  arch/arm/boot/dts/dra72-evm.dts           | 138 ++++++++++++++++++++=
+++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  41 +++++++++
>  5 files changed, 428 insertions(+), 3 deletions(-)
>=20


--=20
P=E9ter
