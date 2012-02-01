From: NeilBrown <neilb@suse.de>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Wed, 1 Feb 2012 18:51:52 +1100
Message-ID: <20120201185152.08336b18@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
	<20120118082410.48262777@notabene.brown>
	<alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
	<20120124213705.49f042bf@notabene.brown>
	<alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com>
	<20120128093530.0a0a370a@notabene.brown>
	<alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com>
	<20120128114012.1bd76ca5@notabene.brown>
	<alpine.DEB.2.00.1201271813260.13783@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/N_v=aW+6CpGSrLNie1wjLNd"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab2BAHw1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 02:52:27 -0500
In-Reply-To: <alpine.DEB.2.00.1201271813260.13783@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/N_v=aW+6CpGSrLNie1wjLNd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jan 2012 23:02:51 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:


> Since the HDQ module doesn't support the idle protocol, the target clock=
=20
> FSM in the CM is what should determine whether the module is considered=20
> idle or not.  And as long as the bit in the CM_FCLKEN register=20
> corresponding to HDQ_FCLK is set, the FSM should consider the module as=20
> active, and the clockdomain should not be allowed to go inactive.
>=20
> I write "should."  Given that big caution at the bottom of section 20.4.5=
=20
> "System Power Management and Wakeup", this appears to have not been=20
> correctly implemented.

Can you help me understand why you say "should" there.
You seem to be implying that a down-stream clock gate should cause an
upstream clock to stay active, but that doesn't make sense to me given the
presence of the much richer SIDLE framework.  Also I cannot find it in the
TRM (though there a lots of words in there and I might have missed some).

Most modules use SIDLE to keep the upstream clock active.  HDQ doesn't have
that so it needs software over-rid to keep it active.

>=20
> > It also mentions the AUTO_HDQ bit of PRCM.CM_AUTOIDLE1_CORE.  This had =
me
> > confused for a while, but I think it only affects the iclk. =20
>=20
> That's correct.
>=20
> > I don't think the iclk is the problem.  It is the fclk that is=20
> > disappearing because the clkdm that feeds it is being turned off.
>=20
> Disabling AUTO_HDQ is probably a reasonable workaround.  It would prevent=
=20
> the CORE_L4 clockdomain from going inactive, and that happens to be where=
=20
> the functional clock originates from, also.
>=20
> We have a partial facility to handle this type of bug in the existing=20
> code.  Could you please try the patch enclosed at the bottom of this=20
> E-mail and see if it helps?

Yes, that patch fixes my problem too - the HDQ keeps working.

(it's a bit smoke-and-mirrors though .. I want fclk to stay on, so let's ma=
ke
sure iclk doesn't autoidle, because we *know* they have the same source :-)


Thanks,
NeilBrown


--Sig_/N_v=aW+6CpGSrLNie1wjLNd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyjvGDnsnt1WYoG5AQKcpg/+PmPGWxy4TCZ+WWvok2d0ncAriF9jEip/
ZLGYT8pRyrSzvbEaaTv6oMtT8RO7JqBOiKTKyG+yiQPfwV+MEsmc3nKrtVzgKj0+
DMMwBLy/nww7QD9uEoXlz1Riq5stvVYkLtxehEtkXPi2/dhPZa1ZIP3LZJ7uTdiP
3dj4HoYsttMcTcDJNTBirheLTMQs+V9G9TaSXkaUxPe2sStSPMGL9QDvu5PBmCdJ
+4FuFi5XYf/VSgY0qwuvPhOwgpWBTlhiupSwjCCtBTcn310Q+ZHyMtfWF++B1lkn
IljSoRInTvmWpMncepZZEM2vkDQkrh8oLvaoE/vPG6NActWxelSgpG6Za4D8rKPP
XPdIKJM4y+SRqRHkFYYldcndWQmJ/qFN2W7by5xQ0kfYCbH+QizdKs+ZBw9hJFPo
LtoXxHtJdUHKSyWZwsJxyUgsU++lzHXG9djiVZsd1JGnTUQOuLGnb2WiJDtW+jwV
ct9TLFUjLGFj+jSDitELlA1woh7kvNeJTGNvjHOziRcTEyDPIQpk5bQWBoLBu/GK
L40cJE3KhJuCJBh0bk2CAmpJtWGlcLbbK0qK1gds7x/2GCmT1iVt4nAQduQVqa07
9jr8u9PRd6aKtvnAG9vzG7M0yjGptNkKV/9v1nGrD2EMw/i/DKaSnc6IHxoqX5O8
lamZNR6tM40=
=er0Q
-----END PGP SIGNATURE-----

--Sig_/N_v=aW+6CpGSrLNie1wjLNd--
