From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3/4: Correct support for PWM LEDs/backlight
Date: Thu, 3 Jan 2013 12:56:52 +0100
Message-ID: <50E57204.2090700@ti.com>
References: <1357213768-21266-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab3ACL45 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jan 2013 06:56:57 -0500
In-Reply-To: <1357213768-21266-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

On 01/03/2013 12:49 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> The pwm-leds driver update is going for 3.9:
> https://lkml.org/lkml/2012/12/21/99
>=20
> This series will make sure that in 3.9 we are going to have working L=
EDs and
> backlight on these boards.
>=20
> As a note: 4430SDP never had working backlight and the charger led di=
d not
> worked for couple of releases already due to wrong pwm_id.
>=20
> On BeagleBoard we will be able to adjust the brighness of pmu_stat LE=
D instead
> of full on/off.
>=20
> Zoom2 will have working keypad light and the backlight will be moved =
to be
> handled by the generic pwm-backlight driver.
>=20
> This series will also fix a compile error in board-zoom-display.c cau=
sed by the
> changes in twl-core - which I missed :(
>=20
> The DT support for these are going to be sent later.
>=20
> Tony: can you apply this - if it looks OK - so it will hit linux-next=
 before the
> second batch of twl-core update?

The series has been generated on top of my previous series for audio su=
pport
update of omap-twl4030:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82615.html

I can regenerate this without the depending series if you prefer that w=
ay.

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backli=
ght
>   ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_=
STAT led
>   ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight
>=20
>  arch/arm/mach-omap2/board-4430sdp.c          | 31 ++++++++++++++-
>  arch/arm/mach-omap2/board-omap3beagle.c      | 39 +++++++++++++++---=
-
>  arch/arm/mach-omap2/board-zoom-display.c     | 56 ------------------=
----------
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 53 ++++++++++++++++++=
+++++++-
>  4 files changed, 113 insertions(+), 66 deletions(-)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
