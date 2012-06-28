From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 16:08:23 +0300
Message-ID: <1340888903.5037.76.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	  <1340869729.5037.7.camel@deskari>
	  <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	  <1340878461.5037.30.camel@deskari>
	  <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	  <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	 <1340881815.5037.53.camel@deskari> <4FEC47FA.1040801@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sE62iF8Y889KbNv0Vewl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39254 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306Ab2F1NIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 09:08:30 -0400
Received: by lboj14 with SMTP id j14so3628643lbo.35
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 06:08:26 -0700 (PDT)
In-Reply-To: <4FEC47FA.1040801@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org


--=-sE62iF8Y889KbNv0Vewl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 20:03 +0800, Andy Green wrote:
> On 06/28/12 19:10, the mail apparently from Tomi Valkeinen included:

> > For this to work like you want we need a bigger restructuring of HDMI
> > and partly omapdss also. Currently we have just one big "enabled" or
> > "disabled" state. We need multiple states. Probably something like:
> >
> > - disabled, everything totally off
> > - low power, hotplug detection enabled
> > - powered on, but no video
> > - video enabled
> >
> > Been long in my mind, but I'm not very familiar with HDMI so I could ge=
t
> > my simple prototypes to work when I tried something like this once.
>=20
> That doesn't sound too hard since the difference between the first three=
=20
> states at the HDMI chip is just whether the two gpio controlling it are=
=20
> 00, 10 or 11.

I don't think it's that simple. We should be able to do EDID read on one
of the states, perhaps second or third. For that we need parts of the
HDMI IP to be enabled.

Also, the third state should be something where the IP is fully
functional. For DSI this would mean that you can communicate over DSI
bus etc. So I guess EDID read should be possible at this level.

> If Jassi's alright with it we might have a go at implementing this, but=
=20
> can you define a bit more about how we logically tell DSS that we want=
=20
> to, eg, disable HDMI totally?

Disabling HDMI is easy, it's already done by the disable call. And the
same for the video enabled mode. The middle ones are the ones that need
implementation.

And for HDMI, there's currently no way to enable it partially. This is
what I tried with my quick hack, but I couldn't figure out what parts
need to be enabled (but I didn't spend much time on it).

This is something that should be implemented for all outputs, obviously,
but we could approach it bit by bit. For example, implement it first for
HDMI, and all other outputs just consider anything else than "disabled"
as full enable.

 Tomi


--=-sE62iF8Y889KbNv0Vewl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7FdHAAoJEPo9qoy8lh71+VcP/0HEn8wOOPsEjKh8nsYYX0uG
pjrFwNEEcSVz0OoiwAI/GsBSD5ISZlaklWZ7mBW/wmTpJ1XVJNDuHpfj09SfAGNv
VcFRq5y3vvXh231nP4OOQiig17QmP15KCiqrzJHjqAiXNAStK8dBtPO+BzT8+Cyu
bhj6TgEGVXhQYJ5G7ntyQsOyV9H5t91gpZisTURawg64vHeZjdXX+lbeBmIHskKC
Sf8rU31ui67EIMjHVqdmLgcGD0PPhkXImXijLthec0ddF+YZZh2kAOIg2oz1TwgQ
U814Xh5UZEJvGxEbHwcPewNjZi4nxd2nEkxst/hTFZIJ6HJrc/zhdw0vhdW9EQhk
i9cH+4Pw7wGaaUsFTzArfWNE8ZFEiXi1U88HHFZ0vaJci35tHqSO3yKJ+PUTJa7E
PyRsS47oAGCxWZ2eeEWeq/B3QMfzFEzUmh04RMncmHSTbJLlb6imIuIWEa2S6W6q
XMENwG/9d9h7ve58+OUF5QesAJ1Yle1sBuQSKieaal9so2GulgcC9WT612JuntLS
zOYK0+th1nmLU2JOfSktwQqXOHIsQr5YGhkvX+w9IAc80mvP8OCqAyvhSGgsS5FL
Q8oGlnnKLcEXXGHdkySZqFN7oqhQYC3BkLKRe2txRkxWaYnbT9Uc5YUSi9HRA9IT
vOmEoDNYtPQLVrEM3Hr4
=g90J
-----END PGP SIGNATURE-----

--=-sE62iF8Y889KbNv0Vewl--

