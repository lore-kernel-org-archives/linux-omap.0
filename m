From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Sat, 9 Jan 2010 13:47:31 +1100
Message-ID: <20100109134731.a1bca240.sfr@canb.auug.org.au>
References: <20100108180912.GC6831@atomide.com>
	<alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
	<20100108182236.GE6831@atomide.com>
	<alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
	<20100108222715.GC2879@atomide.com>
	<alpine.LFD.2.00.1001081430210.7821@localhost.localdomain>
	<20100108225023.GD2879@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__9_Jan_2010_13_47_31_+1100_Hw95CVMhFaGBIeaV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:56344 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab0AICri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 21:47:38 -0500
In-Reply-To: <20100108225023.GD2879@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--Signature=_Sat__9_Jan_2010_13_47_31_+1100_Hw95CVMhFaGBIeaV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, 8 Jan 2010 14:50:23 -0800 Tony Lindgren <tony@atomide.com> wrote:
>
> Hmm, sounds like it might make sense to check for that in Stephen's
> for-next tree then. Added Stephen to the loop, let's see if what he
> thinks.

I can certainly add hooks to my tree if someone can suggest what should
be in them (I didn't get enough context here ...).  That way I could send
the tree maintainer a warning email letting them know something is
fishy ...

Of course, this only helps those who don't mind rebasing their trees,
right?  The non-rebasing tree maintainers should do these checks
themselves.  Maybe we could propogate a suggested (or mandatory) set of
hooks?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__9_Jan_2010_13_47_31_+1100_Hw95CVMhFaGBIeaV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktH7kMACgkQjjKRsyhoI8yekgCgrH/rD3jyEDsv67aB3L9hb8ig
ls4An2+HvTqM91K8Cb99yxdZPuiJKGlb
=vk9i
-----END PGP SIGNATURE-----

--Signature=_Sat__9_Jan_2010_13_47_31_+1100_Hw95CVMhFaGBIeaV--
