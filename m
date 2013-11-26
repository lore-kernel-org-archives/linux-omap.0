From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Tue, 26 Nov 2013 10:30:29 +0000
Message-ID: <20131126103029.GY14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIZeFZfK2rom9VmH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59645 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab3KZKaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 05:30:55 -0500
Content-Disposition: inline
In-Reply-To: <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com


--oIZeFZfK2rom9VmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:04:59PM +0530, Sourav Poddar wrote:
> Modify the qspi driver to parse reg information by name.

This presumably needs an update to the device tree bindings so that
there's a name defined?

--oIZeFZfK2rom9VmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlHhBAAoJELSic+t+oim9Mz4P/3N0XCBKRpJme13yeLRDAonY
fOZOfhM08o2NPC7soiA+Whx1WGeeICfRpxuhm6vxuxDImOCB1E64P3Mx+zwFdajM
TILNQGcqIt4rulgoph/P6qG1SoU9wlUlHtff1GLBAnkB4UwIQe+oqI77onoPwtLq
zjMYWRmyuQCAKb/tLqsimTmtohiW27UxUB4Et180tcWIJW+OtqaKoKf7TFH/Tbh3
o3wOqnn+sDoTQT4sCmrTJvd8YeODeb/HeQl4EYNBqRSBh/Yu07vrxAp7yqqnBdlg
hTYpaqXzL/iaYRXh6oXaWph+5Dlrf4MC89rU5lAJbMOnCZpRNbqtyFEZVbYuDPCW
80DjLh7vjcEggklEuo3gqXBg2unC+dOfquniGVtxt0JAhb9bjddaR1nE9amVzg7B
3TXuiASiyD3Nlbx5gYe64ngJg5Zo8/5N0HzUnve5WmXHWuR+BCEVSpjRAbzeV2jG
7OSsLbXBJoQcDZ9YxGGzVx7UOnZtSub8nbO5pIs+zHOzEZx5pH8lC4J3X7pM861F
yl1EwLGgN0NehPIgYQx7BDWzivElzOZ8O39L5ONDkgXbJV2/0i2OKXXKk0I16mdP
dP2NaLq78sBo9zV1zv8O8omUoXkBymvpWiUu2SjG1OxlRfBvS+nSxnt0SY3rhvxB
TeKTAbY6opyKDN4RCy8h
=kpaE
-----END PGP SIGNATURE-----

--oIZeFZfK2rom9VmH--
