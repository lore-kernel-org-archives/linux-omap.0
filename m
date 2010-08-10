From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: beginner questions on being added to the linux tree
Date: Tue, 10 Aug 2010 11:09:15 +1000
Message-ID: <20100810110915.9e2ddc27.sfr@canb.auug.org.au>
References: <77A0A4DB5BF2A44283E5522C27234AC6021A5F78@EDPRSRV011.logicpd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__10_Aug_2010_11_09_15_+1000_=Hc/zAExi0O/_=_F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:39317 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440Ab0HJBJW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 21:09:22 -0400
In-Reply-To: <77A0A4DB5BF2A44283E5522C27234AC6021A5F78@EDPRSRV011.logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

--Signature=_Tue__10_Aug_2010_11_09_15_+1000_=Hc/zAExi0O/_=_F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

On Mon, 9 Aug 2010 19:36:01 -0500 "Jacob Tanenbaum" <Jacob.Tanenbaum@logicp=
d.com> wrote:
>
>             I work for LogicPD and am trying to add new support for
> there OMAP3 development boards to the kernel, I have a working version
> of some of the base support and was wondering how to get that ready to
> be merged in during this merge window. We have tested the code against
> the most recent version of linux-next I can get to build and was
> wondering where to go. Do I send merge requests to the linux-next list
> or a series of patches. I have sent patches to the omap and arm lists
> and got some minor syntax errors reported by them (spaces instead of
> tabs and the like) and was wondering where to go from here.

I only merge other people's trees, so you need to set up a git tree
somewhere and tell me (cc'ing linux-next and all other appropriate
lists/people) where it is and which branch to fetch.  I then fetch that
branch each day and merge it with everything else.

Getting your code merged by Linus during this merge window is up to Linus
and Russell or Tony, I guess.  But I cannot take new trees now until
after -rc1 is out.  So if you really want your code merged during this
merge window, your best bet is to convince Russell and/or Tony.

Having your tree in linux-next may be useful for ongoing development
unless Tony thinks it may be better for you to just submit your code
through his omap tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Aug_2010_11_09_15_+1000_=Hc/zAExi0O/_=_F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMYKa7AAoJEDMEi1NhKgbsKlgH/1ya/Z5VlKuMIORWRv8fF8x2
uDVifMt6M68IjVhUg/KUZAT9sNslD7oTFcj+ER3ilrF0dOIBmFbO5UTemujTnRVT
WlJBHDyh7K4T3OWPw5ufSBD8nFpKLsfaFpTA42b2GGt7cn4GkH/2W21uqDcbIOGR
lB7pm/IWjKxtfIkTBzeqlX/j8WZTCNurxp5fVjVQTJ+9Gtt/Fh8yJ1eoJGfQ/P6/
q31HnRpzMRgRDBJEJxeC7kRngn74vRtXhTtt4DXbjbpDvtGFROgwiOzTQv+ddSva
xTDojtul65kENWv+sVqLEyAeaoWzbXd7BGRktYK65VLLMPe4aGGAaRmoHvCpW5o=
=c24M
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Aug_2010_11_09_15_+1000_=Hc/zAExi0O/_=_F--
