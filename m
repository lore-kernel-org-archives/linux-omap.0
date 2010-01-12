From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Mon, 11 Jan 2010 17:50:54 -0800
Message-ID: <6cb013311001111750m17430092p8d9bd1102152db8b@mail.gmail.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
	<6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
	<20100109183321.GH2879@atomide.com> <6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
	<20100112012814.GK5055@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e1fb26a6d2ac047cede363
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100112012814.GK5055-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--001636e1fb26a6d2ac047cede363
Content-Type: text/plain; charset=UTF-8

On Mon, Jan 11, 2010 at 5:28 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Applied to omap-testing with the following fix. Can you please merge
> it into your original patch?
>

Done, I've attached the new patch to here.  I've tested it and it
works perfectly.

- Cory


>From 7c693afce8ffa3978b4fcecc56cd7d4a9d9d3b75 Mon Sep 17 00:00:00 2001
From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 5 Dec 2009 22:00:25 -0800
Subject: [PATCH] [I2C-OMAP] Add support for 16-bit registers

The current i2c-omap driver is set up for 32-bit registers, which
corresponds to most OMAP devices.  However, OMAP730/850 based
devices use a 16-bit register size.

This change modifies the driver to perform a runtime CPU type check
to determine the register sizes, and uses a bit shift of either 1
or 2 bits to compute the proper register sizes for all registers.

Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   45 +++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0037e31..9c3ce4d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -49,24 +49,24 @@
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))

 #define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x04
-#define OMAP_I2C_STAT_REG		0x08
-#define OMAP_I2C_IV_REG			0x0c
+#define OMAP_I2C_IE_REG			0x01
+#define OMAP_I2C_STAT_REG		0x02
+#define OMAP_I2C_IV_REG			0x03
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x0c
-#define OMAP_I2C_SYSS_REG		0x10
-#define OMAP_I2C_BUF_REG		0x14
-#define OMAP_I2C_CNT_REG		0x18
-#define OMAP_I2C_DATA_REG		0x1c
-#define OMAP_I2C_SYSC_REG		0x20
-#define OMAP_I2C_CON_REG		0x24
-#define OMAP_I2C_OA_REG			0x28
-#define OMAP_I2C_SA_REG			0x2c
-#define OMAP_I2C_PSC_REG		0x30
-#define OMAP_I2C_SCLL_REG		0x34
-#define OMAP_I2C_SCLH_REG		0x38
-#define OMAP_I2C_SYSTEST_REG		0x3c
-#define OMAP_I2C_BUFSTAT_REG		0x40
+#define OMAP_I2C_WE_REG			0x03
+#define OMAP_I2C_SYSS_REG		0x04
+#define OMAP_I2C_BUF_REG		0x05
+#define OMAP_I2C_CNT_REG		0x06
+#define OMAP_I2C_DATA_REG		0x07
+#define OMAP_I2C_SYSC_REG		0x08
+#define OMAP_I2C_CON_REG		0x09
+#define OMAP_I2C_OA_REG			0x0a
+#define OMAP_I2C_SA_REG			0x0b
+#define OMAP_I2C_PSC_REG		0x0c
+#define OMAP_I2C_SCLL_REG		0x0d
+#define OMAP_I2C_SCLH_REG		0x0e
+#define OMAP_I2C_SYSTEST_REG		0x0f
+#define OMAP_I2C_BUFSTAT_REG		0x10

 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
@@ -161,6 +161,7 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
+	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct clk		*iclk;		/* Interface clock */
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
@@ -189,12 +190,12 @@ struct omap_i2c_dev {
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base + reg);
+	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
 }

 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base + reg);
+	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
 }

 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
@@ -893,6 +894,12 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
+
+	if (cpu_is_omap7xx())
+		dev->reg_shift = 1;
+	else
+		dev->reg_shift = 2;
+
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (!dev->base) {
 		r = -ENOMEM;
-- 
1.6.3.3

--001636e1fb26a6d2ac047cede363
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-I2C-OMAP-Add-support-for-16-bit-registers.patch"
Content-Disposition: attachment;
	filename="0001-I2C-OMAP-Add-support-for-16-bit-registers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4c0y4ha1

RnJvbSA3YzY5M2FmY2U4ZmZhMzk3OGI0ZmNlY2M1NmNkN2Q0YTlkOWQzYjc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDb3J5IE1hY2NhcnJvbmUgPGRhcmtzdGFyNjI2MkBnbWFpbC5j
b20+CkRhdGU6IFNhdCwgNSBEZWMgMjAwOSAyMjowMDoyNSAtMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IFtJMkMtT01BUF0gQWRkIHN1cHBvcnQgZm9yIDE2LWJpdCByZWdpc3RlcnMKClRoZSBjdXJyZW50
IGkyYy1vbWFwIGRyaXZlciBpcyBzZXQgdXAgZm9yIDMyLWJpdCByZWdpc3RlcnMsIHdoaWNoCmNv
cnJlc3BvbmRzIHRvIG1vc3QgT01BUCBkZXZpY2VzLiAgSG93ZXZlciwgT01BUDczMC84NTAgYmFz
ZWQKZGV2aWNlcyB1c2UgYSAxNi1iaXQgcmVnaXN0ZXIgc2l6ZS4KClRoaXMgY2hhbmdlIG1vZGlm
aWVzIHRoZSBkcml2ZXIgdG8gcGVyZm9ybSBhIHJ1bnRpbWUgQ1BVIHR5cGUgY2hlY2sKdG8gZGV0
ZXJtaW5lIHRoZSByZWdpc3RlciBzaXplcywgYW5kIHVzZXMgYSBiaXQgc2hpZnQgb2YgZWl0aGVy
IDEKb3IgMiBiaXRzIHRvIGNvbXB1dGUgdGhlIHByb3BlciByZWdpc3RlciBzaXplcyBmb3IgYWxs
IHJlZ2lzdGVycy4KClNpZ25lZC1vZmYtYnk6IENvcnkgTWFjY2Fycm9uZSA8ZGFya3N0YXI2MjYy
QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9tYXAuYyB8ICAgNDUgKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLW9tYXAuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jCmluZGV4
IDAwMzdlMzEuLjljM2NlNGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21h
cC5jCisrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jCkBAIC00OSwyNCArNDksMjQg
QEAKICNkZWZpbmUgT01BUF9JMkNfVElNRU9VVCAobXNlY3NfdG9famlmZmllcygxMDAwKSkKIAog
I2RlZmluZSBPTUFQX0kyQ19SRVZfUkVHCQkweDAwCi0jZGVmaW5lIE9NQVBfSTJDX0lFX1JFRwkJ
CTB4MDQKLSNkZWZpbmUgT01BUF9JMkNfU1RBVF9SRUcJCTB4MDgKLSNkZWZpbmUgT01BUF9JMkNf
SVZfUkVHCQkJMHgwYworI2RlZmluZSBPTUFQX0kyQ19JRV9SRUcJCQkweDAxCisjZGVmaW5lIE9N
QVBfSTJDX1NUQVRfUkVHCQkweDAyCisjZGVmaW5lIE9NQVBfSTJDX0lWX1JFRwkJCTB4MDMKIC8q
IEZvciBPTUFQMyBJMkNfSVYgaGFzIGNoYW5nZWQgdG8gSTJDX1dFICh3YWtldXAgZW5hYmxlKSAq
LwotI2RlZmluZSBPTUFQX0kyQ19XRV9SRUcJCQkweDBjCi0jZGVmaW5lIE9NQVBfSTJDX1NZU1Nf
UkVHCQkweDEwCi0jZGVmaW5lIE9NQVBfSTJDX0JVRl9SRUcJCTB4MTQKLSNkZWZpbmUgT01BUF9J
MkNfQ05UX1JFRwkJMHgxOAotI2RlZmluZSBPTUFQX0kyQ19EQVRBX1JFRwkJMHgxYwotI2RlZmlu
ZSBPTUFQX0kyQ19TWVNDX1JFRwkJMHgyMAotI2RlZmluZSBPTUFQX0kyQ19DT05fUkVHCQkweDI0
Ci0jZGVmaW5lIE9NQVBfSTJDX09BX1JFRwkJCTB4MjgKLSNkZWZpbmUgT01BUF9JMkNfU0FfUkVH
CQkJMHgyYwotI2RlZmluZSBPTUFQX0kyQ19QU0NfUkVHCQkweDMwCi0jZGVmaW5lIE9NQVBfSTJD
X1NDTExfUkVHCQkweDM0Ci0jZGVmaW5lIE9NQVBfSTJDX1NDTEhfUkVHCQkweDM4Ci0jZGVmaW5l
IE9NQVBfSTJDX1NZU1RFU1RfUkVHCQkweDNjCi0jZGVmaW5lIE9NQVBfSTJDX0JVRlNUQVRfUkVH
CQkweDQwCisjZGVmaW5lIE9NQVBfSTJDX1dFX1JFRwkJCTB4MDMKKyNkZWZpbmUgT01BUF9JMkNf
U1lTU19SRUcJCTB4MDQKKyNkZWZpbmUgT01BUF9JMkNfQlVGX1JFRwkJMHgwNQorI2RlZmluZSBP
TUFQX0kyQ19DTlRfUkVHCQkweDA2CisjZGVmaW5lIE9NQVBfSTJDX0RBVEFfUkVHCQkweDA3Cisj
ZGVmaW5lIE9NQVBfSTJDX1NZU0NfUkVHCQkweDA4CisjZGVmaW5lIE9NQVBfSTJDX0NPTl9SRUcJ
CTB4MDkKKyNkZWZpbmUgT01BUF9JMkNfT0FfUkVHCQkJMHgwYQorI2RlZmluZSBPTUFQX0kyQ19T
QV9SRUcJCQkweDBiCisjZGVmaW5lIE9NQVBfSTJDX1BTQ19SRUcJCTB4MGMKKyNkZWZpbmUgT01B
UF9JMkNfU0NMTF9SRUcJCTB4MGQKKyNkZWZpbmUgT01BUF9JMkNfU0NMSF9SRUcJCTB4MGUKKyNk
ZWZpbmUgT01BUF9JMkNfU1lTVEVTVF9SRUcJCTB4MGYKKyNkZWZpbmUgT01BUF9JMkNfQlVGU1RB
VF9SRUcJCTB4MTAKIAogLyogSTJDIEludGVycnVwdCBFbmFibGUgUmVnaXN0ZXIgKE9NQVBfSTJD
X0lFKTogKi8KICNkZWZpbmUgT01BUF9JMkNfSUVfWERSCQkoMSA8PCAxNCkJLyogVFggQnVmZmVy
IGRyYWluIGludCBlbmFibGUgKi8KQEAgLTE2MSw2ICsxNjEsNyBAQCBzdHJ1Y3Qgb21hcF9pMmNf
ZGV2IHsKIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2OwogCXZvaWQgX19pb21lbQkJKmJhc2U7CQkvKiB2
aXJ0dWFsICovCiAJaW50CQkJaXJxOworCWludAkJCXJlZ19zaGlmdDsgICAgICAvKiBiaXQgc2hp
ZnQgZm9yIEkyQyByZWdpc3RlciBhZGRyZXNzZXMgKi8KIAlzdHJ1Y3QgY2xrCQkqaWNsazsJCS8q
IEludGVyZmFjZSBjbG9jayAqLwogCXN0cnVjdCBjbGsJCSpmY2xrOwkJLyogRnVuY3Rpb25hbCBj
bG9jayAqLwogCXN0cnVjdCBjb21wbGV0aW9uCWNtZF9jb21wbGV0ZTsKQEAgLTE4OSwxMiArMTkw
LDEyIEBAIHN0cnVjdCBvbWFwX2kyY19kZXYgewogc3RhdGljIGlubGluZSB2b2lkIG9tYXBfaTJj
X3dyaXRlX3JlZyhzdHJ1Y3Qgb21hcF9pMmNfZGV2ICppMmNfZGV2LAogCQkJCSAgICAgIGludCBy
ZWcsIHUxNiB2YWwpCiB7Ci0JX19yYXdfd3JpdGV3KHZhbCwgaTJjX2Rldi0+YmFzZSArIHJlZyk7
CisJX19yYXdfd3JpdGV3KHZhbCwgaTJjX2Rldi0+YmFzZSArIChyZWcgPDwgaTJjX2Rldi0+cmVn
X3NoaWZ0KSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdTE2IG9tYXBfaTJjX3JlYWRfcmVnKHN0cnVj
dCBvbWFwX2kyY19kZXYgKmkyY19kZXYsIGludCByZWcpCiB7Ci0JcmV0dXJuIF9fcmF3X3JlYWR3
KGkyY19kZXYtPmJhc2UgKyByZWcpOworCXJldHVybiBfX3Jhd19yZWFkdyhpMmNfZGV2LT5iYXNl
ICsgKHJlZyA8PCBpMmNfZGV2LT5yZWdfc2hpZnQpKTsKIH0KIAogc3RhdGljIGludCBfX2luaXQg
b21hcF9pMmNfZ2V0X2Nsb2NrcyhzdHJ1Y3Qgb21hcF9pMmNfZGV2ICpkZXYpCkBAIC04OTMsNiAr
ODk0LDEyIEBAIG9tYXBfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJ
ZGV2LT5pZGxlID0gMTsKIAlkZXYtPmRldiA9ICZwZGV2LT5kZXY7CiAJZGV2LT5pcnEgPSBpcnEt
PnN0YXJ0OworCisJaWYgKGNwdV9pc19vbWFwN3h4KCkpCisJCWRldi0+cmVnX3NoaWZ0ID0gMTsK
KwllbHNlCisJCWRldi0+cmVnX3NoaWZ0ID0gMjsKKwogCWRldi0+YmFzZSA9IGlvcmVtYXAobWVt
LT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShtZW0pKTsKIAlpZiAoIWRldi0+YmFzZSkgewogCQlyID0g
LUVOT01FTTsKLS0gCjEuNi4zLjMKCg==
--001636e1fb26a6d2ac047cede363--
