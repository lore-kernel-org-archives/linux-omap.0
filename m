From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Tue, 5 Oct 2010 18:03:46 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com>
 <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
 <4CA60F88.4020303@ti.com>
 <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0680EC522D0CC943BC586913CF3768C003FF3B2E05dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43945 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0JEMdy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 08:33:54 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

--_002_0680EC522D0CC943BC586913CF3768C003FF3B2E05dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<snip>..

> >
> > Below is an untested patch to provide some mechanism to deal with this =
--
> > I'd appreciate everyone's comments on this, particularly the comments i=
n
> > the patch code on how to deal with this problem.
>=20
> Hi Paul,
>=20
> I'll test this patch to see if it solves the issue seen with i2c on n800.

Hi Paul, Benoit, Kevin,

So looks like the issue with i2c on n800 isn't really because of additional
delay needed after a clock enable, but related to the omap_readl/writel's
done on the 16bit i2c registers as I was suspecting earlier.

The below patch fixes the n800 issue for me. My mailer might mess up the al=
ignment
hence attaching it too.

>From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 5 Oct 2010 16:36:30 +0530
Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers

Some modules which have 16bit registers can cause imprecise
aborts if a __raw_readl/writel is used to read/write 32 bits.

Add an additional flag to identify modules which have such
hard requirement, and handle it in the hwmod framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   24 +++++++++++++++-------=
--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 955861a..5a30658 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -184,7 +184,7 @@ static int _update_sysc_cache(struct omap_hwmod *oh)
=20
 	/* XXX ensure module interface clock is up */
=20
-	oh->_sysc_cache =3D omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
+	oh->_sysc_cache =3D omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
=20
 	if (!(oh->class->sysc->sysc_flags & SYSC_NO_CACHE))
 		oh->_int_flags |=3D _HWMOD_SYSCONFIG_LOADED;
@@ -211,7 +211,7 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *=
oh)
=20
 	if (oh->_sysc_cache !=3D v) {
 		oh->_sysc_cache =3D v;
-		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
+		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
 	}
 }
=20
@@ -1133,12 +1133,12 @@ static int _reset(struct omap_hwmod *oh)
 	_write_sysconfig(v, oh);
=20
 	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
-		omap_test_timeout((omap_hwmod_readl(oh,
+		omap_test_timeout((omap_hwmod_read(oh,
 						    oh->class->sysc->syss_offs)
 				   & SYSS_RESETDONE_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
 	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
-		omap_test_timeout(!(omap_hwmod_readl(oh,
+		omap_test_timeout(!(omap_hwmod_read(oh,
 						     oh->class->sysc->sysc_offs)
 				   & SYSC_TYPE2_SOFTRESET_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
@@ -1378,14 +1378,20 @@ static int _setup(struct omap_hwmod *oh, void *data=
)
=20
 /* Public functions */
=20
-u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs)
+u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
 {
-	return __raw_readl(oh->_mpu_rt_va + reg_offs);
+	if (oh->flags & HWMOD_16BIT_REG)
+		return __raw_readw(oh->_mpu_rt_va + reg_offs);
+	else
+		return __raw_readl(oh->_mpu_rt_va + reg_offs);
 }
=20
-void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
+void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 {
-	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
+	if (oh->flags & HWMOD_16BIT_REG)
+		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
+	else
+		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
 }
=20
 /**
@@ -1732,7 +1738,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh)
 	 * Forces posted writes to complete on the OCP thread handling
 	 * register writes
 	 */
-	omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
+	omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
 }
=20
 /**
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index c1835af..7eaa8ed 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -370,6 +370,7 @@ struct omap_hwmod_omap4_prcm {
  *     This is needed for devices like DSS that require optional clocks en=
abled
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
+ * HWMOD_16BIT_REG: Module has 16bit registers
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -379,6 +380,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
+#define HWMOD_16BIT_REG				(1 << 8)
=20
 /*
  * omap_hwmod._int_flags definitions
@@ -527,8 +529,8 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh=
, u8 idlemode);
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
=20
-void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs);
-u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs);
+void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
+u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
=20
 int omap_hwmod_count_resources(struct omap_hwmod *oh);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)=
;
--=20
1.7.0.4



--_002_0680EC522D0CC943BC586913CF3768C003FF3B2E05dbde02enttico_
Content-Type: application/octet-stream;
	name="0001-OMAP-hwmod-Handle-modules-with-16bit-registers.patch"
Content-Description: 0001-OMAP-hwmod-Handle-modules-with-16bit-registers.patch
Content-Disposition: attachment;
	filename="0001-OMAP-hwmod-Handle-modules-with-16bit-registers.patch";
	size=4614; creation-date="Tue, 05 Oct 2010 16:40:27 GMT";
	modification-date="Tue, 05 Oct 2010 16:40:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZjk3MzNmMmU2M2ExNmI0NDY2MzVkNTIwMTVlMDVkNjMxZjA3ODhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
VHVlLCA1IE9jdCAyMDEwIDE2OjM2OjMwICswNTMwClN1YmplY3Q6IFtQQVRDSF0gT01BUDogaHdt
b2Q6IEhhbmRsZSBtb2R1bGVzIHdpdGggMTZiaXQgcmVnaXN0ZXJzCgpTb21lIG1vZHVsZXMgd2hp
Y2ggaGF2ZSAxNmJpdCByZWdpc3RlcnMgY2FuIGNhdXNlIGltcHJlY2lzZQphYm9ydHMgaWYgYSBf
X3Jhd19yZWFkbC93cml0ZWwgaXMgdXNlZCB0byByZWFkL3dyaXRlIDMyIGJpdHMuCgpBZGQgYW4g
YWRkaXRpb25hbCBmbGFnIHRvIGlkZW50aWZ5IG1vZHVsZXMgd2hpY2ggaGF2ZSBzdWNoCmhhcmQg
cmVxdWlyZW1lbnQsIGFuZCBoYW5kbGUgaXQgaW4gdGhlIGh3bW9kIGZyYW1ld29yay4KClNpZ25l
ZC1vZmYtYnk6IFJhamVuZHJhIE5heWFrIDxybmF5YWtAdGkuY29tPgotLS0KIGFyY2gvYXJtL21h
Y2gtb21hcDIvb21hcF9od21vZC5jICAgICAgICAgICAgIHwgICAyNCArKysrKysrKysrKysrKyst
LS0tLS0tLS0KIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcF9od21vZC5oIHwg
ICAgNiArKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kLmMgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2QuYwppbmRleCA5NTU4NjFhLi41YTMwNjU4IDEw
MDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2QuYworKysgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL29tYXBfaHdtb2QuYwpAQCAtMTg0LDcgKzE4NCw3IEBAIHN0YXRpYyBpbnQg
X3VwZGF0ZV9zeXNjX2NhY2hlKHN0cnVjdCBvbWFwX2h3bW9kICpvaCkKIAogCS8qIFhYWCBlbnN1
cmUgbW9kdWxlIGludGVyZmFjZSBjbG9jayBpcyB1cCAqLwogCi0Jb2gtPl9zeXNjX2NhY2hlID0g
b21hcF9od21vZF9yZWFkbChvaCwgb2gtPmNsYXNzLT5zeXNjLT5zeXNjX29mZnMpOworCW9oLT5f
c3lzY19jYWNoZSA9IG9tYXBfaHdtb2RfcmVhZChvaCwgb2gtPmNsYXNzLT5zeXNjLT5zeXNjX29m
ZnMpOwogCiAJaWYgKCEob2gtPmNsYXNzLT5zeXNjLT5zeXNjX2ZsYWdzICYgU1lTQ19OT19DQUNI
RSkpCiAJCW9oLT5faW50X2ZsYWdzIHw9IF9IV01PRF9TWVNDT05GSUdfTE9BREVEOwpAQCAtMjEx
LDcgKzIxMSw3IEBAIHN0YXRpYyB2b2lkIF93cml0ZV9zeXNjb25maWcodTMyIHYsIHN0cnVjdCBv
bWFwX2h3bW9kICpvaCkKIAogCWlmIChvaC0+X3N5c2NfY2FjaGUgIT0gdikgewogCQlvaC0+X3N5
c2NfY2FjaGUgPSB2OwotCQlvbWFwX2h3bW9kX3dyaXRlbCh2LCBvaCwgb2gtPmNsYXNzLT5zeXNj
LT5zeXNjX29mZnMpOworCQlvbWFwX2h3bW9kX3dyaXRlKHYsIG9oLCBvaC0+Y2xhc3MtPnN5c2Mt
PnN5c2Nfb2Zmcyk7CiAJfQogfQogCkBAIC0xMTMzLDEyICsxMTMzLDEyIEBAIHN0YXRpYyBpbnQg
X3Jlc2V0KHN0cnVjdCBvbWFwX2h3bW9kICpvaCkKIAlfd3JpdGVfc3lzY29uZmlnKHYsIG9oKTsK
IAogCWlmIChvaC0+Y2xhc3MtPnN5c2MtPnN5c2NfZmxhZ3MgJiBTWVNTX0hBU19SRVNFVF9TVEFU
VVMpCi0JCW9tYXBfdGVzdF90aW1lb3V0KChvbWFwX2h3bW9kX3JlYWRsKG9oLAorCQlvbWFwX3Rl
c3RfdGltZW91dCgob21hcF9od21vZF9yZWFkKG9oLAogCQkJCQkJICAgIG9oLT5jbGFzcy0+c3lz
Yy0+c3lzc19vZmZzKQogCQkJCSAgICYgU1lTU19SRVNFVERPTkVfTUFTSyksCiAJCQkJICBNQVhf
TU9EVUxFX1NPRlRSRVNFVF9XQUlULCBjKTsKIAllbHNlIGlmIChvaC0+Y2xhc3MtPnN5c2MtPnN5
c2NfZmxhZ3MgJiBTWVNDX0hBU19SRVNFVF9TVEFUVVMpCi0JCW9tYXBfdGVzdF90aW1lb3V0KCEo
b21hcF9od21vZF9yZWFkbChvaCwKKwkJb21hcF90ZXN0X3RpbWVvdXQoIShvbWFwX2h3bW9kX3Jl
YWQob2gsCiAJCQkJCQkgICAgIG9oLT5jbGFzcy0+c3lzYy0+c3lzY19vZmZzKQogCQkJCSAgICYg
U1lTQ19UWVBFMl9TT0ZUUkVTRVRfTUFTSyksCiAJCQkJICBNQVhfTU9EVUxFX1NPRlRSRVNFVF9X
QUlULCBjKTsKQEAgLTEzNzgsMTQgKzEzNzgsMjAgQEAgc3RhdGljIGludCBfc2V0dXAoc3RydWN0
IG9tYXBfaHdtb2QgKm9oLCB2b2lkICpkYXRhKQogCiAvKiBQdWJsaWMgZnVuY3Rpb25zICovCiAK
LXUzMiBvbWFwX2h3bW9kX3JlYWRsKHN0cnVjdCBvbWFwX2h3bW9kICpvaCwgdTE2IHJlZ19vZmZz
KQordTMyIG9tYXBfaHdtb2RfcmVhZChzdHJ1Y3Qgb21hcF9od21vZCAqb2gsIHUxNiByZWdfb2Zm
cykKIHsKLQlyZXR1cm4gX19yYXdfcmVhZGwob2gtPl9tcHVfcnRfdmEgKyByZWdfb2Zmcyk7CisJ
aWYgKG9oLT5mbGFncyAmIEhXTU9EXzE2QklUX1JFRykKKwkJcmV0dXJuIF9fcmF3X3JlYWR3KG9o
LT5fbXB1X3J0X3ZhICsgcmVnX29mZnMpOworCWVsc2UKKwkJcmV0dXJuIF9fcmF3X3JlYWRsKG9o
LT5fbXB1X3J0X3ZhICsgcmVnX29mZnMpOwogfQogCi12b2lkIG9tYXBfaHdtb2Rfd3JpdGVsKHUz
MiB2LCBzdHJ1Y3Qgb21hcF9od21vZCAqb2gsIHUxNiByZWdfb2ZmcykKK3ZvaWQgb21hcF9od21v
ZF93cml0ZSh1MzIgdiwgc3RydWN0IG9tYXBfaHdtb2QgKm9oLCB1MTYgcmVnX29mZnMpCiB7Ci0J
X19yYXdfd3JpdGVsKHYsIG9oLT5fbXB1X3J0X3ZhICsgcmVnX29mZnMpOworCWlmIChvaC0+Zmxh
Z3MgJiBIV01PRF8xNkJJVF9SRUcpCisJCV9fcmF3X3dyaXRldyh2LCBvaC0+X21wdV9ydF92YSAr
IHJlZ19vZmZzKTsKKwllbHNlCisJCV9fcmF3X3dyaXRlbCh2LCBvaC0+X21wdV9ydF92YSArIHJl
Z19vZmZzKTsKIH0KIAogLyoqCkBAIC0xNzMyLDcgKzE3MzgsNyBAQCB2b2lkIG9tYXBfaHdtb2Rf
b2NwX2JhcnJpZXIoc3RydWN0IG9tYXBfaHdtb2QgKm9oKQogCSAqIEZvcmNlcyBwb3N0ZWQgd3Jp
dGVzIHRvIGNvbXBsZXRlIG9uIHRoZSBPQ1AgdGhyZWFkIGhhbmRsaW5nCiAJICogcmVnaXN0ZXIg
d3JpdGVzCiAJICovCi0Jb21hcF9od21vZF9yZWFkbChvaCwgb2gtPmNsYXNzLT5zeXNjLT5zeXNj
X29mZnMpOworCW9tYXBfaHdtb2RfcmVhZChvaCwgb2gtPmNsYXNzLT5zeXNjLT5zeXNjX29mZnMp
OwogfQogCiAvKioKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQv
b21hcF9od21vZC5oIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwX2h3bW9k
LmgKaW5kZXggYzE4MzVhZi4uN2VhYThlZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFw
L2luY2x1ZGUvcGxhdC9vbWFwX2h3bW9kLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1
ZGUvcGxhdC9vbWFwX2h3bW9kLmgKQEAgLTM3MCw2ICszNzAsNyBAQCBzdHJ1Y3Qgb21hcF9od21v
ZF9vbWFwNF9wcmNtIHsKICAqICAgICBUaGlzIGlzIG5lZWRlZCBmb3IgZGV2aWNlcyBsaWtlIERT
UyB0aGF0IHJlcXVpcmUgb3B0aW9uYWwgY2xvY2tzIGVuYWJsZWQKICAqICAgICBpbiBvcmRlciB0
byBjb21wbGV0ZSB0aGUgcmVzZXQuIE9wdGlvbmFsIGNsb2NrcyB3aWxsIGJlIGRpc2FibGVkCiAg
KiAgICAgYWdhaW4gYWZ0ZXIgdGhlIHJlc2V0LgorICogSFdNT0RfMTZCSVRfUkVHOiBNb2R1bGUg
aGFzIDE2Yml0IHJlZ2lzdGVycwogICovCiAjZGVmaW5lIEhXTU9EX1NXU1VQX1NJRExFCQkJKDEg
PDwgMCkKICNkZWZpbmUgSFdNT0RfU1dTVVBfTVNUQU5EQlkJCQkoMSA8PCAxKQpAQCAtMzc5LDYg
KzM4MCw3IEBAIHN0cnVjdCBvbWFwX2h3bW9kX29tYXA0X3ByY20gewogI2RlZmluZSBIV01PRF9T
RVRfREVGQVVMVF9DTE9DS0FDVAkJKDEgPDwgNSkKICNkZWZpbmUgSFdNT0RfTk9fSURMRVNUCQkJ
CSgxIDw8IDYpCiAjZGVmaW5lIEhXTU9EX0NPTlRST0xfT1BUX0NMS1NfSU5fUkVTRVQJCSgxIDw8
IDcpCisjZGVmaW5lIEhXTU9EXzE2QklUX1JFRwkJCQkoMSA8PCA4KQogCiAvKgogICogb21hcF9o
d21vZC5faW50X2ZsYWdzIGRlZmluaXRpb25zCkBAIC01MjcsOCArNTI5LDggQEAgaW50IG9tYXBf
aHdtb2Rfc2V0X3NsYXZlX2lkbGVtb2RlKHN0cnVjdCBvbWFwX2h3bW9kICpvaCwgdTggaWRsZW1v
ZGUpOwogaW50IG9tYXBfaHdtb2RfcmVzZXQoc3RydWN0IG9tYXBfaHdtb2QgKm9oKTsKIHZvaWQg
b21hcF9od21vZF9vY3BfYmFycmllcihzdHJ1Y3Qgb21hcF9od21vZCAqb2gpOwogCi12b2lkIG9t
YXBfaHdtb2Rfd3JpdGVsKHUzMiB2LCBzdHJ1Y3Qgb21hcF9od21vZCAqb2gsIHUxNiByZWdfb2Zm
cyk7Ci11MzIgb21hcF9od21vZF9yZWFkbChzdHJ1Y3Qgb21hcF9od21vZCAqb2gsIHUxNiByZWdf
b2Zmcyk7Cit2b2lkIG9tYXBfaHdtb2Rfd3JpdGUodTMyIHYsIHN0cnVjdCBvbWFwX2h3bW9kICpv
aCwgdTE2IHJlZ19vZmZzKTsKK3UzMiBvbWFwX2h3bW9kX3JlYWQoc3RydWN0IG9tYXBfaHdtb2Qg
Km9oLCB1MTYgcmVnX29mZnMpOwogCiBpbnQgb21hcF9od21vZF9jb3VudF9yZXNvdXJjZXMoc3Ry
dWN0IG9tYXBfaHdtb2QgKm9oKTsKIGludCBvbWFwX2h3bW9kX2ZpbGxfcmVzb3VyY2VzKHN0cnVj
dCBvbWFwX2h3bW9kICpvaCwgc3RydWN0IHJlc291cmNlICpyZXMpOwotLSAKMS43LjAuNAoK

--_002_0680EC522D0CC943BC586913CF3768C003FF3B2E05dbde02enttico_--
