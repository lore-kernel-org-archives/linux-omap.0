From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default status for 32k counter
Date: Tue, 6 Oct 2015 09:57:45 -0500
Message-ID: <87612k3uza.fsf@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <20151005175230.GG18784@saruman.tx.rr.com> <87io6lf6i4.fsf@saruman.tx.rr.com> <13543270.oBfHhoNL28@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13543270.oBfHhoNL28@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 05 October 2015 14:41:07 Felipe Balbi wrote:
>>=20
>> /**
>>  * omap_get_timer_dt - get a timer using device-tree
>>  * @match       - device-tree match structure for matching a device type
>>  * @property    - optional timer property to match
>>  *
>>  * Helper function to get a timer during early boot using device-tree fo=
r use
>>  * as kernel system timer. Optionally, the property argument can be used=
 to
>>  * select a timer with a specific property. Once a timer is found then m=
ark
>>  * the timer node in device-tree as disabled, to prevent the kernel from
>>  * registering this timer as a platform device and so no one else can us=
e it.
>>  */
>> static struct device_node * __init omap_get_timer_dt(const struct of_dev=
ice_id *match,
>>                                                      const char *propert=
y)
>> {
>>         struct device_node *np;
>>=20
>>         for_each_matching_node(np, match) {
>>                 if (!of_device_is_available(np))
>>                         continue;
>>=20
>>                 if (property && !of_get_property(np, property, NULL))
>>                         continue;
>>=20
>>                 if (!property && (of_get_property(np, "ti,timer-alwon", =
NULL) ||
>>                                   of_get_property(np, "ti,timer-dsp", NU=
LL) ||
>>                                   of_get_property(np, "ti,timer-pwm", NU=
LL) ||
>>                                   of_get_property(np, "ti,timer-secure",=
 NULL)))
>>                         continue;
>>=20
>>                 of_add_property(np, &device_disabled);
>>                 return np;
>>         }
>>=20
>>         return NULL;
>> }
>>=20
>> I'll patch this up and drop $subject
>>=20
>
> Ah, good.
>
> I'm seeing the "ti,timer-alwon" property here, we probably need to take
> that into account when setting the CLOCK_SOURCE_SUSPEND_NONSTOP flag, if
> that isn't how it gets done already.

that flag is not set for 32k in any dts. Seems like it should, though,
judging by the binding documentation:

=2D ti,timer-alwon:	Indicates the timer is in an alway-on power
  domain.

Tony, care to comment if we should add timer-alwon to 32k ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE+FqAAoJEIaOsuA1yqREzHIQAJo56Pfi0o0iJxNPF7fENKdL
lQ40IS0oRJlKeGTxlon+OXyJuFyhCTLLwNm2zX9L1Pq0VvuduQjrTZazeNz7RWzK
rs0bZpQ6eWY41+04itDWRjIRD5h+EFiFL2GbQf7mFL9928OddVQu/W2c7rkw5orl
3uuEQYex19yzpSTkhvRxoSHFsP4f5svv5MwoqQap4XwZW4f0+YkWASAgg8uKlVAI
/avpH/IdXHgCcBDEX7xIzb98S4yEkcXXRAb0HIz2KU428d+40/4u1k4bkO9ABH9/
X9IjoYwdY8TXZXb+KpsKzqbJ0rEOqHjWxO5Ap/jDD1tf6QvhmqNH3MR4gssNVjYd
hf6euzMpL2t0uvdshFYTcoaEWjJbI+shVwiXaduV53tNvcfb66CulXbKoZX/diSU
TqqA8d1M++N0NNx8HNfHiKN/eIlNPZr9PwKaYnUJrbkZXSIV9KFCC+RnqweozpNd
KwWPHLRl2n9cPh9nzK6pcC2wvktj8aEUlVF5aViese9EMN6xarbmxsTWLogTgtTL
H7DbQUXL+0Pb3Rf8SIK+zD3ucWkdxZLOqc39YJ9TMBBXemg40YmJ9Hp7gJ/z6HQa
qHfJ2OugAFgR4SvCfj5OLLtNsu5tpx7ERHO6qiSeghoTxiBnsppxl2Ahryt5kDiS
XgN4JFgx8PvfS/GPGH25
=QjO8
-----END PGP SIGNATURE-----
--=-=-=--
