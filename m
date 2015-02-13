From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/9] ARM: DRA7: add display support
Date: Fri, 13 Feb 2015 10:01:29 -0600
Message-ID: <54DE1FD9.6030801@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44334 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbbBMQBz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:01:55 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>

On 02/13/2015 09:11 AM, Tomi Valkeinen wrote:
> Hi,
>=20
> This series adds the arch/arm/ side of the display support for DRA7 (=
DRA72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 E=
VM boards
> is added.
>=20
> The series is based on OMAPDSS driver patches in fbdev changes for 3.=
20, which
> have been merged to Linus' tree.
>=20
> The changes are very similar to OMAP5 DSS. All the other patches look=
 fine to
> me except the "RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN". That's been=
 discussed
> earlier with Paul and Tero, but I don't think we have any good soluti=
on for it
> yet.

Is there some specific tag I can test this on (some next perhaps?), I
get the following error:
build fail, Error:
arch/arm/mach-omap2/display.c: In function =E2=80=98omap_display_get_ve=
rsion=E2=80=99:
arch/arm/mach-omap2/display.c:285:10: error: =E2=80=98OMAPDSS_VER_DRA7x=
x=E2=80=99
undeclared (first use in this function)
arch/arm/mach-omap2/display.c:285:10: note: each undeclared identifier
is reported only once for each function it appears in
arch/arm/mach-omap2/display.c:288:1: warning: control reaches end of
non-void function [-Wreturn-type]
make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2
make: *** Waiting for unfinished jobs....


=46urther are you proposing this for 3.20 or 3.21 window? 3.20, we seem
to have already missed.


>=20
>  Tomi
>=20
> Tomi Valkeinen (9):
>   arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
^^
>   ARM: DRA7: hwmod: add DMM hwmod description
>   ARM: DRA7: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP: display: change compat names to array
>   ARM: OMAP2+: display: detect DRA7 DSS
>   arm/dts: dra7.dtsi: add DSS support
^^
>   arm/dts: dra72-evm.dts: add HDMI
^^
>   arm/dts: am57xx-beagle-x15.dts: add HDMI

ARM: dts: am57xx-beagle-x15: Add HDMI

Would be good to follow above convention for all dts patches $subject.


>   RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  80 ++++++++++++++++++++=
+
>  arch/arm/boot/dts/dra7.dtsi               |  38 ++++++++++
>  arch/arm/boot/dts/dra72-evm.dts           | 111 ++++++++++++++++++++=
++++++++++
>  arch/arm/boot/dts/dra72x.dtsi             |  11 +++
>  arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
>  arch/arm/boot/dts/dra7xx-clocks.dtsi      |   1 +
>  arch/arm/mach-omap2/display.c             |  32 +++++----
>  arch/arm/mach-omap2/io.c                  |  11 +++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  32 +++++++++
>  9 files changed, 316 insertions(+), 15 deletions(-)
>=20


--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
