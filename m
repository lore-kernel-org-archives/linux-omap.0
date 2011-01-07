From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
 undefined reference to 'omap2_prm_read_mod_reg'
Date: Fri, 7 Jan 2011 16:44:05 +0530
Message-ID: <e194160102cb8b695465c81eea6582fc@mail.gmail.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
 <1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c598db7c3e2704993fb7a1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53927 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449Ab1AGLOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 06:14:08 -0500
Received: by mail-fx0-f47.google.com with SMTP id 17so16113054fxm.20
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 03:14:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

--001636c598db7c3e2704993fb7a1
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, January 06, 2011 11:28 PM
Kevin,
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
> for undefined reference to 'omap2_prm_read_mod_reg'
>
> Hi Santosh
>
[.....]

>
> I think it would be best to use WARN() on these, rather than
> WARN_ONCE().
> That's because these could be called from different parts of the
> code
> base, and the stack backtrace will help someone figure out all the
> code
> that needs to be fixed.
>
> Once you do that, this patch is
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
>
With WARN() instead of WARN_ONCE() and Paul's ack, here
is an updated patch.


>From 3ccbab8517133c25ed2e470f9622639c98dcbd71 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 4 Jan 2011 20:40:27 +0530
Subject: [PATCH 2/5 v3] omap2plus: prm: Trvial build break fix for
undefined reference to 'omap2_prm_read_mod_reg'

omap2plus_defocnfig build breaks when customised with only ARCH_OMAP4
selected. This is because common files make references to the functions
which are defined only for omap2xxx and omap3xxx.

 LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
arch/arm/mach-omap2/pm-debug.c:335: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
arch/arm/mach-omap2/pm-debug.c:121: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:123: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:124: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:125: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
arch/arm/mach-omap2/prcm.c:106: undefined reference to
`omap2_prm_set_mod_reg_bits'
arch/arm/mach-omap2/prcm.c:108: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_get_reset_sources':
arch/arm/mach-omap2/prcm.c:53: undefined reference to
`omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `clkdm_clear_all_wkdeps':
arch/arm/mach-omap2/clockdomain.c:545: undefined reference to
`omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
arch/arm/mach-omap2/clockdomain.c:475: undefined reference to
`omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
arch/arm/mach-omap2/clockdomain.c:511: undefined reference to
`omap2_prm_read_mod_bits_shift'
arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
arch/arm/mach-omap2/clockdomain.c:440: undefined reference to
`omap2_prm_set_mod_reg_bits'
make: *** [.tmp_vmlinux1] Error 1

This patch adds stubs for these functions so that build continues to work.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   63
+++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h
b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 53d44f6..49654c8 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -228,7 +228,67 @@


 #ifndef __ASSEMBLER__
-
+/*
+ * Stub omap2xxx/omap3xxx functions so that common files
+ * continue to build when custom builds are used
+ */
+#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
+					defined(CONFIG_ARCH_OMAP3))
+static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+}
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
+		s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16
idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16
idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32
mask)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+#else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
 extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
@@ -242,6 +302,7 @@ extern int omap2_prm_is_hardreset_asserted(s16
prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);

+#endif	/* CONFIG_ARCH_OMAP4 */
 #endif

 /*
-- 
1.6.0.4

--001636c598db7c3e2704993fb7a1
Content-Type: application/octet-stream;
	name="0002-omap2plus-prm-Trvial-build-break-fix-for-undefined.patch"
Content-Disposition: attachment;
	filename="0002-omap2plus-prm-Trvial-build-break-fix-for-undefined.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 91b43f1d0fa5adf8_0.1

RnJvbSAzY2NiYWI4NTE3MTMzYzI1ZWQyZTQ3MGY5NjIyNjM5Yzk4ZGNiZDcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUdWUsIDQgSmFuIDIwMTEgMjA6NDA6MjcgKzA1MzAKU3ViamVjdDogW1BB
VENIIDIvNSB2M10gb21hcDJwbHVzOiBwcm06IFRydmlhbCBidWlsZCBicmVhayBmaXggZm9yIHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gJ29tYXAyX3BybV9yZWFkX21vZF9yZWcnCgpvbWFwMnBsdXNf
ZGVmb2NuZmlnIGJ1aWxkIGJyZWFrcyB3aGVuIGN1c3RvbWlzZWQgd2l0aCBvbmx5IEFSQ0hfT01B
UDQKc2VsZWN0ZWQuIFRoaXMgaXMgYmVjYXVzZSBjb21tb24gZmlsZXMgbWFrZSByZWZlcmVuY2Vz
IHRvIHRoZSBmdW5jdGlvbnMKd2hpY2ggYXJlIGRlZmluZWQgb25seSBmb3Igb21hcDJ4eHggYW5k
IG9tYXAzeHh4LgoKIExEICAgICAgLnRtcF92bWxpbnV4MQphcmNoL2FybS9tYWNoLW9tYXAyL2J1
aWx0LWluLm86IEluIGZ1bmN0aW9uIGBwbV9kYmdfcmVnc2V0X3N0b3JlJzoKYXJjaC9hcm0vbWFj
aC1vbWFwMi9wbS1kZWJ1Zy5jOjMzNTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgb21hcDJfcHJt
X3JlYWRfbW9kX3JlZycKYXJjaC9hcm0vbWFjaC1vbWFwMi9idWlsdC1pbi5vOiBJbiBmdW5jdGlv
biBgb21hcDJfcG1fZHVtcCc6CmFyY2gvYXJtL21hY2gtb21hcDIvcG0tZGVidWcuYzoxMjE6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYG9tYXAyX3BybV9yZWFkX21vZF9yZWcnCmFyY2gvYXJtL21h
Y2gtb21hcDIvcG0tZGVidWcuYzoxMjM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYG9tYXAyX3By
bV9yZWFkX21vZF9yZWcnCmFyY2gvYXJtL21hY2gtb21hcDIvcG0tZGVidWcuYzoxMjQ6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYG9tYXAyX3BybV9yZWFkX21vZF9yZWcnCmFyY2gvYXJtL21hY2gt
b21hcDIvcG0tZGVidWcuYzoxMjU6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYG9tYXAyX3BybV9y
ZWFkX21vZF9yZWcnCmFyY2gvYXJtL21hY2gtb21hcDIvYnVpbHQtaW4ubzogSW4gZnVuY3Rpb24g
YG9tYXBfcHJjbV9hcmNoX3Jlc2V0JzoKYXJjaC9hcm0vbWFjaC1vbWFwMi9wcmNtLmM6MTA2OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBvbWFwMl9wcm1fc2V0X21vZF9yZWdfYml0cycKYXJjaC9h
cm0vbWFjaC1vbWFwMi9wcmNtLmM6MTA4OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBvbWFwMl9w
cm1fcmVhZF9tb2RfcmVnJwphcmNoL2FybS9tYWNoLW9tYXAyL2J1aWx0LWluLm86IEluIGZ1bmN0
aW9uIGBvbWFwX3ByY21fZ2V0X3Jlc2V0X3NvdXJjZXMnOgphcmNoL2FybS9tYWNoLW9tYXAyL3By
Y20uYzo1MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgb21hcDJfcHJtX3JlYWRfbW9kX3JlZycK
YXJjaC9hcm0vbWFjaC1vbWFwMi9idWlsdC1pbi5vOiBJbiBmdW5jdGlvbiBgY2xrZG1fY2xlYXJf
YWxsX3drZGVwcyc6CmFyY2gvYXJtL21hY2gtb21hcDIvY2xvY2tkb21haW4uYzo1NDU6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYG9tYXAyX3BybV9jbGVhcl9tb2RfcmVnX2JpdHMnCmFyY2gvYXJt
L21hY2gtb21hcDIvYnVpbHQtaW4ubzogSW4gZnVuY3Rpb24gYGNsa2RtX2RlbF93a2RlcCc6CmFy
Y2gvYXJtL21hY2gtb21hcDIvY2xvY2tkb21haW4uYzo0NzU6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYG9tYXAyX3BybV9jbGVhcl9tb2RfcmVnX2JpdHMnCmFyY2gvYXJtL21hY2gtb21hcDIvYnVp
bHQtaW4ubzogSW4gZnVuY3Rpb24gYGNsa2RtX3JlYWRfd2tkZXAnOgphcmNoL2FybS9tYWNoLW9t
YXAyL2Nsb2NrZG9tYWluLmM6NTExOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBvbWFwMl9wcm1f
cmVhZF9tb2RfYml0c19zaGlmdCcKYXJjaC9hcm0vbWFjaC1vbWFwMi9idWlsdC1pbi5vOiBJbiBm
dW5jdGlvbiBgY2xrZG1fYWRkX3drZGVwJzoKYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9ja2RvbWFp
bi5jOjQ0MDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgb21hcDJfcHJtX3NldF9tb2RfcmVnX2Jp
dHMnCm1ha2U6ICoqKiBbLnRtcF92bWxpbnV4MV0gRXJyb3IgMQoKVGhpcyBwYXRjaCBhZGRzIHN0
dWJzIGZvciB0aGVzZSBmdW5jdGlvbnMgc28gdGhhdCBidWlsZCBjb250aW51ZXMgdG8gd29yay4K
ClNpZ25lZC1vZmYtYnk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5j
b20+CkFja2VkLWJ5OiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2FuLmNvbT4KLS0tCiBhcmNoL2Fy
bS9tYWNoLW9tYXAyL3BybTJ4eHhfM3h4eC5oIHwgICA2MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTJ4eHhfM3h4eC5o
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wcm0yeHh4XzN4eHguaAppbmRleCA1M2Q0NGY2Li40OTY1
NGM4IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BybTJ4eHhfM3h4eC5oCisrKyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvcHJtMnh4eF8zeHh4LmgKQEAgLTIyOCw3ICsyMjgsNjcgQEAK
IAogCiAjaWZuZGVmIF9fQVNTRU1CTEVSX18KLQorLyoKKyAqIFN0dWIgb21hcDJ4eHgvb21hcDN4
eHggZnVuY3Rpb25zIHNvIHRoYXQgY29tbW9uIGZpbGVzCisgKiBjb250aW51ZSB0byBidWlsZCB3
aGVuIGN1c3RvbSBidWlsZHMgYXJlIHVzZWQKKyAqLworI2lmIGRlZmluZWQoQ09ORklHX0FSQ0hf
T01BUDQpICYmICEoZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMikgfHwJXAorCQkJCQlkZWZpbmVk
KENPTkZJR19BUkNIX09NQVAzKSkKK3N0YXRpYyBpbmxpbmUgdTMyIG9tYXAyX3BybV9yZWFkX21v
ZF9yZWcoczE2IG1vZHVsZSwgdTE2IGlkeCkKK3sKKwlXQVJOKDEsICJwcm06IG9tYXAyeHh4L29t
YXAzeHh4IHNwZWNpZmljIGZ1bmN0aW9uIGFuZCAiCisJCSJub3Qgc3VwcG9zZSB0byBiZSB1c2Vk
IG9uIG9tYXA0XG4iKTsKKwlyZXR1cm4gMDsKK30KK3N0YXRpYyBpbmxpbmUgdm9pZCBvbWFwMl9w
cm1fd3JpdGVfbW9kX3JlZyh1MzIgdmFsLCBzMTYgbW9kdWxlLCB1MTYgaWR4KQoreworCVdBUk4o
MSwgInBybTogb21hcDJ4eHgvb21hcDN4eHggc3BlY2lmaWMgZnVuY3Rpb24gYW5kICIKKwkJIm5v
dCBzdXBwb3NlIHRvIGJlIHVzZWQgb24gb21hcDRcbiIpOworfQorc3RhdGljIGlubGluZSB1MzIg
b21hcDJfcHJtX3Jtd19tb2RfcmVnX2JpdHModTMyIG1hc2ssIHUzMiBiaXRzLAorCQlzMTYgbW9k
dWxlLCBzMTYgaWR4KQoreworCVdBUk4oMSwgInBybTogb21hcDJ4eHgvb21hcDN4eHggc3BlY2lm
aWMgZnVuY3Rpb24gYW5kICIKKwkJIm5vdCBzdXBwb3NlIHRvIGJlIHVzZWQgb24gb21hcDRcbiIp
OworCXJldHVybiAwOworfQorc3RhdGljIGlubGluZSB1MzIgb21hcDJfcHJtX3NldF9tb2RfcmVn
X2JpdHModTMyIGJpdHMsIHMxNiBtb2R1bGUsIHMxNiBpZHgpCit7CisJV0FSTigxLCAicHJtOiBv
bWFwMnh4eC9vbWFwM3h4eCBzcGVjaWZpYyBmdW5jdGlvbiBhbmQgIgorCQkibm90IHN1cHBvc2Ug
dG8gYmUgdXNlZCBvbiBvbWFwNFxuIik7CisJcmV0dXJuIDA7Cit9CitzdGF0aWMgaW5saW5lIHUz
MiBvbWFwMl9wcm1fY2xlYXJfbW9kX3JlZ19iaXRzKHUzMiBiaXRzLCBzMTYgbW9kdWxlLCBzMTYg
aWR4KQoreworCVdBUk4oMSwgInBybTogb21hcDJ4eHgvb21hcDN4eHggc3BlY2lmaWMgZnVuY3Rp
b24gYW5kICIKKwkJIm5vdCBzdXBwb3NlIHRvIGJlIHVzZWQgb24gb21hcDRcbiIpOworCXJldHVy
biAwOworfQorc3RhdGljIGlubGluZSB1MzIgb21hcDJfcHJtX3JlYWRfbW9kX2JpdHNfc2hpZnQo
czE2IGRvbWFpbiwgczE2IGlkeCwgdTMyIG1hc2spCit7CisJV0FSTigxLCAicHJtOiBvbWFwMnh4
eC9vbWFwM3h4eCBzcGVjaWZpYyBmdW5jdGlvbiBhbmQgIgorCQkibm90IHN1cHBvc2UgdG8gYmUg
dXNlZCBvbiBvbWFwNFxuIik7CisJcmV0dXJuIDA7Cit9CitzdGF0aWMgaW5saW5lIGludCBvbWFw
Ml9wcm1faXNfaGFyZHJlc2V0X2Fzc2VydGVkKHMxNiBwcm1fbW9kLCB1OCBzaGlmdCkKK3sKKwlX
QVJOKDEsICJwcm06IG9tYXAyeHh4L29tYXAzeHh4IHNwZWNpZmljIGZ1bmN0aW9uIGFuZCAiCisJ
CSJub3Qgc3VwcG9zZSB0byBiZSB1c2VkIG9uIG9tYXA0XG4iKTsKKwlyZXR1cm4gMDsKK30KK3N0
YXRpYyBpbmxpbmUgaW50IG9tYXAyX3BybV9hc3NlcnRfaGFyZHJlc2V0KHMxNiBwcm1fbW9kLCB1
OCBzaGlmdCkKK3sKKwlXQVJOKDEsICJwcm06IG9tYXAyeHh4L29tYXAzeHh4IHNwZWNpZmljIGZ1
bmN0aW9uIGFuZCAiCisJCSJub3Qgc3VwcG9zZSB0byBiZSB1c2VkIG9uIG9tYXA0XG4iKTsKKwly
ZXR1cm4gMDsKK30KK3N0YXRpYyBpbmxpbmUgaW50IG9tYXAyX3BybV9kZWFzc2VydF9oYXJkcmVz
ZXQoczE2IHBybV9tb2QsIHU4IHNoaWZ0KQoreworCVdBUk4oMSwgInBybTogb21hcDJ4eHgvb21h
cDN4eHggc3BlY2lmaWMgZnVuY3Rpb24gYW5kICIKKwkJIm5vdCBzdXBwb3NlIHRvIGJlIHVzZWQg
b24gb21hcDRcbiIpOworCXJldHVybiAwOworfQorI2Vsc2UKIC8qIFBvd2VyL3Jlc2V0IG1hbmFn
ZW1lbnQgZG9tYWluIHJlZ2lzdGVyIGdldC9zZXQgKi8KIGV4dGVybiB1MzIgb21hcDJfcHJtX3Jl
YWRfbW9kX3JlZyhzMTYgbW9kdWxlLCB1MTYgaWR4KTsKIGV4dGVybiB2b2lkIG9tYXAyX3BybV93
cml0ZV9tb2RfcmVnKHUzMiB2YWwsIHMxNiBtb2R1bGUsIHUxNiBpZHgpOwpAQCAtMjQyLDYgKzMw
Miw3IEBAIGV4dGVybiBpbnQgb21hcDJfcHJtX2lzX2hhcmRyZXNldF9hc3NlcnRlZChzMTYgcHJt
X21vZCwgdTggc2hpZnQpOwogZXh0ZXJuIGludCBvbWFwMl9wcm1fYXNzZXJ0X2hhcmRyZXNldChz
MTYgcHJtX21vZCwgdTggc2hpZnQpOwogZXh0ZXJuIGludCBvbWFwMl9wcm1fZGVhc3NlcnRfaGFy
ZHJlc2V0KHMxNiBwcm1fbW9kLCB1OCBzaGlmdCk7CiAKKyNlbmRpZgkvKiBDT05GSUdfQVJDSF9P
TUFQNCAqLwogI2VuZGlmCiAKIC8qCi0tIAoxLjYuMC40Cgo=
--001636c598db7c3e2704993fb7a1--
