From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 13:35:30 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E31C@dolphin.TIGRIS.local>
References: <CAJe_ZhcnBnNhTkV1VXmh3kvkOo-NuYj6pNoxo0zN1TSKFnYmnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-Mt0pmhilNQBlnJ3n4nyM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:51148 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758028Ab2IRLgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 07:36:36 -0400
Received: from [217.91.135.48] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=06089b056d=maximilian.schwerin@tigris.de>)
	id 1TDw6U-0007Af-3m
	for linux-omap@vger.kernel.org; Tue, 18 Sep 2012 13:36:34 +0200
In-Reply-To: <CAJe_ZhcnBnNhTkV1VXmh3kvkOo-NuYj6pNoxo0zN1TSKFnYmnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org

--=-Mt0pmhilNQBlnJ3n4nyM
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] Im Auftrag von Jassi Brar
> Gesendet: Dienstag, 18. September 2012 12:23
> An: Maximilian Schwerin
> Cc: linux-omap@vger.kernel.org
> Betreff: Re: How to disable message "Uncompressing linux..."=20
> on kernel start?
>=20
> On 18 September 2012 15:37, Jassi Brar=20
> <jaswinder.singh@linaro.org> wrote:
> > On 18 September 2012 12:09, Maximilian Schwerin
> > <Maximilian.Schwerin@tigris.de> wrote:
> >> Hi all,
> >>
> >> I have been convinced that my patch for disabling the message
> >> "Uncompressing linux..." on kernel start was not all that=20
> good an idea.
> >> As the problem still remains an issue for me and I'd like=20
> to find a fix
> >> for everyone I'd like to ask for pointers where or how to fix this.
> >>
> >> To sum up my problem: I'm using the primary serial port on=20
> an OMAP3 as a
> >> debug console for development. In production we set the=20
> u-boot silent
> >> option which disables all kernel logging to this serial=20
> port. The only
> >> kernel message that remains is "Uncompressing linux..." at the very
> >> beginning. As we connect an external device via this port=20
> in production
> >> environments this is not acceptable.
> >>
> > Perhaps adding config choice under "Kernel low-level=20
> debugging port",
> > to select the UART port to direct the early prints to, would help.
> > Like some platforms already do. See DEBUG_CLPS711X_UART1/2 ,
> > DEBUG_MSM_UART1/2/3 etc.
>=20
> On a second thought, I think we need a new config independent=20
> of DEBUG_LL.
> Something like what Samsung code does with symbol
> S3C_LOWLEVEL_UART_PORT in arch/arm/plat-samsung/Kconfig

In my case I need to be able to disable it completely.

--=-Mt0pmhilNQBlnJ3n4nyM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBYXL4ACgkQ6nqkzTWctv4BNQCgyXVQbMTkWJ0/Y0a/W0zJ6Fev
O9oAoJ8NFSiVK+2jpwXpw05Y22/UtZyq
=ENTB
-----END PGP SIGNATURE-----

--=-Mt0pmhilNQBlnJ3n4nyM--
