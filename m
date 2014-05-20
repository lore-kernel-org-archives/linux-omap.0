From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 20 May 2014 08:21:19 +0300
Message-ID: <537AE64F.4020907@ti.com>
References: <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com> <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com> <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com> <20140520045748.GA28812@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Rw174HVeVPPMlb1VpDXpRvsRWUgRn2lMe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53980 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaETFVw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 01:21:52 -0400
In-Reply-To: <20140520045748.GA28812@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--Rw174HVeVPPMlb1VpDXpRvsRWUgRn2lMe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/05/14 07:57, Sebastian Reichel wrote:
> Hi,
>=20
> On Mon, May 19, 2014 at 09:57:18PM +0300, Tomi Valkeinen wrote:
>>> 3. Having to maintain a database in kernel of display mappings separa=
tely
>>>    in addition to the .dts files.
>>
>> Yes, that's slightly annoying. Not really a big burden, though, as it'=
s
>> quite rare to get a new encoder or panel driver.
>=20
> I wonder if the "omapdss," prefix could be added to *all* remote
> endpoints seen by omapdss. Pseudocode:
>=20
> for each port in dss {
>     for each endpoint in port {
>         panel =3D get_phandle(endpoint, "remote-endpoint");
>=20
>         /* only add prefix if it's not already there (kexec) */
>         if (panel.compatible !=3D "omapdss,.*")
>             panel.compatible =3D "omapdss," + panel.compatible;
>     }
> }

Hmm, yes, I think that would work. It would remove the need for the
database, but the code would be slightly more complex as we'd need to
travel through the graph, not just the nodes that are directly connected
to omapdss. I need to try this approach also.

 Tomi

Ps. Sorry for misspelling your name, twice. If I recall right, I even
checked if your name is written with an 'a' or an 'e', but somehow still
managed to get it wrong.



--Rw174HVeVPPMlb1VpDXpRvsRWUgRn2lMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTeuZPAAoJEPo9qoy8lh71HecQAIUfK7fGdPc0wzbxBYco52ob
ihcH084kqYmRowE/INlVX6RRs/AOY7hUpBGFJvGoLNyJyQt2hepnb6IzvfTLvKS1
EIZ60StRGprISzAH5kvoJK2KUaL/gD9OsZs7qTsbWQ349WhWDZP5vLb59Dgxrxw3
R+lCwpSp0SgIQEugkT+SxHwLL0VPKr2cJKJVzxHahO3TpzLlojoQoNrIiVvZ9qjR
iPT7QeDyKlGZerA7ewvhHcI105KtMM9k+EBlQlLTPFmvvRsR4o+KIEl7uLYbZcfH
upmdI0BtYY4J86qZed1K0O/pa5uR1T9hSnjtC1TSbxMs6j4diOeOTUpIIQc6EAOk
nPcGr9VSL5SIEYiWDvmGO3KRU+adpkWlIIxp1+GKmOwxGN793pivzTnzSde6m+h2
wDqU3oO1KTxPZFlSLUr5hjXHZycqsd2zoT11eycAONXPfaC+ojT8jfT4a0P+po0k
I35G/8akmKQGUW2aQdfb6/fQrnmP3Kpl2gzSG9DlC4pbng1JKNZLh+6O9iC7GpkW
nfFab/A6hLT1lNXXzCTBdYheOCu4Eyq2zkQEk2yAwUoR12pLeVNWwo26oyeA82Sa
jwPPhxQolRkEnB6zdP0Tuv2emIM5XUHX6tKTfa/Ya4XWsbrpEDmgykhAt2VZfsLQ
1T/m17F94IxTWUOOxPOS
=cous
-----END PGP SIGNATURE-----

--Rw174HVeVPPMlb1VpDXpRvsRWUgRn2lMe--
