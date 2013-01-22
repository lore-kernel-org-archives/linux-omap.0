From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] ARM: dts: OMAP3+: PWM support for TWL and selected
 boards
Date: Tue, 22 Jan 2013 11:23:39 +0100
Message-ID: <50FE68AB.3070909@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com> <50FE65E2.9020301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34033 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab3AVKXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 05:23:49 -0500
In-Reply-To: <50FE65E2.9020301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Peter,

On 01/22/2013 11:11 AM, Peter Ujfalusi wrote:
> Hi Benoit,
>=20
> I have prepared for you a branch from where you can pull this set on =
top of
> mainline v3.8-rc4:

Cool thanks,
I'll merged it in my branch.

Thanks,
Benoit

>=20
> Regards,
> P=E9ter
>=20
> ---
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9=
647619:
>=20
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
>=20
> are available in the git repository at:
>=20
>   git://gitorious.org/omap-audio/linux-audio.git peter/for-benoit
>=20
> for you to fetch changes up to b6230ae20bc018d042d703d0667ba9e7ac027c=
cb:
>=20
>   ARM: dts: omap4-sdp: Add support for pwm-backlight (2013-01-22 11:0=
8:37 +0100)
>=20
> ----------------------------------------------------------------
> Peter Ujfalusi (5):
>       ARM: dts: twl4030: Add PWM support
>       ARM: dts: twl6030: Add PWM support
>       ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
>       ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charg=
ing LED)
>       ARM: dts: omap4-sdp: Add support for pwm-backlight
>=20
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
>  arch/arm/boot/dts/omap4-sdp.dts       | 26 +++++++++++++++++++++++++=
+
>  arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
>  arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
>  4 files changed, 58 insertions(+), 4 deletions(-)
>=20
> On 01/18/2013 03:36 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Add the needed DT sections for twl4030 and twl6030 for the PWM child=
s.
>> Update the omap4-sdp to have working backlight and keypad/charging L=
ED support.
>> Use the pwm-leds driver on BeagleBoard for the pmu_stat LED instead =
of the hacky
>> twl403-gpio mapped PWM.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (5):
>>   ARM: dts: twl4030: Add PWM support
>>   ARM: dts: twl6030: Add PWM support
>>   ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
>>   ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging=
 LED)
>>   ARM: dts: omap4-sdp: Add support for pwm-backlight
>>
>>  arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
>>  arch/arm/boot/dts/omap4-sdp.dts       | 26 ++++++++++++++++++++++++=
++
>>  arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
>>  arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
>>  4 files changed, 58 insertions(+), 4 deletions(-)
>>
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
