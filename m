From: Felipe Balbi <balbi@TI.COM>
Subject: Re: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Tue, 6 Oct 2015 22:07:46 -0500
Message-ID: <87bncb1im5.fsf@saruman.tx.rr.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com> <1444150927-14771-10-git-send-email-balbi@ti.com> <56145836.4070304@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56145836.4070304@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 10/06/2015 07:02 PM, Felipe Balbi wrote:
>> Introduce a new clocksource driver for Texas
>> Instruments 32.768 Hz device which is available
>> on most OMAP-like devices.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> Hi Felipe,
>
> With the couple of nits below fixed, you can my:
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> [ ... ]
>
>> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
>> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
>> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
>> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
>> +
>> +struct ti_32k {
>> +	void __iomem		*base;
>> +	void __iomem		*counter;
>> +	struct clocksource	cs;
>> +};
>> +#define to_ti_32k(cs)	(container_of((cs), struct ti_32k, cs))
>
> Usually a static inline is used instead of a macro for that.

not so true and also completely unnecessary, considering container_of()
already type safety ;-)

Try this:

$ git grep -e "#define.*container_of" | wc -l

no strong feelings though. I tend to prefer a macro to wrap
container_of() but won't go into an argument

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWFIyDAAoJEIaOsuA1yqREHQ8P/i3yIXpmyUR0h6tER2HOxpCy
0FQd2UC3E94b8KJ1Rr1VVKUo7T73f3iGOFz8hYvnOBuL36prmmHb9Kn2ayZP5GeK
Zao2n0+AZJNTASq8a5Wlb+geedMhtKbKetSG78Li/hgL+fELfsosuVnhZRhnQ7iC
+CMLgL7iZ0LSqylPm7UEZHgG80Aud2BJRCTP/ZLS4tvyHYW/z3NmDVTSdgtFTh5r
mHRUbG17w6nSpU/kEhChbeXq7RjOWirr+ZpdqTlJBO5LTbBoB7oS57mQaKffODfK
tzgU4rn7CrL3KsQBvvyh5w5wk2h5IsiBNDifjUDsrsgnqqRkN/Ylp3cOcGqnfg1A
W57LFDPRZFlOyo/IzkIrkgSG0z9KKLfgOx27dXdmiZQHxB/NU69ofhA8CimN8XdM
6RgH9A+Jchw/S9+4RSzwXRpmYmmdaWvVrSWTUgrpVsSgMVOSNmdFnwAW+BNTpxDZ
DAdzqvHYfZWtU0yukXEF9+MLuk3RUvMlJ3zvPas1f3UIFIOOGqAeLeQAP4IthsGu
xhhs9/klnS+1bT0brk09YzRbfVYflFbXENnpAzB7Nuc8V8tpw+qxq1wddmXO1uok
hgbRd3WstWyjrMD/waIcrMcxTdlt+h8yA7moVuidL+8oBT3nAkuudAd/dCBCIT1k
UF0kyuS/hQ0h+8Mmzz/g
=Kz6j
-----END PGP SIGNATURE-----
--=-=-=--
