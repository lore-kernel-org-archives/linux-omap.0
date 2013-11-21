From: Mark Brown <broonie@kernel.org>
Subject: Re: commit c368e5fc2a190923b786f2de3e79430ea3566a25 regresses MMC
Date: Thu, 21 Nov 2013 19:28:02 +0000
Message-ID: <20131121192802.GJ8120@sirena.org.uk>
References: <20131120175814.GC27423@saruman.home>
 <20131120203400.GL2674@sirena.org.uk>
 <20131120205143.GA9182@saruman.home>
 <20131121024840.GA22970@saruman.home>
 <20131121104911.GM2674@sirena.org.uk>
 <528E3817.1010105@wwwdotorg.org>
 <20131121183632.GE8120@sirena.org.uk>
 <528E5487.8000003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528E5487.8000003@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Felipe Balbi <balbi@ti.com>, ldewangan@nvidia.com, lgirdwood@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 11:44:23AM -0700, Stephen Warren wrote:

> Ah yes. I also have a delivery-time filter that remembers the last n
> Message-Id headers I've received, and it dumps any duplicates into a
> separate folder that I ignore. It seems to work pretty well. It looks
> like n==10000 for me right now.

Yeah, that wasn't working great - I think because I was doing it in the
wrong place and it was catching lists too.

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjl6/AAoJELSic+t+oim9deAP/RxujeAnxRBioT04WYCNofIX
FTdvQz5Ck5aFBG0b8rTiTiBz2E5ysypYxKPcQyU0WMZNLkI0ta9QhGv6/LnZN0nR
ueRQ9aYq28o/8MGrQr7owH4syRxOKuYA/um7/GV1UNv2hacFWVeoj9gDg1IxiJy2
tKnIaRWX3ndS/BEVI0lXNNzoXGJKeGHOGXK5XvQrrpaGdMYZvaVNdX3eSQqKRUx9
g9IEBFvvTMZISET7AWAOpkbvyDeUHS438SzQ3BkUPLhjmmslK0t/fpuheZS2CqFp
YlJxLpFzfWeUsNVWmgTVgUQvFz9Wy3U5qu2mD/tjdHHJK/urOqSLsoJXkKsVsWef
JlpbagLEq45IQ1vtHJLP37z/PADesx6gTAY7xq+hgeBe7Wz5HdZzhrfGEZKQwj9w
iENqF95oX2DDvMl1fM+efSMBXx2WKEa0pQoJVcgRxxejuxTRYhnKPN6v1FgIM4+q
KMfBugOqEIqKFJMErjjObaNepfo4njbRaYDqQSDK/qzrN8hlZNa8VYPiowBz5iF5
BOjefD2ZG/UvhKAT5jX4SQrq0+JtX+g04J32HsWa5wHytpoZdjd2HPu/LEuiF6gX
v89EK1NH9FBil5a/Bi/HgJ35zChQKPSAtkQVdtZefg6I4iOp3iPQmw7LqJztHhbi
yHVgHbE0q3UOsSMuEd1a
=RJ1E
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
