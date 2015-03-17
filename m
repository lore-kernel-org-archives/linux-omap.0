From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/35 linux-next] regulator: constify of_device_id array
Date: Tue, 17 Mar 2015 17:19:06 +0000
Message-ID: <20150317171906.GQ28806@sirena.org.uk>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-3-git-send-email-fabf@skynet.be>
 <20150317121128.GH28806@sirena.org.uk>
 <1489228275.7513.1426612212420.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4CM1oNDqiDLyatGS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489228275.7513.1426612212420.open-xchange@webmail.nmp.proximus.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-omap@vger.kernel.org


--4CM1oNDqiDLyatGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2015 at 06:10:12PM +0100, Fabian Frederick wrote:

> Thanks Mark, I used a --cc-cmd script by Joe Perches with
> git send-email which uses --nom for cover-letter.

> This limits recipients to mailing lists: 37 instead of 123 in this case.
> I guess it's better to reduce the noise :)

Well, another thing to do if there's no dependencies is to just send
each patch separately - there's no real relationship between the
patches.  This also avoids the issue.

--4CM1oNDqiDLyatGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCGIJAAoJECTWi3JdVIfQSq8H/0wPmu2IEnTi0UjTEUDPgNPu
AVfKpTycC5czxXZaMIG+F6sAuMWkv9K0OAkadOIjvYhOUXhLa1mFSAKr8fDoeoei
LVvcMa5TJIrovvfYFl7CBfMhyZjRLQIxWmFAgtOXgmkuYw8cy3NahVKZyAnPxcsx
BM6vSiet8X9ICT7BU+HsNjlnTs7fbBFk1bnbAW5vPVPU91JIVRjOOyGLGIMTqHsV
gTa6ahm1znwIv3EaVMR7R7UxCHUUS/TnxXEFyRDxbPPpU/lZvgEMdxL3orglMgDM
s3TKuuSnXyZ3PL+RnQ/9o+aBtxaLfrtGmrGKbKz6hen3u/qQ21+9VYv4WxML2Ks=
=XfiZ
-----END PGP SIGNATURE-----

--4CM1oNDqiDLyatGS--
