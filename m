From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 17:23:22 +0000
Message-ID: <20160325172322.GC5028@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <20160325164750.GA14392@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325164750.GA14392@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 05:47:50PM +0100, Sebastian Reichel wrote:

> I just tried to describe what's going on, so that you can see the
> whole picture. I don't agree with the patch and think that the mode
> should be switched to normal at probe time. I assumed, that you
> would suggest the correct solution if I describe the problem.

Well, I'm not 100% sure what's going on.  If there is a constraint in
the system that requires setting the mode then something needs to
set that but it sounds like it might be more the case that the mode
support in this driver is just broken at the minute if it's not
orthogonal to the enable support.  Perhaps the mode API is being used
for suspend states or something?

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9XQJAAoJECTWi3JdVIfQPiMH/0g6jatd3XA7uxUlQMYSiShJ
blohLZ4fCrlLd66NxiZWMJozLqIvIxzsCmFqRoLnsD6cNrK4EknNP5WMN5h6U30I
yjBph+kWq4+gOgV3gnzri/S0eeYQaXlkaB1+RtJJYBj/I2UFVGMcH1RU6JsYgKv1
5jjiezNWSNR+0P9UKqv+XkmgrWANTpfRUtBbfdTkqCAdf2JvAhldDM93qI7D1YEy
NcR2zqsj5uO/y9HCNy/9sUsvguCqWMpfP+nVNSNu8r4JHfFhNs4RYpjCN/SmhYYw
3rp6kc8/8Tml2m2IdAqGFVvRZnxOG6BQ3N1Zppxf3fkZH4MZkWZl08x+1BplkL8=
=IbZa
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
