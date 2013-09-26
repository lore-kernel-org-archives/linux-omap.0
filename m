From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Thu, 26 Sep 2013 15:54:47 +0300
Message-ID: <52442E97.9060704@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com> <5242EBB7.2090006@ti.com> <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com> <5243EE61.3000408@ti.com> <F101C925-6FA8-4813-955D-1B145FB2711E@goldelico.com> <52441F5A.2040102@ti.com> <54A492D6-DE01-4EF4-90CA-1ADF2B6CE8D2@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="epq2r4IhJVtv1OlmumXXi8KJdka6Q0Rfr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657Ab3IZMyx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 08:54:53 -0400
In-Reply-To: <54A492D6-DE01-4EF4-90CA-1ADF2B6CE8D2@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

--epq2r4IhJVtv1OlmumXXi8KJdka6Q0Rfr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/09/13 15:37, Dr. H. Nikolaus Schaller wrote:

>>> Although one could argue that one is just controlling the GPIO and th=
e other
>>> one is controlling some regulator...
>>
>> Sorry, didn't understand that one...
>=20
> I meant that there could be a differece between enable/disable and powe=
r-on/off
> (e.g. retaining register values vs. loosing everything). But I can't im=
agine that for
> a simple video amplifier.

Ah, I see.

I'd still say there's just enable/disable from outside point of view.
It's the driver's job to make things work so that configuration values
are retained. If the hardware component is turned off so that it loses
register values, the driver should first store the configuration into
memory.

So internally there may be different power levels, maybe some kind of
timers to switch the component totally off if it's been disabled for
some time, or such. Externally, I don't think those need to be visible.

> Well, we can't boot w/o the board file yet for other reasons, i.e. a DT=
 only
> approach isn't our target yet.

Sure, I'm fine with board file only version. My point was just that the
solution should not be such that it's impossible to support with DT. For
example, callbacks to board files are not possible with DT, so a
solution that relies on callbacks to board files will not be accepted.
And similarly board init calls are not supported with DT, so not acceptab=
le.

>> I don't want to make this more confusing, but... I wonder about the
>> connector_type field. It's only function is to pass the value to VENC,=

>> which will then work differently. And it's also something that cannot =
be
>> changed at runtime. Perhaps that, too, should be moved to VENC's
>> platform data.
>=20
> I was also thinking about this topic. Well, the connector type is corre=
ctly
> a property of the connector... But it logically controls some registers=

> in the DAC Output stage. So I had thought that the opa362 driver will
> hand it over to the VENC and could check if it is really a composite
> video (since AFAIK the OPA can't be used in a S-Video sytem).
> But that again would be another chain of information flow from the
> connector to the VENC making their APIs dependent.

Right. I'm a bit leaning towards having it in the VENC platform data,
and removing it from the connector.

Well, it's not directly related to the issue at hand. You may just pass
the connector type through OPA, and we can look at changing the
connector type later. But if you want to have a try with the connector
type at the same time, please go ahead.

 Tomi



--epq2r4IhJVtv1OlmumXXi8KJdka6Q0Rfr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRC6XAAoJEPo9qoy8lh71tqgP/09Pkh1oAM0LfAXmWL1F0Dbn
EnmYNKa+mkAkBKQHzfQ8LMrqxQrzKNAZR9hkZIGnWeghfVzxB16tm54Wgncv09+S
Ruy4EB5tCSpgoVCgkUt5SNo6DLarYcmp3FuuOKkzBmka93zgzdaeJ6ZJsWVPS43d
GegffbzL1H5fT3mXypErALNEU+FUBHjTYrGvwVFW9riciXMYoNYPfqTNkCdQWzE8
RCCQMF63ZiW4U5zH+8CBPaJ0sI+f6fnOJ/zcBiq6Q3VLSKpnbEScP4gV2zjMWg08
jpQUaTJ5EbOM03IReLjdDOTRJJpeO0l9F5FB2Zn3tQTUrELB1RBQ3afXOd0eOq+s
6wrxYppyP0wkgWEWfDrv0ogWim4qJn5KR4nbDuz1vXM3EmbsvjoIMWjGih5cVGAY
Izuq0xRQFsqEvJvLKdG5WnzcO1bNROL7SVnMaHZA4sj8VnD9M0ZRduMgdxSYCxVe
9bYB8yrcteNcSzO/Cb+fWUJDsJWR5dY+f7MvQ3zsz9fNZKIGP45bZ7QpUuvgvMjC
GfGUEby1pX1evv6OuGhAJ2Cr7tt4iJuSMd5qbVo5MLj7lYjRgvAKWa0c1bEthS//
NJphs5QWzF9yCoJR/uWRALB6IPg3EsQsLSx6ZO6wKxq+q9B6f0F2oAurHCegUS3j
LjKNjGIfUzGKTm3x3hLn
=UDOR
-----END PGP SIGNATURE-----

--epq2r4IhJVtv1OlmumXXi8KJdka6Q0Rfr--
