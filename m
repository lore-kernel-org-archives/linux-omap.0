From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 6 Oct 2010 01:56:50 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2F4D@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com>	<877hi3gqq7.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
	<4CA60F88.4020303@ti.com>
	<alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
	<874od0tvu3.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2F3D@dbde02.ent.ti.com>
 <87y6acpghs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0680EC522D0CC943BC586913CF3768C003FF3B2F4Ddbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757126Ab0JEU1E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 16:27:04 -0400
In-Reply-To: <87y6acpghs.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

--_002_0680EC522D0CC943BC586913CF3768C003FF3B2F4Ddbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, October 06, 2010 1:19 AM
> To: Nayak, Rajendra
> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.kernel=
.org; Varadarajan, Charulatha; Raja,
> Govindraj
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watch=
dog, UART, i2c
>=20
> "Nayak, Rajendra" <rnayak@ti.com> writes:
>=20
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Tuesday, October 05, 2010 10:34 PM
> >> To: Nayak, Rajendra
> >> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.ker=
nel.org; Varadarajan, Charulatha; Raja,
> >> Govindraj
> >> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: wa=
tchdog, UART, i2c
> >>
> >> "Nayak, Rajendra" <rnayak@ti.com> writes:
> >>
> >> > <snip>..
> >> >
> >> >> >
> >> >> > Below is an untested patch to provide some mechanism to deal with=
 this --
> >> >> > I'd appreciate everyone's comments on this, particularly the comm=
ents in
> >> >> > the patch code on how to deal with this problem.
> >> >>
> >> >> Hi Paul,
> >> >>
> >> >> I'll test this patch to see if it solves the issue seen with i2c on=
 n800.
> >> >
> >> > Hi Paul, Benoit, Kevin,
> >> >
> >> > So looks like the issue with i2c on n800 isn't really because of add=
itional
> >> > delay needed after a clock enable, but related to the omap_readl/wri=
tel's
> >> > done on the 16bit i2c registers as I was suspecting earlier.
> >> >
> >> > The below patch fixes the n800 issue for me. My mailer might mess up=
 the alignment
> >> > hence attaching it too.
> >> >
> >> > From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 20=
01
> >> > From: Rajendra Nayak <rnayak@ti.com>
> >> > Date: Tue, 5 Oct 2010 16:36:30 +0530
> >> > Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
> >> >
> >> > Some modules which have 16bit registers can cause imprecise
> >> > aborts if a __raw_readl/writel is used to read/write 32 bits.
> >> >
> >> > Add an additional flag to identify modules which have such
> >> > hard requirement, and handle it in the hwmod framework.
> >> >
> >> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >>
> >> Can you also send a corresponding patch to the i2c hwmod data.
> > Hi Kevin,
> >
> > Ok, I'll repost the original patch which adds the omap2 hwmod data with
> > these flags added for omap2420. Does that sound fine?
>=20
> Since I've alrady done some manual merge conflicts here, you can just
> post an additional patch and I will fold it in.

Ok, so here's the patch
------
>From 06b4bb7a0ce96776d6d9b344b4786b48fceeffe1 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Wed, 6 Oct 2010 01:49:32 +0530
Subject: [PATCH] OMAP2: hmwod: Fix impresice aborts seen on n800/n810

I2C module on OMAP2420 has 16bit registers and causes imprecise
aborts if 32bits are read/wriitten into.
Use the HWMOD_16BIT_REG flag to notify the hmwod framework of this
hard requirement so that __raw_writew/readw is used to read /write
the mdoule registers.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index 25d6da2..c588854 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -263,6 +263,7 @@ static struct omap_hwmod omap2420_i2c1_hwmod =3D {
 	.class		=3D &i2c_class,
 	.dev_attr	=3D &i2c_dev_attr,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		=3D HWMOD_16BIT_REG,
 };
=20
 /* I2C2 */
@@ -301,6 +302,7 @@ static struct omap_hwmod omap2420_i2c2_hwmod =3D {
 	.class		=3D &i2c_class,
 	.dev_attr	=3D &i2c_dev_attr,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+	.flags		=3D HWMOD_16BIT_REG,
 };
=20
 static __initdata struct omap_hwmod *omap2420_hwmods[] =3D {
--=20
1.7.0.4

>=20
> Thanks,
>=20
> Kevin

--_002_0680EC522D0CC943BC586913CF3768C003FF3B2F4Ddbde02enttico_
Content-Type: application/octet-stream;
	name="0001-OMAP2-hmwod-Fix-impresice-aborts-seen-on-n800-n810.patch"
Content-Description: 0001-OMAP2-hmwod-Fix-impresice-aborts-seen-on-n800-n810.patch
Content-Disposition: attachment;
	filename="0001-OMAP2-hmwod-Fix-impresice-aborts-seen-on-n800-n810.patch";
	size=1359; creation-date="Wed, 06 Oct 2010 01:53:31 GMT";
	modification-date="Wed, 06 Oct 2010 01:53:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNmI0YmI3YTBjZTk2Nzc2ZDZkOWIzNDRiNDc4NmI0OGZjZWVmZmUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
V2VkLCA2IE9jdCAyMDEwIDAxOjQ5OjMyICswNTMwClN1YmplY3Q6IFtQQVRDSF0gT01BUDI6IGht
d29kOiBGaXggaW1wcmVzaWNlIGFib3J0cyBzZWVuIG9uIG44MDAvbjgxMAoKSTJDIG1vZHVsZSBv
biBPTUFQMjQyMCBoYXMgMTZiaXQgcmVnaXN0ZXJzIGFuZCBjYXVzZXMgaW1wcmVjaXNlCmFib3J0
cyBpZiAzMmJpdHMgYXJlIHJlYWQvd3JpaXR0ZW4gaW50by4KVXNlIHRoZSBIV01PRF8xNkJJVF9S
RUcgZmxhZyB0byBub3RpZnkgdGhlIGhtd29kIGZyYW1ld29yayBvZiB0aGlzCmhhcmQgcmVxdWly
ZW1lbnQgc28gdGhhdCBfX3Jhd193cml0ZXcvcmVhZHcgaXMgdXNlZCB0byByZWFkIC93cml0ZQp0
aGUgbWRvdWxlIHJlZ2lzdGVycy4KClNpZ25lZC1vZmYtYnk6IFJhamVuZHJhIE5heWFrIDxybmF5
YWtAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF8yNDIwX2RhdGEu
YyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF8yNDIwX2Rh
dGEuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF8yNDIwX2RhdGEuYwppbmRleCAy
NWQ2ZGEyLi5jNTg4ODU0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdt
b2RfMjQyMF9kYXRhLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzI0MjBf
ZGF0YS5jCkBAIC0yNjMsNiArMjYzLDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAy
NDIwX2kyYzFfaHdtb2QgPSB7CiAJLmNsYXNzCQk9ICZpMmNfY2xhc3MsCiAJLmRldl9hdHRyCT0g
JmkyY19kZXZfYXR0ciwKIAkub21hcF9jaGlwCT0gT01BUF9DSElQX0lOSVQoQ0hJUF9JU19PTUFQ
MjQyMCksCisJLmZsYWdzCQk9IEhXTU9EXzE2QklUX1JFRywKIH07CiAKIC8qIEkyQzIgKi8KQEAg
LTMwMSw2ICszMDIsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MjBfaTJjMl9o
d21vZCA9IHsKIAkuY2xhc3MJCT0gJmkyY19jbGFzcywKIAkuZGV2X2F0dHIJPSAmaTJjX2Rldl9h
dHRyLAogCS5vbWFwX2NoaXAJPSBPTUFQX0NISVBfSU5JVChDSElQX0lTX09NQVAyNDIwKSwKKwku
ZmxhZ3MJCT0gSFdNT0RfMTZCSVRfUkVHLAogfTsKIAogc3RhdGljIF9faW5pdGRhdGEgc3RydWN0
IG9tYXBfaHdtb2QgKm9tYXAyNDIwX2h3bW9kc1tdID0gewotLSAKMS43LjAuNAoK

--_002_0680EC522D0CC943BC586913CF3768C003FF3B2F4Ddbde02enttico_--
