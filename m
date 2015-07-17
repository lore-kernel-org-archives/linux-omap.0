From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Drop two more omap3 legacy board files for v4.3
 merge window
Date: Fri, 17 Jul 2015 10:26:46 +0200
Message-ID: <20150717082645.GB9331@earth>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2342407208593729602=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437047951-22300-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2342407208593729602==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2015 at 04:59:09AM -0700, Tony Lindgren wrote:
> I think we can drop these now. This just leaves n900 and ldp with
> n900 pending patches for legacy proc support.

So I guess n900 board file removal depends on the atag procfs
support in DT. What's the problem with ldp? Its DT file seem
to cover everything in the board file. I guess both of them
will finally be removed in 4.4?

-- Sebastian

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVqLxDAAoJENju1/PIO/qaO2cP/0Hoo+MeCcW+240gn8bLCYsn
jQk2v0juXaGmpaK4+wZMBVvZ9EEOSP4FeXl7nYz/r63jls9ID9Tr+I4ISm+J/qER
hujFHpD/ZNLM3+BpClJRvcYWWaM/zroL5+wlFD8d6cytPGbxF1xcKtGbSKb35fur
h74tSJlEMzHXXVCQjAnKmFqg2ZXJfKQMUwm2vdDtstAkwiTgjA9mVc+LBSh2e5r+
v2OdLOrGJUp7EOlIkQ2Op06nWqSY9PK+Bi/sqgF+3vmrTPVYMf4puhRojEOzuiRD
oh+Ulq9GYqJDQJoNumgs88y+FikbYcWiB+j/8jIqM+3S+gobvgf5mD1qJujrnZbY
QagvbeBYStKaWqia0hG1tTDc4Yng38/+OgyK5p1GnkOuy8toGm0hBSSVWzNdUyBG
OoHeks/VTeT9AGrLCe6oaGcI8T1gI5Difpl6MzG3gk8Glu6tGpiPLdtIYkUzKZD4
+9QEUeM3cvHCOt2tZMhCEkOoCaScnUWeBSvh2dM+sc2xMV2I6GnOosMpxp0oEVBb
31KsuqbAq/yDf0OmRsUCG6ZywW/G4OQYSWMaS5VqmEfwTliGinoPZMGdx1RJLb3Z
F0s8lUYC3wA00bJvZShOXQ904NOddfSIJ8ZS87fvE/lsRrvyDw7cCvz2ytTGEjHq
EuNiCIznpffrkI/78x+6
=BElv
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--


--===============2342407208593729602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2342407208593729602==--
