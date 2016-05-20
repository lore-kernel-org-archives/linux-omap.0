From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.5-rc0 regression: GPRS breaks after very short while
Date: Fri, 20 May 2016 06:12:59 +0200
Message-ID: <20160520041258.GB22076@earth>
References: <20160518074924.GA20652@amd>
 <20160518141624.GA8025@earth>
 <20160518201251.GA22015@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160518201251.GA22015@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 18, 2016 at 10:12:51PM +0200, Pavel Machek wrote:
> > The last one only changes a comment, so not relevant, the other
> > two fix error handling during initialization and are most likely
> > also not the problem. Can you try to bisect the problem?
>=20
> It will not be fun, but I guess it is doable. But before I start it
> would be good to know -- does it work for you?

I currently don't have a second SIM card with network access for my
dev phone, so I usually only test without gprs connection. As a
result I don't really know if longer data connection would work.

Also I'm quite busy until next weekend with other stuff. If you did
not find anything until then, I will do some testing/debugging.

-- Sebastian

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXPo7IAAoJENju1/PIO/qaJFkP/RU/ORzboXBp4FrDV7bBbrNg
hycXkd0cxQ1CJeO+hK1Bd8URxLchBbJ2zjRm6uJOwCiG1Q7FYjSKilTZbbiRbdWT
JoC0T6kk/vFwONPzRq2JHp1JESVLiUQIyDBqkEGIlV62kwAcs6gjVjZJtFlKEm31
QgI8SMkphXqq32DnySW1EUuYabygeK1pYC3s6Ygh2nakmS+NARU8y7DVDazXTg70
69XRXQ7lwbpzrYyMLueD+Lw5+l6Zvf2xJqPVqDSvlty3euXyWwkMShyfhAHHellf
KPhNlyuu53/5TIK7htQSVXsuWB6MzOU/3gbP1QuyhHCg+7AIiNDEUdjq5y813o8f
zU66h5L2fZFBC2Cp4q5qW7Wbr4fIJB/cKpLIbhpMrzIAoH67N3P4QhGt0aEdzTIG
Pd61Tu8O857aVmtMlBAdZDcXWPrtWzilnjxQALFvFfDr8UNkTxVSQIJZCJUIwlft
PG0L11M9w/FIAc6Gmc26+EHXEnyGls23N/5Kv2zlaCvSlA9xC5PGJqgq0Tq/Abn6
GViZEGp5tCCJF9SIrvi/13o5Wf4k2DaMLfgtIsrKCBzvNKrMwxE/DvsAsakemD0r
4bqUC+mb9cFbpX//rncqtQBcKOrZsbvlEQ0aTAVmIAGin8XQ5JCfGhH+3Hn70mo0
sunm+NHzuPDWyFAS6FUw
=CcmG
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
