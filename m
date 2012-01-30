From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
Date: Mon, 30 Jan 2012 13:45:53 +0200
Message-ID: <1327923953.2487.13.camel@sauron.fi.intel.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
	 <1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
	 <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
	 <20120124090630.GR16726@n2100.arm.linux.org.uk>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VPXRbSTZdoTnnCnN1dFg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab2A3LoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 06:44:03 -0500
Received: by iacb35 with SMTP id b35so5070551iac.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 03:44:02 -0800 (PST)
In-Reply-To: <20120124090630.GR16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--=-VPXRbSTZdoTnnCnN1dFg
Content-Type: multipart/mixed; boundary="=-jl4VMd5uykRu6Anucno8"


--=-jl4VMd5uykRu6Anucno8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-01-24 at 09:06 +0000, Russell King - ARM Linux wrote:
> > However, the bug made it into the 3.3 merge window, so shouldn't this
> > bugfix be sent upstream immediately?
>=20
> David is the MTD maintainer, and Artem just helps out.  I believe Artem
> is waiting for David to finish travelling before asking David (last seen
> at Hong Kong airport) to pull these fixes.  David in turn will pass them
> onto Linus.  Plus, Linus only started adding to -rc1 yesterday, so its a
> little early to expect this to be fixed.

Hi,

here is the latest version of the fix.

http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/283d43b9ce295=
2535aa89c0195085e2a1b7e5fce

Also attached.

=46rom 283d43b9ce2952535aa89c0195085e2a1b7e5fce Mon Sep 17 00:00:00 2001
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date: Mon, 16 Jan 2012 11:07:16 +0200
Subject: [PATCH] mtd: fix MTD suspend

Commits 3fe4bae88460869a8e553397cd9057a4ee7ca341 and
079c985e7a6f4ce60f931cebfdd5ee3c3 broke MTD suspend in 2 ways:

1. When the '->suspend' method is not present, we return -EOPNOTSUPP,
but
   the callers of 'mtd_suspend()' expects 0 instead.
2. Checking of the 'mtd' parameter against NULL has been incorrectly
removed
   in 'mtd_cls_suspend()'.

This patch fixes the breakages. This has been found, analyzed, reported
and tested by Rafael J. Wysocki <rjw@sisk.pl>.

Note, this patch is not needed in the stable tree because it causes a
regression introduced during the v3.3 merge window.

Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
Tested-by: Rafael J. Wysocki <rjw@sisk.pl>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/mtd/mtdcore.c   |    2 +-
 include/linux/mtd/mtd.h |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b265188..de96865 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -119,7 +119,7 @@ static int mtd_cls_suspend(struct device *dev,
pm_message_t state)
 {
 	struct mtd_info *mtd =3D dev_get_drvdata(dev);
=20
-	return mtd_suspend(mtd);
+	return mtd ? mtd_suspend(mtd) : 0;
 }
=20
 static int mtd_cls_resume(struct device *dev)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 1a81fde..d8c7aad 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -427,9 +427,7 @@ static inline int mtd_is_locked(struct mtd_info
*mtd, loff_t ofs, uint64_t len)
=20
 static inline int mtd_suspend(struct mtd_info *mtd)
 {
-	if (!mtd->suspend)
-		return -EOPNOTSUPP;
-	return mtd->suspend(mtd);
+	return mtd->suspend ? mtd->suspend(mtd) : 0;
 }
=20
 static inline void mtd_resume(struct mtd_info *mtd)
--=20
1.7.7.6

--=20
Best Regards,
Artem Bityutskiy

--=-jl4VMd5uykRu6Anucno8
Content-Disposition: attachment; filename="0001-mtd-fix-MTD-suspend.patch"
Content-Type: text/x-patch; name="0001-mtd-fix-MTD-suspend.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyODNkNDNiOWNlMjk1MjUzNWFhODljMDE5NTA4NWUyYTFiN2U1ZmNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQXJ0ZW0gQml0eXV0c2tpeSA8YXJ0ZW0uYml0eXV0c2tpeUBs
aW51eC5pbnRlbC5jb20+DQpEYXRlOiBNb24sIDE2IEphbiAyMDEyIDExOjA3OjE2ICswMjAwDQpT
dWJqZWN0OiBbUEFUQ0hdIG10ZDogZml4IE1URCBzdXNwZW5kDQoNCkNvbW1pdHMgM2ZlNGJhZTg4
NDYwODY5YThlNTUzMzk3Y2Q5MDU3YTRlZTdjYTM0MSBhbmQNCjA3OWM5ODVlN2E2ZjRjZTYwZjkz
MWNlYmZkZDVlZTNjMyBicm9rZSBNVEQgc3VzcGVuZCBpbiAyIHdheXM6DQoNCjEuIFdoZW4gdGhl
ICctPnN1c3BlbmQnIG1ldGhvZCBpcyBub3QgcHJlc2VudCwgd2UgcmV0dXJuIC1FT1BOT1RTVVBQ
LCBidXQNCiAgIHRoZSBjYWxsZXJzIG9mICdtdGRfc3VzcGVuZCgpJyBleHBlY3RzIDAgaW5zdGVh
ZC4NCjIuIENoZWNraW5nIG9mIHRoZSAnbXRkJyBwYXJhbWV0ZXIgYWdhaW5zdCBOVUxMIGhhcyBi
ZWVuIGluY29ycmVjdGx5IHJlbW92ZWQNCiAgIGluICdtdGRfY2xzX3N1c3BlbmQoKScuDQoNClRo
aXMgcGF0Y2ggZml4ZXMgdGhlIGJyZWFrYWdlcy4gVGhpcyBoYXMgYmVlbiBmb3VuZCwgYW5hbHl6
ZWQsIHJlcG9ydGVkDQphbmQgdGVzdGVkIGJ5IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5w
bD4uDQoNCk5vdGUsIHRoaXMgcGF0Y2ggaXMgbm90IG5lZWRlZCBpbiB0aGUgc3RhYmxlIHRyZWUg
YmVjYXVzZSBpdCBjYXVzZXMgYQ0KcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGR1cmluZyB0aGUgdjMu
MyBtZXJnZSB3aW5kb3cuDQoNClJlcG9ydGVkLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHNp
c2sucGw+DQpUZXN0ZWQtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5wbD4NClRlc3Rl
ZC1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+DQpTaWduZWQt
b2ZmLWJ5OiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVsLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbXRkL210ZGNvcmUuYyAgIHwgICAgMiArLQ0KIGluY2x1ZGUvbGlu
dXgvbXRkL210ZC5oIHwgICAgNCArLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMg
Yi9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCmluZGV4IGIyNjUxODguLmRlOTY4NjUgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCisrKyBiL2RyaXZlcnMvbXRkL210ZGNvcmUuYw0K
QEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgaW50IG10ZF9jbHNfc3VzcGVuZChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkNCiB7DQogCXN0cnVjdCBtdGRfaW5mbyAqbXRk
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQotCXJldHVybiBtdGRfc3VzcGVuZChtdGQpOw0K
KwlyZXR1cm4gbXRkID8gbXRkX3N1c3BlbmQobXRkKSA6IDA7DQogfQ0KIA0KIHN0YXRpYyBpbnQg
bXRkX2Nsc19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbXRkL210ZC5oIGIvaW5jbHVkZS9saW51eC9tdGQvbXRkLmgNCmluZGV4IDFhODFmZGUu
LmQ4YzdhYWQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L210ZC9tdGQuaA0KKysrIGIvaW5j
bHVkZS9saW51eC9tdGQvbXRkLmgNCkBAIC00MjcsOSArNDI3LDcgQEAgc3RhdGljIGlubGluZSBp
bnQgbXRkX2lzX2xvY2tlZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcywgdWludDY0
X3QgbGVuKQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IG10ZF9zdXNwZW5kKHN0cnVjdCBtdGRfaW5m
byAqbXRkKQ0KIHsNCi0JaWYgKCFtdGQtPnN1c3BlbmQpDQotCQlyZXR1cm4gLUVPUE5PVFNVUFA7
DQotCXJldHVybiBtdGQtPnN1c3BlbmQobXRkKTsNCisJcmV0dXJuIG10ZC0+c3VzcGVuZCA/IG10
ZC0+c3VzcGVuZChtdGQpIDogMDsNCiB9DQogDQogc3RhdGljIGlubGluZSB2b2lkIG10ZF9yZXN1
bWUoc3RydWN0IG10ZF9pbmZvICptdGQpDQotLSANCjEuNy43LjYNCg0K


--=-jl4VMd5uykRu6Anucno8--

--=-VPXRbSTZdoTnnCnN1dFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPJoLxAAoJECmIfjd9wqK0c7kP/RSy4jHTPxZS553+x9KED40W
yEmAh7dBmHPxciPgfxzwQwUb6ZjLNiG59XGHks5U0FlIpJoejx65dtNNnobTcN65
+P/deeW2T0rfyV2XXWR9CgA7i0vIJ/m/apIvs+5nFoclfAJvhIXiESrDLGWGvP/M
Lb6VO/8rq3Jjn2sHWTJG2zQbXuHMhQNhxx1HdkYER9I7aX9Mc2+zno7Q0QAe18fw
tle3jBYA8F4IkgXxYH4H0XCYwyvKvQ4w/PReKdrCoXeCvu+b6PBfTmwr/CrjvEJ2
2cRVIS3TwnDOo77D4mv4DTTOXSEGFj3ExiuUL0PQq0HSnj3uXeqror3yphloM9/a
byWjh74rjsYCfvEc+I2FTS+Epy94H/p3V0YPqdPcRu8+l4bKe2rGwD5+3Hyp/HXk
NMADQdjAM3W/nb8GAo9NblitJAoLoMWh6V7kabdGsYFkzFxSaMlFNh7333c8jhKm
I51RzAwEO4KVfRXwD+PyzkYMtncu3PxQhnk2tDLKIA/bvvHw4zVEdZ3SAU2hJGh9
MZ9as1RhSEmGwZlc+CDIWytITc8Z6raCqTM3IE4gqp9iD6aeWlGMeWwiGljLx0i0
bkOAS91TV9ficq/bbhat6ZCgO1urArbZeFtv6mLOAYhnZ5LIweRP6/gSTT3m2xlv
SKPuOJZxK0Q/yySbJUSm
=2mdP
-----END PGP SIGNATURE-----

--=-VPXRbSTZdoTnnCnN1dFg--

