From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
Date: Thu, 28 Nov 2013 11:52:18 +0200
Message-ID: <52971252.40909@ti.com>
References: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com> <52970E4C.8070502@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39770 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab3K1Jwj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Nov 2013 04:52:39 -0500
In-Reply-To: <52970E4C.8070502@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tomi.valkeinen@ti.com

Hi Benoit,

On 11/28/2013 11:35 AM, Benoit Cousson wrote:
> Hi Peter,
>=20
> On 28/11/2013 10:28, Peter Ujfalusi wrote:
>> Since in DT booted kernel dummy regulators are no longer supported w=
e need
>> to provide valid phandle for the regulator needed by the backlight.
>> On the board VBAT is used to power the LCD backlight(s).
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> This patch is needed for 3.13 to get the LCD backlight to work again=
=2E
>=20
> OK, so this is a fix for the next -rc?

Yes, it would be really great if this can make it to the next -rc.

>=20
> Regards,
> Benoit
>=20
>>
>> Regards,
>> Peter
>>
>>   arch/arm/boot/dts/omap4-sdp.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/oma=
p4-sdp.dts
>> index 5fc3f43..6f86db2 100644
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -104,6 +104,7 @@
>>                   100 110 120 127
>>                   >;
>>           default-brightness-level =3D <13>;
>> +        power-supply =3D <&vbat>;
>>       };
>>
>>       sound {
>>
>=20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
