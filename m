From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: improve ->remove() callback
Date: Mon, 2 Nov 2015 13:25:54 -0600
Message-ID: <87lhagnqyl.fsf@saruman.tx.rr.com>
References: <1446127050-5957-1-git-send-email-balbi@ti.com> <563778B8.9060109@ti.com> <87bnbcctsk.fsf@saruman.tx.rr.com> <56378492.702@ti.com> <87si4oo07n.fsf@saruman.tx.rr.com> <5637B74D.5040807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5637B74D.5040807-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 11/02/2015 06:06 PM, Felipe Balbi wrote:
>>=20
>> hi,
>>=20
>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>> On 11/02/2015 05:20 PM, Felipe Balbi wrote:
>>>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>>>
>>>>> On 10/29/2015 03:57 PM, Felipe Balbi wrote:
>>>>>> there's no need to call pm_runtime_get_sync()
>>>>>> followed by pm_runtime_put(). We should, instead,
>>>>>> just call pm_runtime_put_sync() and pm_runtime_disable().
>>>>>
>>>>> Sry, but why do we need to call pm_runtime_put[_sync]() here?
>>>>>
>>>>> My be just pm_runtime_disable() will be ok?
>>>>
>>>> and disable with unbalanced pm_runtime_get() ?
>>>>
>>>
>>> Which one is unbalanced pm_runtime_get()?
>>> There are no  pm_runtime_get() in probe, so there you are
>>> going to introduce unbalanced pm_runtime_put_sync() actually :(
>>=20
>> look at ti_qspi_setup(). I _do_ see, however, that it calls
>> pm_runtime_put_autosuspend() in the same function; what happens if
>> driver is removed after ti_qspi_setup() runs but before
>> put_autosuspend() has time to actually run ?
>>=20
>
> Seems nothing :) If I understand code in __device_release_driver()
> right: the .remove() callback will be called after
> pm_runtime_put_sync() and device should be disabled at this moment.
>
> Also, note that ti_qspi_setup() will be called for each SPI device
> attached to SPI master and further PM management of SPI master is
> performed by SPI core from __spi_pump_messages().

all right, do you want to send a patch fixing it ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWN7jDAAoJEIaOsuA1yqRELkMP/ip4cNFTA+5o0q1gCxF0YvVz
UMZHCJmttB9BY/X6HpNeKNo18JE25bIR0uCoyH3uv2MiIHH4C2uAsthkEE+OY1id
lyW/i7/G/6LYJtamsIvIllDA40nLyeOGXbKS+Q/Xa/Ibv4JYvFWtfDlLzMBxUPs0
oLjtCPsORRV8RCOttfHE34c1fGT6dbcgHqk+hSPfhTUHuZHlcKyAwgMJMQY+ZQGF
T4ZfBIOX7PAeAj5CJGURkpdKlI3zJto4LDgPyi1NAGNnPw60nldMj1cqyqzcyfwE
tS/lRuivUm6LJXh143G4rPXIuU2GQEWnXQGo2GlCtmkMkNXglN1S+2tcbGKoPrB2
nbJZyYcwnmwVfUYvybt0JPkOYB+18jtH+/nI0wBUoJynLJFhzXcvovi4YR1yphgX
8zgWIzP8bmVUe/aWDOfiwwjGoXVdp4o68aTSyhK4ulmxsSol1eFM0GB10d04Htm/
Xck8HVb6K+OlJJNlB4otu2HuFbS0q3/f3Mzl51wSqGDPJyqgdlE2poCYtR8Mgx/4
mPg+b51JTdxqjdl7dH4NVQnnK0JPaGiPpb9lGVO+b9sYKuRl8r9uKLWDGuWtAYV8
oESlBh9AX6PSeEGk0+FIxidhGIxSCFHa5bfP3Q2TALbsAy9oyDc3qPx9VEhuwAIA
/CMnxgk9T7FiaUhN5hZF
=Yks2
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
