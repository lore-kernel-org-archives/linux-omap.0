From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Mon, 4 Feb 2013 10:00:27 +0100
Message-ID: <510F78AB.4000602@ti.com>
References: <51090829.1010109@asianux.com> <20130201224546.GG22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41245 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab3BDJAn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 04:00:43 -0500
In-Reply-To: <20130201224546.GG22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chen Gang <gang.chen@asianux.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 02/01/2013 11:45 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130130 03:50]:
>>
>>   the fields must be null-terminated:
>>   the caller may use it as null-terminted string, next.
>=20
> Added Peter to cc on this one too, it's best that he queues
> all the twl changes.

I can create a branch for you in our gitorious tree
(git://gitorious.org/omap-audio/linux-audio.git) for this patch. But I =
think
for now it would be best if you could take this via linux-omap (the fil=
e is
under arch/arm/mach-omap2 anyways)

Regards,
P=E9ter

>=20
> Tony
> =20
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/mach-omap2/twl-common.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/=
twl-common.c
>> index e49b40b..6a7aec6 100644
>> --- a/arch/arm/mach-omap2/twl-common.c
>> +++ b/arch/arm/mach-omap2/twl-common.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/i2c.h>
>>  #include <linux/i2c/twl.h>
>>  #include <linux/gpio.h>
>> +#include <linux/string.h>
>>  #include <linux/regulator/machine.h>
>>  #include <linux/regulator/fixed.h>
>> =20
>> @@ -56,7 +57,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
>>  			   struct twl4030_platform_data *pmic_data)
>>  {
>>  	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_=
OFF_WAKEUPENABLE);
>> -	strncpy(pmic_i2c_board_info.type, pmic_type,
>> +	strlcpy(pmic_i2c_board_info.type, pmic_type,
>>  		sizeof(pmic_i2c_board_info.type));
>>  	pmic_i2c_board_info.irq =3D pmic_irq;
>>  	pmic_i2c_board_info.platform_data =3D pmic_data;
>> --=20
>> 1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
