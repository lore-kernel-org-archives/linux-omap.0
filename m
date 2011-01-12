From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 2.6.37-omap1 tag?
Date: Wed, 12 Jan 2011 12:04:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101121121450.5731@utopia.booyaka.com>
References: <0C40218E-D65B-4DAE-ABBB-0CB1A02A0E5E@dominion.thruhere.net> <0a8f7e11ed463078411f7692ea233a92@mail.gmail.com> <20110111163454.GS4957@atomide.com> <CA2B2459-D659-4CA9-9D1C-09C65A37DDE6@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-619561520-1294859041=:5731"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45163 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab1ALTED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 14:04:03 -0500
In-Reply-To: <CA2B2459-D659-4CA9-9D1C-09C65A37DDE6@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, l-o List <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-619561520-1294859041=:5731
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Jan 2011, Koen Kooi wrote:

> Op 11 jan 2011, om 17:34 heeft Tony Lindgren het volgende geschreven:
>=20
> > * Anand Gadiyar <gadiyar@ti.com> [110111 03:04]:
> >> Koen Kooi wrote:
> >>> Are there any plans to do a 2.6.37-omap1 tag?
> >>=20
> >> Given that linux-omap is now closely tracking mainline, is
> >> this still needed?
> >=20
> > Those tags are no longer needed, the mainline kernel is now the
> > stable kernel and should be used as the base for any distros
> > or products.
>=20
> It turns out that l-o head (.37-rc8 currently) and Linus' .37 differ a=20
> lot,

Tony's master branch is basically a development branch.  It's rebuilt=20
often, and it's up to Tony what gets added or dropped.

The patches that Tony sends to linux-next, and then Linus, go into Tony's=
=20
omap-for-linus branch.  That branch includes changes from other OMAP=20
maintainers or submaintainers, like Kevin, Beno=EEt, myself, etc. =20

A significant amount of effort is focused after -rc6 making sure that=20
omap-for-linus builds cleanly and that features important to us work.  Of=
=20
course, sometimes we miss things, but in general, omap-for-linus receives=
=20
much more OMAP maintainer testing than Tony's master branch.

> so after spending an evening fruitlessly trying to rebase my=20
> patches on top of Linus' .37 I decided to go the other way and just do=20
> 'git format-patch v2.6.37-rc8..v2.6.37', apply those on top of l-o rc8=20
> and then rebase my patchset on top of that. That was 5 minutes of work.

Sounds fine if you are creating Koenux.  If not, I guess you'll eventually=
=20
need to rebase the patches on mainline anyway.


- Paul
--155748971-619561520-1294859041=:5731--
