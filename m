From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PULL REQUEST] omapfb: Add support for new LCDs / misc fixes
Date: Tue, 16 Jun 2009 18:58:25 +0200
Message-ID: <20090616185825.0343c9b2.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
	<20090611120206.GD21836@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:7263 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZFPQui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 12:50:38 -0400
In-Reply-To: <20090611120206.GD21836@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Thu, 11 Jun 2009 15:02:06 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> Hi,
>=20
> the following pull request is for the patchset updated based on your =
comments:
>=20
> The following changes since commit 07a2039b8eb0af4ff464efd3dfd95de5c0=
2648c6:
>   Linus Torvalds (1):
>         Linux 2.6.30
>=20
> are available in the git repository at:
>=20
>   git://koowaldah.org/people/imre/linux-2.6-fb master
>=20
> Daniel Stone (1):
>       omapfb: dispc: Allow multiple external IRQ handlers
>=20
> Hunyue Yau (1):
>       omapfb: Add support for the 2430SDP LCD
>=20
> Imre Deak (5):
>       omapfb: Add support for MIPI-DCS compatible LCDs
>       N770: Enable LCD MIPI-DCS in Kconfig
>       omapfb: dispc: Various typo fixes
>       omapfb: Add FB manual update option to Kconfig
>       omapfb: HWA742: fix pointer to be const
>=20
> Jonathan McDowell (1):
>       omapfb: Add support for the Amstrad Delta LCD
>=20
> Jouni Hogander (2):
>       omapfb: dispc: Disable iface clocks along with func clocks
>       omapfb: dispc: Enable wake up capability
>=20
> Jouni H=F6gander (1):
>       omapfb: suspend/resume only if FB device is already initialized
>=20
> Kevin Hilman (1):
>       omapfb: Add support for the 3430SDP LCD
>=20
> Koen Kooi (1):
>       omapfb: Add support for the OMAP3 Beagle DVI output
>=20
> Kyungmin Park (1):
>       omapfb: Add support for the Apollon LCD
>=20
> Rodrigo Vivi (1):
>       omapfb: Add support for rotation on the Blizzard LCD ctrl
>=20
> Stanley.Miao (1):
>       omapfb: Add support for the ZOOM MDK LCD
>=20
> Steve Sakoman (2):
>       omapfb: Add support for the OMAP3 EVM LCD
>       omapfb: Add support for the Gumstix Overo LCD
>=20
> arun c (2):
>       omapfb: Add support for the OMAP2EVM LCD
>       omapfb: Fix coding style / remove dead line
>=20
>  arch/arm/configs/n770_defconfig             |    2 +-
>  arch/arm/configs/omap3_beagle_defconfig     |   47 ++-
>  arch/arm/configs/omap_3430sdp_defconfig     |   39 ++-
>  arch/arm/configs/omap_ldp_defconfig         |   54 +++-
>  arch/arm/plat-omap/include/mach/lcd_mipid.h |    5 +
>  arch/arm/plat-omap/include/mach/omapfb.h    |    4 +-
>  drivers/video/omap/Kconfig                  |   82 +++-
>  drivers/video/omap/Makefile                 |   12 +
>  drivers/video/omap/blizzard.c               |   91 ++++-
>  drivers/video/omap/dispc.c                  |  130 ++++---
>  drivers/video/omap/dispc.h                  |    7 +-
>  drivers/video/omap/hwa742.c                 |    2 +-
>  drivers/video/omap/lcd_2430sdp.c            |  200 +++++++++
>  drivers/video/omap/lcd_ams_delta.c          |  137 ++++++
>  drivers/video/omap/lcd_apollon.c            |  138 ++++++
>  drivers/video/omap/lcd_ldp.c                |  200 +++++++++
>  drivers/video/omap/lcd_mipid.c              |  625 +++++++++++++++++=
++++++++++
>  drivers/video/omap/lcd_omap2evm.c           |  189 ++++++++
>  drivers/video/omap/lcd_omap3beagle.c        |  133 ++++++
>  drivers/video/omap/lcd_omap3evm.c           |  191 ++++++++
>  drivers/video/omap/lcd_overo.c              |  179 ++++++++
>  drivers/video/omap/omapfb_main.c            |   64 ++-
>  drivers/video/omap/rfbi.c                   |    7 +-
>  23 files changed, 2424 insertions(+), 114 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_2430sdp.c
>  create mode 100644 drivers/video/omap/lcd_ams_delta.c
>  create mode 100644 drivers/video/omap/lcd_apollon.c
>  create mode 100644 drivers/video/omap/lcd_ldp.c
>  create mode 100644 drivers/video/omap/lcd_mipid.c
>  create mode 100644 drivers/video/omap/lcd_omap2evm.c
>  create mode 100644 drivers/video/omap/lcd_omap3beagle.c
>  create mode 100644 drivers/video/omap/lcd_omap3evm.c
>  create mode 100644 drivers/video/omap/lcd_overo.c
>

I assume you introduced small changes after my review.=20

=46or the whole patchset:

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Regards,
Krzysztof

----------------------------------------------------------------------
Przekaz dalej wiadomosc: Zawsze warto oszczedzac. Teraz 5,5%!
Sprawdz > http://link.interia.pl/f21b1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
