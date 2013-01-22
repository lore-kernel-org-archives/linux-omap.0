From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/5] ARM: dts: OMAP3+: PWM support for TWL and selected
 boards
Date: Tue, 22 Jan 2013 11:11:46 +0100
Message-ID: <50FE65E2.9020301@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab3AVKLy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 05:11:54 -0500
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Benoit,

I have prepared for you a branch from where you can pull this set on to=
p of
mainline v3.8-rc4:

Regards,
P=E9ter

---
The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe964=
7619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://gitorious.org/omap-audio/linux-audio.git peter/for-benoit

for you to fetch changes up to b6230ae20bc018d042d703d0667ba9e7ac027ccb=
:

  ARM: dts: omap4-sdp: Add support for pwm-backlight (2013-01-22 11:08:=
37 +0100)

----------------------------------------------------------------
Peter Ujfalusi (5):
      ARM: dts: twl4030: Add PWM support
      ARM: dts: twl6030: Add PWM support
      ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
      ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and chargin=
g LED)
      ARM: dts: omap4-sdp: Add support for pwm-backlight

 arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
 arch/arm/boot/dts/omap4-sdp.dts       | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
 arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
 4 files changed, 58 insertions(+), 4 deletions(-)

On 01/18/2013 03:36 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> Add the needed DT sections for twl4030 and twl6030 for the PWM childs=
=2E
> Update the omap4-sdp to have working backlight and keypad/charging LE=
D support.
> Use the pwm-leds driver on BeagleBoard for the pmu_stat LED instead o=
f the hacky
> twl403-gpio mapped PWM.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (5):
>   ARM: dts: twl4030: Add PWM support
>   ARM: dts: twl6030: Add PWM support
>   ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
>   ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging =
LED)
>   ARM: dts: omap4-sdp: Add support for pwm-backlight
>=20
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
>  arch/arm/boot/dts/omap4-sdp.dts       | 26 +++++++++++++++++++++++++=
+
>  arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
>  arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
>  4 files changed, 58 insertions(+), 4 deletions(-)
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
