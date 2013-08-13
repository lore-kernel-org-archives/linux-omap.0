From: Sebastian Reichel <sre@debian.org>
Subject: Re: Pandaboard: DT Boot fails when initramfs is loaded
Date: Tue, 13 Aug 2013 12:32:35 +0200
Message-ID: <20130813103232.GA2979@earth.universe>
References: <20130811133119.GA15024@earth.universe>
 <5208D243.6080309@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:52868 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756294Ab3HMKcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 06:32:39 -0400
Content-Disposition: inline
In-Reply-To: <5208D243.6080309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2013 at 03:17:07PM +0300, Roger Quadros wrote:
> What is the size of your uImage and uInitrd? Are you sure the load addresses
> are far apart to not cause overwrite?

There should be about 23M space for the uImage (0x81600000-0x80000000) and
ca. 245MB for the uInitrd (0x90000000 - 0x81600000). The actual files
are much smaller than that:

-rw-r--r-- 1 root root 2.7M Mai 25 17:59 uImage-3.10.0-rc1+
-rw-r--r-- 1 root root 4.9M Mai 25 18:00 uInitrd-3.10.0-rc1+
-rw-r--r-- 1 root root 2.8M Aug 11 13:27 uImage-3.11.0-rc4+
-rw-r--r-- 1 root root 4.9M Aug 11 13:27 uInitrd-3.11.0-rc4+
-rw-r--r-- 1 root root  18K Aug 11 13:01 omap4-panda.dtb

Apart from that I was able to boot the 3.10 kernel without using the
device tree information.

-- Sebastian

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSCgtAAAoJENju1/PIO/qab94P/0nMQeiV+GhnmX+CW35vjh2m
AgxEJsKin6DWZoXmrSQLeQO8Fu6lre9viP4MOlP7dpvjGW7zM3XXoJMYkswj+lzD
OCNNoNt8WRHD7/VsuhTijXMbWdMxnUxT6EqFNJM9BYJ1sWjzuxCW2tqFl7w0jSQu
57y5gQhVZGnLq74LBXLFwBr9mvUHpcDJneOerwHfZLBtRwOWWyU5OZ8AaJ+6mMEz
+ibiBVBUIR1hBWHH0owgEwFXoqVx99l0KMBG68lFUZbqwtPetL17rpxUgDAKitMo
SnjDOOXSlmQx7Cq9GBjDJiYog8An25EVtJrCxW2+M7BwgMfWGcVWibs2IqyMkFc0
pghcNkUUbLXiaWyxhRaQYdOf6Lv7hc1YlSfBC+K1FDQS3mYPTSy6iLbE61S06yID
zcbwQETHsQMmVLL1YhYcaJIzqe1FaosOP5sfuaUTFDyn9qH4TVgkEAieJ59KaqY4
D59wBDXoPllgSo2Viz1KqyetqjUagLod3dOOopg4yYT21xNuERwSi9WTZNcV49eY
2BnF6qgJ2n1IGELM0oQcgi3KE7oKDDbsbt4WgWQPX6RfWcj0W+9sCYX4FwBzH/iH
5/IDl5oN0cKWrrWjlX8zcUgVM6FFm1o5LdXHzfzt868thHtW9t2a+3r4/HXzQTBI
68V5Ip8EzYU/kjCuW5+F
=Agt3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
