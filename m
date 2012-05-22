From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: RE: [PATCH 0/3] GPMC NAND isr using standard API
Date: Tue, 22 May 2012 09:14:43 +0300
Message-ID: <1337667283.2483.83.camel@sauron.fi.intel.com>
References: <cover.1337090835.git.afzal@ti.com>
	 <20120519125018.GA2407@parrot.com>
	 <C8443D0743D26F4388EA172BF4E2A7A93E98EE28@DBDE01.ent.ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pW/VzLfNYOozwNUZzQfw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3542 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab2EVGLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 02:11:07 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98EE28@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Ivan Djelic <ivan.djelic@parrot.com>, "tony@atomide.com" <tony@atomide.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


--=-pW/VzLfNYOozwNUZzQfw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-22 at 04:26 +0000, Mohammed, Afzal wrote:
> Tony, Artem, how should the conflict between omap & mtd trees be handled
> for patch series ?

You merge the 2 trees and work on top of that? Or you wait for 3.5-r1
when everything is merged and work on top of that?

--=20
Best Regards,
Artem Bityutskiy

--=-pW/VzLfNYOozwNUZzQfw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPuy7TAAoJECmIfjd9wqK01UUQAMVTM6FBRL4Feh1gnqlWMaLF
0My9stnGjTTygBKkVmzuO3y5y7utystNQiJ5kArx6z7UrJEcqJUy7FbBTBytZbbw
dRZkDoWKUv/2ye2bj7UNA/Na2sqjKHzXC+0wsgus5uDidG9cK0G0yz7o9bHxzgA6
LS5U9Bk2oDc7IWK0EUL/+8AsYESjYqRJr29PHkRUpntcDk0nOFffDvxJj8DAIkZ9
+ZWIB34k7SasjFV2bbfWJl1LolsDpuHulBEZd8tsfrzIsHUaXtsuBXFExYkTG3R4
2BSkk8Gd2snmfLlj09rhpm4tO0zt5Sf79zrCSpeAxbW5TQyapF9zO4FDCq2UB8eP
J99ciuEAsd4cNrASR2WqB7xOeZvyHgQxG9znA9lWiSH4ayWe9LY7hhA3Rl+8rOkl
pP7OV+iAIcBDyjhxdXRUtH1bVxILuckciHqumf2zCSjVzCXnur3fkJRnYfTBBEzD
XiwQO+pMP0f6VPK2Y+zGyHz7dSGslqp+u56PSpo+kZFy6erMfmjY/CcHeITZWDNG
eQHnLq3lrYUHEkV96WHGd9EUGGPDU+I34kch5uzCAzjNaSi670F5doz7MZFsB1ej
H5OyXHjJ8kc3nUyqLB8xlzUUUqarkZoqX7NUvHjicZwN4FujnEwkipkzowWO4fgr
dpk8/6Y98yn04wBYnHU7
=sr3i
-----END PGP SIGNATURE-----

--=-pW/VzLfNYOozwNUZzQfw--

