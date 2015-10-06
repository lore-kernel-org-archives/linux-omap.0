From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/11] arm: omap2: timer: provide generic sync32k_timer_init function
Date: Tue, 6 Oct 2015 14:15:43 -0500
Message-ID: <87r3l724gw.fsf@saruman.tx.rr.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com> <1444150927-14771-5-git-send-email-balbi@ti.com> <561413F2.4000700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561413F2.4000700@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Suman Anna <s-anna@ti.com> writes:
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 976ff9fa3594..d14e25b2d7a4 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -608,21 +608,13 @@ static void __init __omap_sync32k_timer_init(int c=
lkev_nr, const char *clkev_src
>>  		omap2_sync32k_clocksource_init();
>>  }
>>=20=20
>> -#ifdef CONFIG_ARCH_OMAP2
>> -void __init omap2_sync32k_timer_init(void)
>> +void __init omap_sync32k_timer_init(void)
>>  {
>>  	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>>  			2, "timer_sys_ck", NULL, false);
>>  }
>> -#endif /* CONFIG_ARCH_OMAP2 */
>>=20=20
>>  #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
>> -void __init omap3_sync32k_timer_init(void)
>> -{
>> -	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>> -			2, "timer_sys_ck", NULL, false);
>> -}
>> -
>>  void __init omap3_secure_sync32k_timer_init(void)
>>  {
>>  	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
>> @@ -640,15 +632,9 @@ void __init omap3_gptimer_timer_init(void)
>>=20=20
>>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>>  	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>> -static void __init omap4_sync32k_timer_init(void)
>> -{
>> -	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>> -			2, "sys_clkin_ck", NULL, false);
>> -}
>> -
>>  void __init omap4_local_timer_init(void)
>>  {
>> -	omap4_sync32k_timer_init();
>> +	omap_sync32k_timer_init();
>
> Hmm, this is changing the parent clock source for the timer from
> sys_clkin_ck to timer_sys_ck for OMAP4 and OMAP5 below. I am not sure of
> the history behind the parent source, but is this what you intended to
> do here.

good catch. I'll fix this for next revision

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWFB3hAAoJEIaOsuA1yqREOfYP/1zS3mnZfiVxu6c3OeWBRqHW
u2hnEtWdsbhlDLDs6Quoyhqh+G7BI9Y5WYcMVTQJ7RusRZ22I266hlDHAAo/Wtu5
b72kzbKbu7WPFeo4lw6cQDvJCz326cbyoNqjyuITmLmF8Z5aKGFEQ0IcOzeA5ZPR
s+shnbnB6sB/zksXtOw76YMbPZk2FoT0yKsE6MJTzpr6p2+a8YkF9R+YSmkd/SUx
rWRbx2W9nU/UC4j0NJ87Y1K2WTvjrhVxPoQ0k3J7rpaCYrt2XL02imWlDDWB1uAn
1RTzDqVDE+tlEl4v8CErcxELlu4pmVcmCQUE6IP8QG+4auYyV95d8m12bOseIsbD
C+/7ArrJdf+5L9CSR8armCfICWfMhI7FOOGfrpLzH0rT1YuVqFSl+DC/MoUFwJps
2DTwCpGJWC6Bzs4Njfnxs+xznITucATpcnkJtQKpqBEaVIRarstH/iZn4zepnHQx
1dpUXSVane/gGr4C+s0mxGkSJBvJuxaDGOKT14xJsXwEJpS9b/njJi/OGwKlp8l6
jemwIITkNDpmWI1a4x7LlHpheV8kwmEOg8+raR7d4/+qgUy31x3/vywz5PmlwR8g
UAH74lM8qZtFZJyfGbIdi2lpDq4ME6BAS1SmjQ0Xi6x2H+MLMvb3riJ+7+xgFC9r
/+lDiw668cZwS8DV11mD
=l8Sc
-----END PGP SIGNATURE-----
--=-=-=--
