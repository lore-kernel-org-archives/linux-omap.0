From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 23:53:35 +0530
Message-ID: <627ff975140c8e4afbad281105b29d35@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
 <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
 <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
 <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk>
 <20110125130611.GA15663@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a60bb92b83049aafd098
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55214 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492Ab1AYSXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 13:23:40 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so68920fxm.31
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 10:23:39 -0800 (PST)
In-Reply-To: <20110125130611.GA15663@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

--20cf3054a60bb92b83049aafd098
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 6:36 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 01:04:22PM +0000, Russell King - ARM Linux
> wrote:
> > Actually, we can do this safely - byte stores are permitted to SCU
> > registers probably for this very reason.
>
> 3rd revision of the patch:

After fixing the 3rd version for base address break, I was able to
use this patch and test it. Seems to work. SMC related stuff can
be ignored because OMAP4 ES1.0 doesn't have functional PM hardware
support.

Here is the updated patch which will be 4th revision...

4th revision
---
 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h
b/arch/arm/include/asm/smp_scu.h
index b6f42c9..676bc43 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,7 +7,12 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10

+#define SCU_PM_NORMAL	0
+#define SCU_PM_DORMANT	2
+#define SCU_PM_POWEROFF	3
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
+int scu_power_mode(unsigned int);

 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index ee7bf47..aec7c5d 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -14,6 +14,8 @@
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>

+static void __iomem *base;
+
 /*
  * Get the number of CPU cores from the SCU configuration
  */
@@ -29,14 +31,15 @@ unsigned int __init scu_get_core_count(void __iomem
*scu_base)
 void __init scu_enable(void __iomem *scu_base)
 {
 	u32 scu_ctrl;
+	base = scu_base;

-	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	scu_ctrl = __raw_readl(base + SCU_CTRL);
 	/* already enabled? */
 	if (scu_ctrl & 1)
 		return;

 	scu_ctrl |= 1;
-	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+	__raw_writel(scu_ctrl, base + SCU_CTRL);

 	/*
 	 * Ensure that the data accessed by CPU0 before the SCU was
@@ -44,3 +47,19 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+int scu_power_mode(unsigned int mode)
+{
+	unsigned int val;
+	int cpu = smp_processor_id();
+	int shift;
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	val = __raw_readb(base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val |= mode;
+	__raw_writeb(val, base + SCU_CPU_STATUS + cpu);
+
+	return 0;
+}
-- 
1.6.0.4

--20cf3054a60bb92b83049aafd098
Content-Type: application/octet-stream; name="0001-4th-revision.patch"
Content-Disposition: attachment; filename="0001-4th-revision.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 86ad572624c9c85c_0.1

NHRoIHJldmlzaW9uCgotLS0KIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3NtcF9zY3UuaCB8ICAgIDUg
KysrKysKIGFyY2gvYXJtL2tlcm5lbC9zbXBfc2N1LmMgICAgICB8ICAgMjMgKysrKysrKysrKysr
KysrKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9zbXBfc2N1LmggYi9hcmNo
L2FybS9pbmNsdWRlL2FzbS9zbXBfc2N1LmgKaW5kZXggYjZmNDJjOS4uNjc2YmM0MyAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vc21wX3NjdS5oCisrKyBiL2FyY2gvYXJtL2luY2x1
ZGUvYXNtL3NtcF9zY3UuaApAQCAtNyw3ICs3LDEyIEBACiAjZGVmaW5lIFNDVV9JTlZBTElEQVRF
CQkweDBjCiAjZGVmaW5lIFNDVV9GUEdBX1JFVklTSU9OCTB4MTAKIAorI2RlZmluZSBTQ1VfUE1f
Tk9STUFMCTAKKyNkZWZpbmUgU0NVX1BNX0RPUk1BTlQJMgorI2RlZmluZSBTQ1VfUE1fUE9XRVJP
RkYJMworCiB1bnNpZ25lZCBpbnQgc2N1X2dldF9jb3JlX2NvdW50KHZvaWQgX19pb21lbSAqKTsK
IHZvaWQgc2N1X2VuYWJsZSh2b2lkIF9faW9tZW0gKik7CitpbnQgc2N1X3Bvd2VyX21vZGUodW5z
aWduZWQgaW50KTsKIAogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvc21wX3Nj
dS5jIGIvYXJjaC9hcm0va2VybmVsL3NtcF9zY3UuYwppbmRleCBlZTdiZjQ3Li5hZWM3YzVkIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9rZXJuZWwvc21wX3NjdS5jCisrKyBiL2FyY2gvYXJtL2tlcm5l
bC9zbXBfc2N1LmMKQEAgLTE0LDYgKzE0LDggQEAKICNpbmNsdWRlIDxhc20vc21wX3NjdS5oPgog
I2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+CiAKK3N0YXRpYyB2b2lkIF9faW9tZW0gKmJhc2U7
CisKIC8qCiAgKiBHZXQgdGhlIG51bWJlciBvZiBDUFUgY29yZXMgZnJvbSB0aGUgU0NVIGNvbmZp
Z3VyYXRpb24KICAqLwpAQCAtMjksMTQgKzMxLDE1IEBAIHVuc2lnbmVkIGludCBfX2luaXQgc2N1
X2dldF9jb3JlX2NvdW50KHZvaWQgX19pb21lbSAqc2N1X2Jhc2UpCiB2b2lkIF9faW5pdCBzY3Vf
ZW5hYmxlKHZvaWQgX19pb21lbSAqc2N1X2Jhc2UpCiB7CiAJdTMyIHNjdV9jdHJsOworCWJhc2Ug
PSBzY3VfYmFzZTsKIAotCXNjdV9jdHJsID0gX19yYXdfcmVhZGwoc2N1X2Jhc2UgKyBTQ1VfQ1RS
TCk7CisJc2N1X2N0cmwgPSBfX3Jhd19yZWFkbChiYXNlICsgU0NVX0NUUkwpOwogCS8qIGFscmVh
ZHkgZW5hYmxlZD8gKi8KIAlpZiAoc2N1X2N0cmwgJiAxKQogCQlyZXR1cm47CiAKIAlzY3VfY3Ry
bCB8PSAxOwotCV9fcmF3X3dyaXRlbChzY3VfY3RybCwgc2N1X2Jhc2UgKyBTQ1VfQ1RSTCk7CisJ
X19yYXdfd3JpdGVsKHNjdV9jdHJsLCBiYXNlICsgU0NVX0NUUkwpOwogCiAJLyoKIAkgKiBFbnN1
cmUgdGhhdCB0aGUgZGF0YSBhY2Nlc3NlZCBieSBDUFUwIGJlZm9yZSB0aGUgU0NVIHdhcwpAQCAt
NDQsMyArNDcsMTkgQEAgdm9pZCBfX2luaXQgc2N1X2VuYWJsZSh2b2lkIF9faW9tZW0gKnNjdV9i
YXNlKQogCSAqLwogCWZsdXNoX2NhY2hlX2FsbCgpOwogfQorCitpbnQgc2N1X3Bvd2VyX21vZGUo
dW5zaWduZWQgaW50IG1vZGUpCit7CisJdW5zaWduZWQgaW50IHZhbDsKKwlpbnQgY3B1ID0gc21w
X3Byb2Nlc3Nvcl9pZCgpOworCWludCBzaGlmdDsKKworCWlmIChtb2RlID4gMyB8fCBtb2RlID09
IDEgfHwgY3B1ID4gMykKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwl2YWwgPSBfX3Jhd19yZWFkYihi
YXNlICsgU0NVX0NQVV9TVEFUVVMgKyBjcHUpICYgfjB4MDM7CisJdmFsIHw9IG1vZGU7CisJX19y
YXdfd3JpdGViKHZhbCwgYmFzZSArIFNDVV9DUFVfU1RBVFVTICsgY3B1KTsKKworCXJldHVybiAw
OworfQotLSAKMS42LjAuNAoK
--20cf3054a60bb92b83049aafd098--
