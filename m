From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 1/3] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 29 Jun 2012 17:13:27 +0800
Message-ID: <4FED71B7.80308@linaro.org>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <20120629055509.11091.2780.stgit@build.warmcat.com> <20120629090515.GA4202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:48285 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab2F2JNh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 05:13:37 -0400
In-Reply-To: <20120629090515.GA4202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, rostedt@goodmis.org

On 06/29/12 17:05, the mail apparently from Tony Lindgren included:
> * Andy Green <andy.green@linaro.org> [120628 22:59]:
>>
>> Introduce a generic helper function that can generate a valid MAC
>> address using data from the OMAP unique CPU ID register.
> ...
>
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -530,3 +530,42 @@ void __init omap2_set_globals_tap(struct omap_g=
lobals *omap2_globals)
>>   	else
>>   		tap_prod_id =3D 0x0208;
>>   }
>> +
>> +/*
>> + * this uses the unique per-cpu info from the cpu fuses set at fact=
ory to
>> + * generate a 6-byte MAC address.  Two bits in the generated code a=
re used
>> + * to elaborate the generated address into four, so it can be used =
on multiple
>> + * network interfaces.
>> + */
>> +
>> +void omap2_die_id_to_ethernet_mac(u8 *mac, int subtype)
>> +{
>> +	struct omap_die_id odi;
>> +	u32 tap =3D read_tap_reg(OMAP_TAP_IDCODE);
>> +
>> +	omap_get_die_id(&odi);
>> +
>> +	mac[0] =3D odi.id_2;
>> +	mac[1] =3D odi.id_2 >> 8;
>> +	mac[2] =3D odi.id_1;
>> +	mac[3] =3D odi.id_1 >> 8;
>> +	mac[4] =3D odi.id_1 >> 16;
>> +	mac[5] =3D odi.id_1 >> 24;
>> +
>> +	/* XOR other chip-specific data with ID */
>> +
>> +	tap ^=3D odi.id_3;
>> +
>> +	mac[0] ^=3D tap;
>> +	mac[1] ^=3D tap >> 8;
>> +	mac[2] ^=3D tap >> 16;
>> +	mac[3] ^=3D tap >> 24;
>> +
>> +	/* allow four MACs from this same basic data */
>> +
>> +	mac[1] =3D (mac[1] & ~0xc0) | ((subtype & 3) << 6);
>> +
>> +	/* mark it as not multicast, and outside official 80211 MAC namesp=
ace */
>> +
>> +	mac[0] =3D (mac[0] & ~1) | 2;
>> +}
>
> Let's just make this omap_die_id_to_ethernet_mac, no need to keep the
> omap2 naming there as this should not conflict with any omap1 stuff.

Okay, will do thanks.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
