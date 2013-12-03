From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] MFD: TPS65218: Add driver for the TPS65218 PMIC
Date: Tue, 3 Dec 2013 13:28:04 +0000
Message-ID: <20131203132804.GU27568@sirena.org.uk>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
 <1386053006-6480-3-git-send-email-j-keerthy@ti.com>
 <20131203092410.GD11828@lee--X1>
 <529DAD2B.4040909@ti.com>
 <20131203112107.GP11828@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+OC8RVH7U83T7eJX"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131203112107.GP11828@lee--X1>
Sender: linux-doc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <a0393675@ti.com>, Keerthy <j-keerthy@ti.com>, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--+OC8RVH7U83T7eJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 11:21:07AM +0000, Lee Jones wrote:

> other is that you shouldn't be doing this at all with regulators. Mark
> likes the idea of having a single regulator controller node which
> contains all of these individual regulator sub-nodes and you initiate
> a single call to for_each_child_of_node() within the driver in order
> to register them all.

That's not really the case, it depends on how the hardware is
structured.  If the regulators are not laid out in a regular fashion or
otherwise reusable then the above big bag of regulators makes sense.  If
the hardware is reusable then things are different.

--+OC8RVH7U83T7eJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSndxgAAoJELSic+t+oim9cBUP/06WWWYrjhT9fJn2COoIxdZm
bQmYBjMo0J2CIqBtpYmCc5bGWRYO+IY+R23mzOE1NQ2KxLlHqxbZavvG1B1y5D/8
ypi8z+f3zib8jNacSv1wqIgajskRT6X3WPpsxtZGIk6K2j2Q9B7bVv8HFHzVjtwC
gpFwGuC9RjsSn80PtnJ5ymE15oYj1xPIrTJHmmDsWC5HmLIayEPJ4GvAGuHO6DTy
I+inkTPpGr1dT3nqR7R1p/wgOFFnAGtV0Wv+E0XwI+NLfWcPEesFSGSE5IKPpr6c
F4iGuFiRZL27bccWz3PjRCozsceXdsE36oNyE4l4HE3zCgYuZTvTK9w2ExXTi5ZE
hUZmeWcOOkJBmKTAZc7oAXGDZHSZWFq2IETxNUjfhDyM1kWUq1p24V04aWoVtkNz
BiD1mJbPa0DTziBCtMzlp8erVnjTPJSeHmzTIrYZH6GnKkLsBbFTD/WhsqC1pMNc
CMDyFCfUAdyF3yBF2KiyyO5XEIrcN2OBn5H7Qc4Z+KMXBaHPtQtTvCu0qwK3W4hg
KuoqL6YV6/DmeXrNk2r/yLKC0H3Q7Al1wntu/rk+I1YdUPRVlrFSeQD5pUcltcaW
/DH/+TOu3I115kYlgMDIK+45zwR0K3GzhJkMdCXtqiNY3keqsgTOXMQEU6JyTUHZ
2mfX6wXcDEqAh+gkwqKR
=fI/p
-----END PGP SIGNATURE-----

--+OC8RVH7U83T7eJX--
