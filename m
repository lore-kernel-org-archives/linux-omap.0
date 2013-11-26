From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 12:25:12 +0000
Message-ID: <20131126122512.GD14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
 <20131126103104.GZ14725@sirena.org.uk>
 <529483A2.3080000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dqsx3Lh6rjXyciUn"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529483A2.3080000-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--dqsx3Lh6rjXyciUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 04:48:58PM +0530, Sourav Poddar wrote:
> On Tuesday 26 November 2013 04:01 PM, Mark Brown wrote:
> >On Tue, Nov 26, 2013 at 01:05:00PM +0530, Sourav Poddar wrote:
> >>In qspi controller, we need to switch to memory mapped operations.
> >>These switching depends on

> >This will need to be added to the DT binding.

> I have added a "reg-name" property. Does we need to add individual
> reg-names also?

I don't understand what you mean by "individual reg-names"?

--dqsx3Lh6rjXyciUn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJMkAAoJELSic+t+oim98dsP/jybFymsOcncl7ILBDsnyNQy
ypT3KH4sGYxMtRuVlPYra97PRDz0ZaB1RQBFSXmi8N/ZfdXZUZR/0qaRJ00zW+8K
yU/5Rc1Yp/DBAJ6mVjiOd4+qVpUrT8MV5REoKG9HhZVcTPdsMa6EK8EdZpzid1/H
MljrH+iocuaAEtFxgrntPDCi/E05IUXPdMH0jsyl7fyrKmcGd442jcRn9ytxR/Hm
4HWhwWXUUBYjMJcWLyPvW/fxQNKJELtB1upe4BpRGNCe5Hh8GaIk5DnD6HuWiJEk
7enUkFPq7Ay7qGjv33llq1xRmgOzZbScHdjR5Q1xCMprDaM5bbluAQyZpCGUnbVl
z6DKfeMheeICEvXzZch8B1f+mvlnCcy8+GL3MqLjlTitr+gf0UGUrnyiBjaNkC+K
wQGdcV6yCJRpvwbc6CQaBZsXxymhWcIgkCa8YMjH1N3V+GuY4G1rpis/cVxnQpBq
xFLX9+PNIRSIIZxeOZIR2Qt7+POUnutrynvlQ9mTeQnleQ/8nr2+UIYQYNewR0I0
oU/Yp7295fumkDNzvzVDLEcYw/9hCoeaqx460yGDN3L8ZZSGI4r3kmIjQ8hlpdEO
4AflqcgJq+yl103EqHT97jOweXmDVYlHNbDm8LAcmNQ0prl9NUn4vXO4oVemnXUS
g+ZT6KauH1LhvTZDVCeW
=xqrf
-----END PGP SIGNATURE-----

--dqsx3Lh6rjXyciUn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
