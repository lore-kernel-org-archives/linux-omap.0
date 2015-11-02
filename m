From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: improve ->remove() callback
Date: Mon, 2 Nov 2015 10:06:04 -0600
Message-ID: <87si4oo07n.fsf@saruman.tx.rr.com>
References: <1446127050-5957-1-git-send-email-balbi@ti.com> <563778B8.9060109@ti.com> <87bnbcctsk.fsf@saruman.tx.rr.com> <56378492.702@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56378492.702-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 11/02/2015 05:20 PM, Felipe Balbi wrote:
>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>=20
>>> On 10/29/2015 03:57 PM, Felipe Balbi wrote:
>>>> there's no need to call pm_runtime_get_sync()
>>>> followed by pm_runtime_put(). We should, instead,
>>>> just call pm_runtime_put_sync() and pm_runtime_disable().
>>>
>>> Sry, but why do we need to call pm_runtime_put[_sync]() here?
>>>
>>> My be just pm_runtime_disable() will be ok?
>>=20
>> and disable with unbalanced pm_runtime_get() ?
>>=20
>
> Which one is unbalanced pm_runtime_get()?
> There are no  pm_runtime_get() in probe, so there you are
> going to introduce unbalanced pm_runtime_put_sync() actually :(

look at ti_qspi_setup(). I _do_ see, however, that it calls
pm_runtime_put_autosuspend() in the same function; what happens if
driver is removed after ti_qspi_setup() runs but before
put_autosuspend() has time to actually run ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWN4nuAAoJEIaOsuA1yqREl5UP/0PGJyApyBK7KhPWOVK81l15
uWO/qCyYOcjM6M0/MRQHs6kikdLGiuU2r4sTfLDJ7z/iLyxCG96mNKUYoSe9DZbk
26o5NHD1RmL0ngqp5Kh1s2tuFbrsdnhLCMctMQ2ylCU+4qEl/erkC2VPcUoqq8z9
r4kCv3AjppDsApk5t4e8OsM3k5zDhS/eEbGnIOdiAKcT6752I5wAkyGQD5cJNI2F
yLIvNz9q6MBGfAZkaqfQJeIDsDquUSE0HwqVJlY2nNGGkG6oQQ1Kgb51SODKfxI0
bagPcYAa9pjSOFZkrMPBt+DwcwvC0ro03IPKIVyixGpiD7shMtwxOqioOk08Z9Uy
72Nahv0hMiUgd+FAYeBRPkfsSMdom3RGm3UXncLsGqDCVHFgzks2bgg9E1OAxa2g
GsjcR2DvMyVwZnzjVr9ynCRPc6UeJga1Dsyyju08ZinN0G77+7OyoCgZPb+wxwoN
wNVhvhP/TYDvPjeW6txJvzOBYq/sNVWU8m7pgqRwyaZj+u8NJzVB/SzbV1FvQA9v
mDhJBlasBp90vebjmESYFXinkC66gaw8MNWwtVwKNPRgNyiZCk7Z4c86mqvWSXwo
aNN4DxOl9BgAsWGtq6vwgGIpvF75T/LR/ZikeK/jBJB9cGWsh1IYIDrUkZB8sV4x
CWzKl+vPl5vsj8NqFnXP
=dojI
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
