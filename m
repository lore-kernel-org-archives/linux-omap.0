From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Wed, 25 Feb 2015 11:32:18 +0200
Message-ID: <54ED96A2.6080300@ti.com>
References: <20150224203706.1eafa129@notabene.brown>	<54EC5520.1020105@ti.com>	<20150225073131.7fbff605@notabene.brown>	<54ED8CB6.4010308@ti.com> <20150225202042.2adaea4f@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uUOeSx5lXhOC7aPLBOdUfUhD8FUtHRjQS"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225202042.2adaea4f@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--uUOeSx5lXhOC7aPLBOdUfUhD8FUtHRjQS
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/02/15 11:20, NeilBrown wrote:

> Tested-by: NeilBrown <neilb@suse.de>
>=20
> Before the patch:
>=20
> # ls -l /sys/devices/platform/omapdss/display0=20
> lrwxrwxrwx 1 root root 0 Feb  8 12:57 /sys/devices/platform/omapdss/dis=
play0 -> ../spi_lcd/spi_master/spi32766/spi32766.0
>=20
> After the patch:
>=20
> # ls -l /sys/devices/platform/omapdss/display0=20
> total 0
> -r--r--r-- 1 root root 4096 Feb  8 13:37 display_name
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 enabled
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 mirror
> -r--r--r-- 1 root root 4096 Feb  8 13:37 name
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 rotate
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 tear_elim
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 timings
> -rw-r--r-- 1 root root 4096 Feb  8 13:37 wss
>=20
>=20
> So as you say it creates a directory just for the display0 device, and =
that
> has the 'name' that we want.

I think this was something similar than how the sysfs files were set up
originally for omapdss. If I remember right, we didn't have proper
devices for the displays then. Things have evolved quite a bit since then=
=2E

There's a small chance of this patch breaking things, of course... If
someone accessed those display sysfs files via the display device
(../spi_lcd/spi_master/spi32766/spi32766.0), the files are now gone.

But I think (hope...) they are always accessed via the omapdss's
displayX directories.

> This works for me, and it seems to me to be a better fit to the general=

> structure of /sys/devices - symlinks within /sys/devices are a substant=
ial
> minority, other than 'subsystem', 'device', 'driver' and 'bdi' which ha=
ve
> very generic meanings.
>=20
> I guess I'm a little surprised that there doesn't seem to be any linkag=
e from
> the display0 to the spi device.  Maybe that isn't important.

Yep, I don't think so. In any case, all this is to be deprecated, and as
soon as omapdrm driver works reliably that should be the driver to use.

So of course we need to keep omapfb working for the years to come, but
I'd rather not add any new sysfs files for a soon deprecated driver.

 Tomi



--uUOeSx5lXhOC7aPLBOdUfUhD8FUtHRjQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7ZaiAAoJEPo9qoy8lh71PhQP/iIhMQudjwBGHDenF8MzWf9D
Gst1IJCKnRploS5G4vq356TbQLeqRRVuCGGI052KMseNGc2M71v3KNPrnwoCXqNH
yzcsFk2dxaItuBfIBsrmtr3YdaE162j4b6j2z2TzGpK7Pf8kX+sLc6YhbNh02nI9
fUu9mtE1gb/9sqG8ufG4eUBLhaPoHN2Jg2TTNQSK7mqnn8psuwb6A90rp838PCJq
Ua+Jus83IEIKth5HfydULu3QWWq89kSUGzjxfWu8pJA9YOfv7Gth8VFjPdOq5ZMs
zgmYFNbJl1aYjNVpN3zU+9k1ZG8/dBgwEdRLsqU9pFZCHJ2YX5EKzCAtstJEPkB+
MNW8VMIduNJdAPTZwTTte5nIO0t4+Z4jkIjHFSkhwT4GPaQzivHHljlENNWLqnnz
Q4wBVJ144FkDzG7OOrm4dYQT3Df4ZKa540JaQaS+Y8JvdkMssXQQTa7jyFo7uzlt
m5C7lubAx1LRAo7RrQC31bHfUoVh3itCmOopJYsS4ZcE1e1BF9xhYIQOa5YQwFh5
jngBr75a1eW6ywgX32d4o0Dmg4VkSBQlCJhvicbrko72u8YGW4craYOWcYr0g/+1
6onywjQxdC9eW8JAjZ378scpJ3BTCuaK6QSKP/M2dYaWYprAiGV/RxdA7iHYT7uq
w6Rj+20RqI2AwWjzyDfL
=PzDB
-----END PGP SIGNATURE-----

--uUOeSx5lXhOC7aPLBOdUfUhD8FUtHRjQS--
