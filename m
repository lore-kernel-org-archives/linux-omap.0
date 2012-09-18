From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 14:11:07 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E31D@dolphin.TIGRIS.local>
References: <CAJe_ZhcEvW+M3OwvwDtH62pEDbaUwbZoy0ewpmYEUabu_3VfEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-OujPlmAsB2yh5g/dXIhO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:59112 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab2IRMMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 08:12:10 -0400
Received: from [77.12.73.83] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=06089b056d=maximilian.schwerin@tigris.de>)
	id 1TDweu-0006pz-Vu
	for linux-omap@vger.kernel.org; Tue, 18 Sep 2012 14:12:09 +0200
In-Reply-To: <CAJe_ZhcEvW+M3OwvwDtH62pEDbaUwbZoy0ewpmYEUabu_3VfEA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org

--=-OujPlmAsB2yh5g/dXIhO
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] Im Auftrag von Jassi Brar
> Gesendet: Dienstag, 18. September 2012 13:54
> An: Maximilian Schwerin
> Cc: linux-omap@vger.kernel.org
> Betreff: Re: How to disable message "Uncompressing linux..."=20
> on kernel start?
>=20
> >> > On 18 September 2012 12:09, Maximilian Schwerin
> >> > <Maximilian.Schwerin@tigris.de> wrote:
> >> >> Hi all,
> >> >>
> >> >> I have been convinced that my patch for disabling the message
> >> >> "Uncompressing linux..." on kernel start was not all that
> >> good an idea.
> >> >> As the problem still remains an issue for me and I'd like
> >> to find a fix
> >> >> for everyone I'd like to ask for pointers where or how=20
> to fix this.
> >> >>
> >> >> To sum up my problem: I'm using the primary serial port on
> >> an OMAP3 as a
> >> >> debug console for development. In production we set the
> >> u-boot silent
> >> >> option which disables all kernel logging to this serial
> >> port. The only
> >> >> kernel message that remains is "Uncompressing linux..."=20
> at the very
> >> >> beginning. As we connect an external device via this port
> >> in production
> >> >> environments this is not acceptable.
> >> >>
> >> > Perhaps adding config choice under "Kernel low-level
> >> debugging port",
> >> > to select the UART port to direct the early prints to,=20
> would help.
> >> > Like some platforms already do. See DEBUG_CLPS711X_UART1/2 ,
> >> > DEBUG_MSM_UART1/2/3 etc.
> >>
> >> On a second thought, I think we need a new config independent
> >> of DEBUG_LL.
> >> Something like what Samsung code does with symbol
> >> S3C_LOWLEVEL_UART_PORT in arch/arm/plat-samsung/Kconfig
> >
> > In my case I need to be able to disable it completely.
> >
> The idea is to direct the output to some other (unused) UART port.
>=20
> Also if one doesn't select DEBUG_LL, I wonder if it makes sense to
> expect the "Uncompressing .... " message, which too is just dumping
> raw data onto UART. So another option might be to simply use
> CONFIG_DEBUG_LL instead of CONFIG_DEBUG_DECOMPRESS_KERNEL ?

In http://www.spinics.net/lists/arm-kernel/msg195871.html Russell King =
pointed out that the message goes to fb on some platforms. So the ideal =
solution would be to assure, that this message is not printed if the =
kernel parameter console is not set.=20

--=-OujPlmAsB2yh5g/dXIhO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBYZRUACgkQ6nqkzTWctv7EzwCfSapNYiLk5RaLuXVk/1Pt9+1v
1dQAn27srm9aa6RGkrfeUbXC6YTDzZ73
=7dVs
-----END PGP SIGNATURE-----

--=-OujPlmAsB2yh5g/dXIhO--
