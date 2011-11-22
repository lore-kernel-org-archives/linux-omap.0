From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Inclusion of ARM perf tree in linux-next
Date: Wed, 23 Nov 2011 01:36:46 +1100
Message-ID: <20111123013646.8acd19e7f4c615a7bf8306a4@canb.auug.org.au>
References: <20111122100435.GC20518@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__23_Nov_2011_01_36_46_+1100_gUb/y_o9JFQuQs4U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calzone.tip.net.au ([203.10.76.15]:34032 "EHLO
	calzone.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab1KVOhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 09:37:04 -0500
In-Reply-To: <20111122100435.GC20518@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, linux@arm.linux.org.uk, tony@atomide.com, a.p.zijlstra@chello.nl, arnd@arndb.de

--Signature=_Wed__23_Nov_2011_01_36_46_+1100_gUb/y_o9JFQuQs4U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, 22 Nov 2011 10:04:35 +0000 Will Deacon <will.deacon@arm.com> wrote:
>
> I maintain the ARM perf backend and would be very grateful if you could
> please include this branch in linux-next:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
>=20
> This request has arisen specifically from some work with the OMAP guys
> where it would be useful to spot any conflicts for 3.3, however I think i=
t's
> generally a good idea for me to give some of the perf changes an airing
> before they get merged anyway.

I have added that tree now with you as the contact.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Wed__23_Nov_2011_01_36_46_+1100_gUb/y_o9JFQuQs4U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOy7N+AAoJEECxmPOUX5FEqcoP/0l9cxLAqJYBIAsWVjEe8PxT
3vHH53OPjv6bz7RI2i6QTf3/Q7GlbZlej6G/4szKsdXnOO6dQv4/HP9X6R4IG5/7
Us5VTYP+gMVKfUa0g7/7XQERtqNwbTcWzj3qMeIcQaOF/IifghkMPq65FlpZbFOw
TuQco/aZaywQovq2Z1HJ3+YHlUsp4xUJHFjuFbxcOa4yhs366jM5n8QUuuhKXGTe
MWMFBLN9kuQQELRJKw1AO4eZpnJXbIC8V3F90JP3CsIN8k67Tva+0TXk86j+JcR3
sze2QiabPvOmtMGz/3HJgyquZL82zT1H4pL5a622Xbrl4Va3AZ7UghCfhy1Kg9mS
iozd27OtNOc2DhgW2gAOZqtw3e3glvUoWkTpk1Ah4DGIePqSHPLQF6TpZ4btxJXD
oDaZ7Fq9QNDsHUKg5hiGK96jsCRtWfNGPphEEsWnFVBmSxeOBXwRL4CWITsq08DB
ZmuF2Zi3xxPSHl+ADx7of4rsKYnzyaxGm28HNLLTVOYqihZdaAR0K13zHeDJ1IJ+
fk0HUoUBdoltunnGGdHzhpg5wsaDaJs/UgeLHCzdha3Q7YY4ClQ7KJJuywbFhYnl
MQqw0SB8aZVB9Z9+mnhPcfBlCWHBC8evkm4L2LZyxeCuXbm88AKr5gPmm8A7HBXI
qB1Zy+kqsLnZ3u/Li7mE
=OXSP
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Nov_2011_01_36_46_+1100_gUb/y_o9JFQuQs4U--
