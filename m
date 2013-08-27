From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: trinity: kernel warning at drivers/video/omap2/dss/manager-sysfs.c:290
 manager_alpha_blending_enabled_show+0x3c/0x60()
Date: Tue, 27 Aug 2013 14:37:14 +0300
Message-ID: <521C8F6A.5020804@ti.com>
References: <20130821223340.GE25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="iDwR79E6t5gk5NwlqeTOJO3sV5MTnUBmQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48461 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab3H0Lht (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 07:37:49 -0400
In-Reply-To: <20130821223340.GE25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--iDwR79E6t5gk5NwlqeTOJO3sV5MTnUBmQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/08/13 01:33, Russell King - ARM Linux wrote:
> Trinity found this error on OMAP4430SDP using 3.11-rc4:
>=20
> WARNING: CPU: 1 PID: 3395 at /home/rmk/git/linux-rmk/drivers/video/omap=
2/dss/manager-sysfs.c:290 manager_alpha_blending_enabled_show+0x3c/0x60()=

> Modules linked in:
> CPU: 1 PID: 3395 Comm: trinity-child1 Not tainted 3.11.0-rc4+ #487
> Backtrace:
> [<c0016ca8>] (dump_backtrace+0x0/0x110) from [<c0016e44>] (show_stack+0=
x18/0x1c)
>  r6:c03dc0d4 r5:00000009 r4:00000000 r3:00400040
> [<c0016e2c>] (show_stack+0x0/0x1c) from [<c03949ec>] (dump_stack+0x74/0=
x90)
> [<c0394978>] (dump_stack+0x0/0x90) from [<c0037a68>] (warn_slowpath_com=
mon+0x6c/0x8c)
>  r4:00000000 r3:deaef800
> [<c00379fc>] (warn_slowpath_common+0x0/0x8c) from [<c0037aac>] (warn_sl=
owpath_null+0x24/0x2c)
>  r8:dd4eb718 r7:c03dc2a0 r6:dd629f70 r5:dd4eb700 r4:dd4af000
> [<c0037a88>] (warn_slowpath_null+0x0/0x2c) from [<c01e4744>] (manager_a=
lpha_blending_enabled_show+0x3c/0x60)
> [<c01e4708>] (manager_alpha_blending_enabled_show+0x0/0x60) from [<c01e=
41c0>] (manager_attr_show+0x20/0x2c)
>  r4:de090cd0
> [<c01e41a0>] (manager_attr_show+0x0/0x2c) from [<c0126ee4>] (sysfs_read=
_file+0xc4/0x14c)
> [<c0126e20>] (sysfs_read_file+0x0/0x14c) from [<c00cef2c>] (do_readv_wr=
itev+0x118/0x24c)
> [<c00cee14>] (do_readv_writev+0x0/0x24c) from [<c00cf140>] (vfs_readv+0=
x68/0x78)
> [<c00cf0d8>] (vfs_readv+0x0/0x78) from [<c00cf19c>] (SyS_readv+0x4c/0x7=
4)
>  r5:00000000 r4:dd5b7700
> [<c00cf150>] (SyS_readv+0x0/0x74) from [<c0013340>] (ret_fast_syscall+0=
x0/0x48)
>=20
> Looking at the code:
>=20
> static ssize_t manager_alpha_blending_enabled_show(
>                 struct omap_overlay_manager *mgr, char *buf)
> {
>         struct omap_overlay_manager_info info;
>=20
>         mgr->get_manager_info(mgr, &info);
>=20
>         WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
>=20
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager0/alpha_blending_enable=
d
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager1/alpha_blending_enable=
d
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager2/alpha_blending_enable=
d
>=20
> So, any program in userspace can open this sysfs file and on read cause=

> the kernel to print a warning and taint itself if there is no ZORDER
> feature?  This is not good kernel programming guys.  Please audit your
> other sysfs files for this bug, thanks.

Well that's ugly. Thanks for reporting. The store part of
alpha_blending_enabled had similar issue, but I didn't find such things
elsewhere in the driver.

I made a fix, below.

 Tomi

Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Tue Aug 27 14:28:03 2013 +0300

    OMAPDSS: fix WARN_ON in 'alpha_blending_enabled' sysfs file
   =20
    The code handling 'alpha_blending_enabled' sysfs file contains WARN_O=
Ns
    in case the feature is not supported on the current platform. Even
    though only root can write to the file, anyone can read it, thus caus=
ing
    the kernel to get tainted and printing an ugly warning.
   =20
    Instead of having WARN_ONs, return a proper error if the feature is n=
ot
    supported.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
    Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>

diff --git a/drivers/video/omap2/dss/manager-sysfs.c b/drivers/video/omap=
2/dss/manager-sysfs.c
index de7e7b5..37b59fe 100644
--- a/drivers/video/omap2/dss/manager-sysfs.c
+++ b/drivers/video/omap2/dss/manager-sysfs.c
@@ -285,9 +285,10 @@ static ssize_t manager_alpha_blending_enabled_show(
 {
 	struct omap_overlay_manager_info info;
=20
-	mgr->get_manager_info(mgr, &info);
+	if(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
+		return -ENODEV;
=20
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+	mgr->get_manager_info(mgr, &info);
=20
 	return snprintf(buf, PAGE_SIZE, "%d\n",
 		info.partial_alpha_enabled);
@@ -301,7 +302,8 @@ static ssize_t manager_alpha_blending_enabled_store(
 	bool enable;
 	int r;
=20
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+	if(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
+		return -ENODEV;
=20
 	r =3D strtobool(buf, &enable);
 	if (r)



--iDwR79E6t5gk5NwlqeTOJO3sV5MTnUBmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHI9qAAoJEPo9qoy8lh71YQsP/AitslpqcsvSACZcym6UYuKI
3StETY1T9eB7wD8WJEELhT06j2BLPf5nCGIsvDjcAZBAcH9fWar6fvugNgU1NCkg
0EKJMbYu3ncuHQ6PUqNAeha1ituZ6ORh613q+yrvyx//t+pvYgIRQ82PujUvlP8Q
2UjV2WGU3G/gL3+5ggvmVYh2BidPzAtVhGXniSqL2lgcpDgwXQBICp4jYfnsNd03
o/ENTZ07hUHNUX1bp6vc3BaciiGiddk4+JxNq39kTPuqbLfzueel0bSxe7WUA523
SXKdDRGFPfxDlyUxipw5byuZNLUGaLfe9j0sTLSwmw2C85yWg4XuuUXOBlYHdhDD
ZjwbudK16QjBvrWPjdVhvcS8WKoJpH2husRZRuCIR/defpUlx1AsQZAQ7wR+MI/o
bpG7Z1mZHATpyTWwSyjtOtXsk8JryDbsgIDk7ep/o9Ovp7vMnFCmpWrrqdI7Y4dn
gGH5JzTzXH5bKOoXW6s5poG8a/PVG1ojLj8rJjzKMiuysk4mI/hhVqjvXttuLnXh
f3t8nejPJGIFkEWCtfENH6F7TvR1er/6JPvCbNDLbhbFbIUWsTqRZXe5TJDj84/9
YF67o1gKkDF1AX4hL0ayyXYx+Vc8KlTHpNwixmPU4nec1+gV6Cx4exP2YQbHFHvL
K3EJ7mb4DloGNtfXgZDW
=I7Qm
-----END PGP SIGNATURE-----

--iDwR79E6t5gk5NwlqeTOJO3sV5MTnUBmQ--
