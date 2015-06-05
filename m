From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20150604 build: 2 failures 37 warnings (next-20150604)
Date: Fri, 5 Jun 2015 18:16:52 +0100
Message-ID: <20150605171652.GB14071@sirena.org.uk>
References: <E1Z0YIL-0008Ma-5O@optimist>
 <20150604170112.GM14071@sirena.org.uk>
 <20150604171004.GZ30984@atomide.com>
 <20150604172026.GA30984@atomide.com>
 <20150605104900.GA5346@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F2YjuSVvMy0XUwbk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44044 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbFERRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2015 13:17:07 -0400
Content-Disposition: inline
In-Reply-To: <20150605104900.GA5346@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--F2YjuSVvMy0XUwbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 07:49:00PM +0900, Greg Kroah-Hartman wrote:
> On Thu, Jun 04, 2015 at 10:20:26AM -0700, Tony Lindgren wrote:

> > Greg, there's now commit 9809889c708e in tty-linus and commit
> > 9e91597f2423 in tty-next.

> Yes, I can't go back and remove the one in tty-next, I'm guessing when
> they are merged there is an issue.  I'll look into that after Linus
> pulls in my tty-linus tree.

Yeah, git isn't always spectacularly good at resolving add/add if
there's context changes between two things in a merge - it sometimes
ends up double adding things.

--F2YjuSVvMy0XUwbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcdmDAAoJECTWi3JdVIfQrGUH/0DZ+yHuI491OC5C8E2h9YvC
2CiteLgjAibMN5WNBRByyUdlcqNmL80YNkKhnaj+O7Q7yjKrmXGmwv1VfzxKMMZD
nqPRU2pU9jiKczozAwlT/ru3yMgCKvzXSXwfJ+OgxP4OjtuoiOnntZ7Lat/WT2L3
KtXQBrhdo24WMhzAX8T7xJLDjTTHQIkW0ffM6yyZ8BvPgTZW/bXpRGX6rn83Vtgd
uAQha+HtamqUsBhzD1wbuLdyX3LF4nMKfF6N3eLxCsyHze4ISeMb2us69nqcEij3
ZnGqWPvp9b/EjBjdGR7K3tyW3ComxF9O672OnsCuGaiABz3VNXIfzkG0r6FvH00=
=oPzJ
-----END PGP SIGNATURE-----

--F2YjuSVvMy0XUwbk--
