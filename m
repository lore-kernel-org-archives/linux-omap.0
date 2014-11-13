From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/5] video: omapdss: Add opa362 driver
Date: Thu, 13 Nov 2014 18:41:10 +0200
Message-ID: <5464DF26.2010707@ti.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com> <1415830247-31633-2-git-send-email-marek@goldelico.com> <54649B43.1000801@ti.com> <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LX7QdeE9Ro2bnE0XeKoO9WI8HNqbn3XPQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9FD016B8-4EA2-4A0D-B790-6494AB449B31-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--LX7QdeE9Ro2bnE0XeKoO9WI8HNqbn3XPQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/11/14 18:25, Dr. H. Nikolaus Schaller wrote:
> Hi,
>=20
> Am 13.11.2014 um 12:51 schrieb Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>:
>=20
>> On 13/11/14 00:10, Marek Belisko wrote:
>>> opa362 is amplifier for video and can be connected to the tvout pads
>>> of the OMAP3. It has one gpio control for enable/disable of the outpu=
t
>>> (high impedance).
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>> ---
>>> drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>>> drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>>> .../fbdev/omap2/displays-new/amplifier-opa362.c    | 343 ++++++++++++=
+++++++++
>>
>> I think it would be better to rename this to encoder-opa362.c. It's no=
t
>=20
> When developing this driver we did simply rename the encoder-tfp410 fil=
e,
> but thent hough that it does not fit into the =84encoder=93 category, b=
ecause we
> would expect something digital or digital to analog =84encoding=93 whic=
h it does not.

That is true, but we already have other "encoders" like
encoder-tpd12s015.c, which also do not encode. "encoder" in this context
means something that takes a video input, and has a video output. In
contrast to a panel or a connector.

>>> +
>>> +	in->ops.atv->set_timings(in, &ddata->timings);
>>> +	/* fixme: should we receive the invert from our consumer, i.e. the =
connector? */
>>> +	in->ops.atv->invert_vid_out_polarity(in, true);
>>
>> Well this does seem to be broken. I don't know what the answer to the
>> question above is, but the code doesn't work properly.
>>
>> In the opa362_invert_vid_out_polarity function below, you get the inve=
rt
>> boolean from the connector. This you pass to the OMAP venc. However,
>> above you always override that value in venc with true.
>>
>> So, either the invert_vid_out_polarity value has to be always true or
>> false, because _OPA362_ requires it to be true or false, OR you need u=
se
>> the value from the connector.
>>
>> Seeing the comment in opa362_invert_vid_out_polarity, my guess is the
>> latter, and the call above should be removed.
>=20
> Yes, you are right - this is not systematic.
>=20
> But the problem is that we can=92t ask the connector here what it wants=

> to see. It might (or might not) call our opa362_invert_vid_out_polarity=
() later
> which we can then forward to overwrite the inital state of this opa362_=
enable().

You don't need to ask. The connector calls invert_vid_out_polarity
before enabling the output. You can just pass it forward inverted, as
you already do in this driver. If it doesn't, it's either a bug or you
can just rely on the value that is already programmed to venc.

>> We are going to support only DT boot at some point. Thus I think the
>> whole platform data code should be left out.
>=20
> Is there already a decision? I think it should not be done before. And =
it
> does not harm to still have it.

It's just a matter of time. I don't accept any new boards using platform
data for display, or new display drivers using platform data, because I
don't want to spend my time converting them later. And as this is a new
driver, no existing board can be using the opa362 platform_data. So we
can support DT only.

 Tomi



--LX7QdeE9Ro2bnE0XeKoO9WI8HNqbn3XPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZN8mAAoJEPo9qoy8lh71LXYP/0QNZyypw8Ax4IKs9k3/B4KA
rvowtV1BwKR4uG0dJgdTDWZeFkcVu/cdIqeRFXiZu6YQTHFpMqJ2/BqSL8BLKHoR
7xg6M5AzPgr/6XEjPJmwC+8Mg0TVV2NHhHVW93A7wMCANY4p3MiQBKpdvTtWbrc3
2lNcQQZ2RC9uuWpqNtxLIgdluo6ru6efQfhdUdRCuNlyMkWFaIZ9fTWO36fQLp5m
RKnArfVijMuZfYRAW6Y8TpBlXueFz49IAG+weCvVStYjmCQ5FCla0lbvRWsj4Ucq
AYdM2bS8ZhxK/ecVwY2vnUg3W+9JvKRLYvYb3RWWz9P8xq3AYm/KLOHqTUNxpN/n
djjGsBS4jLQVYNSDpdulFf6pjD+Zirrek5YHTn8OP7fQqRQB7SFfcO7vcNMcT/YL
5h5Y+JTe5oiO4zss+zuP0t8oI+/5+jdJKZE8qVYQx1IqnRml8qM2YNhm7FabKW1S
vqs6uhP1Anlb+zy5Ca/tGXycoWQ6ZV+rMWQWqMDATeSvksBtvu7PdOsVsyEk/nfe
iqd4QR649t55I1VrsNxUPD45fx4jnR7f9v7V4Yhq6NQtDCD9UIhs1xXS1RvyvVC2
Q4UT1iDfP2fqLFSvY8ACqVD+e8qEbgvra8Gj37/t/6B9rv6SHz5CDLyqQDZnRDpn
/8T7qRIsM7xzTTL8/gAT
=y8BJ
-----END PGP SIGNATURE-----

--LX7QdeE9Ro2bnE0XeKoO9WI8HNqbn3XPQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
