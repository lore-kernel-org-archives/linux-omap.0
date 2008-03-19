From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: [PATCH] dmtimer posting
Date: Tue, 18 Mar 2008 21:40:19 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com>
References: <ae36f8040803061301y6e0823a8pbdf0b6f0b47e5639@mail.gmail.com><3B6D69C3A9EBCA4BA5DA60D91302742903AFC880@dlee13.ent.ti.com><20080307071454.GC7635@atomide.com><3B6D69C3A9EBCA4BA5DA60D91302742903C4A2ED@dlee13.ent.ti.com> <87abkv9917.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C8896A.92E155C2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43502 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757322AbYCSUAG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2008 16:00:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87abkv9917.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8896A.92E155C2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I've fixed the bits Kevin pointed out and ran checkpatch.pl and removed
the reset of the errors.

This patch adds the use of write posting for the timer.  Previously,
every write could lock the requestor for almost 3x32KHz cycles.  This
now only synchronizes before writes and reads instead of after them and
it does it on a register per register basis.  Doing it this way there is
some chance to hide some of the sync latency.  It also removes some
needless reads when non-posted mode is there.  With out this fix the
read/writes talk almost 2% CPU load @500MHz just waiting on tick timer
registers.

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
=20
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 302ad8d..e218ebd 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -67,6 +67,29 @@
 #define OMAP_TIMER_CTRL_AR		(1 << 1)	/* auto-reload
enable */
 #define OMAP_TIMER_CTRL_ST		(1 << 0)	/* start timer
*/
=20
+/* Write posting bit shift table
+ * - Values are register shift for TWPS status bits
+ * - Use of this avoids 32KHz Synchronization penalties. The cost is
almost
+ *   a 3x32KHz stall.  This is comapred to a 166MHz posted access.
+ * - A value of '15' is a shift which always returns 0
+ *   for registers which are not postable
+ *
+ * Note: Faster code can be generated if a larger array is used.
+ */
+#define PROW	6
+#define PCOL	4
+#define WPINDEX(off)	(wpost[off >> 4][(off & 0xf) >> 2])
+
+static unsigned char wpost[PROW][PCOL] =3D {
+			/* 0, 4, 8, c */
+/* 00 */	{15, 15, 15, 15},
+/* 10 */	{15, 15, 15, 15},
+/* 20 */	{15,  0,  1,  2},
+/* 30 */	{ 3, 15,  4, 15},
+/* 40 */	{15, 15,  5, 06},
+/* 50 */	{ 7,  8,  9, 15},
+};
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
@@ -76,6 +99,7 @@ struct omap_dm_timer {
 	void __iomem *io_base;
 	unsigned reserved:1;
 	unsigned enabled:1;
+	unsigned posted:1;
 };
=20
 #ifdef CONFIG_ARCH_OMAP1
@@ -181,16 +205,25 @@ static struct clk **dm_source_clocks;
=20
 static spinlock_t dm_timer_lock;
=20
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer,
int reg)
+u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
 {
+	/* A read of a non completed write will be a read error */
+	if (timer->posted)
+		while (readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG)
&
+			(1 << WPINDEX(reg)))
+			;
 	return readl(timer->io_base + reg);
 }
=20
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int
reg, u32 value)
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int
reg,
+					u32 value)
 {
+	/* A write on a register which has a pending write will be lost
*/
+	if (timer->posted)
+		while (readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG)
&
+			(1 << WPINDEX(reg)))
+			;
 	writel(value, timer->io_base + reg);
-	while (omap_dm_timer_read_reg(timer, OMAP_TIMER_WRITE_PEND_REG))
-		;
 }
=20
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -217,15 +250,17 @@ static void omap_dm_timer_reset(struct
omap_dm_timer *timer)
 	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
=20
-	/* Set to smart-idle mode */
 	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |=3D 0x02 << 3;
+	l |=3D 0x02 << 3;  /* Set to smart-idle mode */
+	l |=3D 0x2 << 8;   /* Set clock activity to perserve f-clock on
idle */
=20
-	if (cpu_class_is_omap2() && timer =3D=3D &dm_timers[0]) {
-		/* Enable wake-up only for GPT1 on OMAP2 CPUs*/
+	if (cpu_class_is_omap2() && (timer =3D=3D &dm_timers[0])) {
+		/* Enable wake-up only for GPT1 on OMAP2 CPUs */
+		/* FIXME: All should have this enabled and clear PRCM
status */
 		l |=3D 1 << 2;
-		/* Non-posted mode */
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
0);
+		/* Ensure posted mode */
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+				(1 << 2));
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
 }
@@ -434,6 +469,8 @@ void omap_dm_timer_set_load(struct omap_dm_timer
*timer, int autoreload,
 		l &=3D ~OMAP_TIMER_CTRL_AR;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	/* ? hw feature, ttgr overtaking tldr */
+	while (readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG));
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
=20
@@ -568,6 +605,7 @@ int __init omap_dm_timer_init(void)
 	for (i =3D 0; i < dm_timer_count; i++) {
 		timer =3D &dm_timers[i];
 		timer->io_base =3D (void __iomem
*)io_p2v(timer->phys_base);
+		timer->posted =3D 1;  /* post by default */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];

------_=_NextPart_001_01C8896A.92E155C2
Content-Type: application/octet-stream;
	name="omap-git-post.diff"
Content-Transfer-Encoding: base64
Content-Description: omap-git-post.diff
Content-Disposition: attachment;
	filename="omap-git-post.diff"

VGhpcyBwYXRjaCBhZGRzIHRoZSB1c2Ugb2Ygd3JpdGUgcG9zdGluZyBmb3IgdGhlIHRpbWVyLiAg
UHJldmlvdXNseSwgZXZlcnkKd3JpdGUgY291bGQgbG9jayB0aGUgcmVxdWVzdG9yIGZvciBhbG1v
c3QgM3gzMktIeiBjeWNsZXMuICBUaGlzIG5vdyBvbmx5CnN5bmNocm9uaXplcyBiZWZvcmUgd3Jp
dGVzIGFuZCByZWFkcyBpbnN0ZWFkIG9mIGFmdGVyIHRoZW0gYW5kIGl0IGRvZXMKaXQgb24gYSBy
ZWdpc3RlciBwZXIgcmVnaXN0ZXIgYmFzaXMuICBEb2luZyBpdCB0aGlzIHdheSB0aGVyZSBpcyBz
b21lCmNoYW5jZSB0byBoaWRlIHNvbWUgb2YgdGhlIHN5bmMgbGF0ZW5jeS4gIEl0IGFsc28gcmVt
b3ZlcyBzb21lIG5lZWRsZXNzCnJlYWRzIHdoZW4gbm9uLXBvc3RlZCBtb2RlIGlzIHRoZXJlLiAg
V2l0aCBvdXQgdGhpcyBmaXggdGhlIHJlYWQvd3JpdGVzIHRhbGsKYWxtb3N0IDIlIENQVSBsb2Fk
IEA1MDBNSHoganVzdCB3YWl0aW5nIG9uIHRpY2sgdGltZXIgcmVnaXN0ZXJzLgoKU2lnbmVkLW9m
Zi1ieTogUmljaGFyZCBXb29kcnVmZiA8ci13b29kcnVmZjJAdGkuY29tPgoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL3BsYXQtb21hcC9kbXRpbWVyLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1l
ci5jCmluZGV4IDMwMmFkOGQuLmUyMThlYmQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21h
cC9kbXRpbWVyLmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYwpAQCAtNjcsNiAr
NjcsMjkgQEAKICNkZWZpbmUgT01BUF9USU1FUl9DVFJMX0FSCQkoMSA8PCAxKQkvKiBhdXRvLXJl
bG9hZCBlbmFibGUgKi8KICNkZWZpbmUgT01BUF9USU1FUl9DVFJMX1NUCQkoMSA8PCAwKQkvKiBz
dGFydCB0aW1lciAqLwogCisvKiBXcml0ZSBwb3N0aW5nIGJpdCBzaGlmdCB0YWJsZQorICogLSBW
YWx1ZXMgYXJlIHJlZ2lzdGVyIHNoaWZ0IGZvciBUV1BTIHN0YXR1cyBiaXRzCisgKiAtIFVzZSBv
ZiB0aGlzIGF2b2lkcyAzMktIeiBTeW5jaHJvbml6YXRpb24gcGVuYWx0aWVzLiBUaGUgY29zdCBp
cyBhbG1vc3QKKyAqICAgYSAzeDMyS0h6IHN0YWxsLiAgVGhpcyBpcyBjb21hcHJlZCB0byBhIDE2
Nk1IeiBwb3N0ZWQgYWNjZXNzLgorICogLSBBIHZhbHVlIG9mICcxNScgaXMgYSBzaGlmdCB3aGlj
aCBhbHdheXMgcmV0dXJucyAwCisgKiAgIGZvciByZWdpc3RlcnMgd2hpY2ggYXJlIG5vdCBwb3N0
YWJsZQorICoKKyAqIE5vdGU6IEZhc3RlciBjb2RlIGNhbiBiZSBnZW5lcmF0ZWQgaWYgYSBsYXJn
ZXIgYXJyYXkgaXMgdXNlZC4KKyAqLworI2RlZmluZSBQUk9XCTYKKyNkZWZpbmUgUENPTAk0Cisj
ZGVmaW5lIFdQSU5ERVgob2ZmKQkod3Bvc3Rbb2ZmID4+IDRdWyhvZmYgJiAweGYpID4+IDJdKQor
CitzdGF0aWMgdW5zaWduZWQgY2hhciB3cG9zdFtQUk9XXVtQQ09MXSA9IHsKKwkJCS8qIDAsIDQs
IDgsIGMgKi8KKy8qIDAwICovCXsxNSwgMTUsIDE1LCAxNX0sCisvKiAxMCAqLwl7MTUsIDE1LCAx
NSwgMTV9LAorLyogMjAgKi8JezE1LCAgMCwgIDEsICAyfSwKKy8qIDMwICovCXsgMywgMTUsICA0
LCAxNX0sCisvKiA0MCAqLwl7MTUsIDE1LCAgNSwgMDZ9LAorLyogNTAgKi8JeyA3LCAgOCwgIDks
IDE1fSwKK307CisKIHN0cnVjdCBvbWFwX2RtX3RpbWVyIHsKIAl1bnNpZ25lZCBsb25nIHBoeXNf
YmFzZTsKIAlpbnQgaXJxOwpAQCAtNzYsNiArOTksNyBAQCBzdHJ1Y3Qgb21hcF9kbV90aW1lciB7
CiAJdm9pZCBfX2lvbWVtICppb19iYXNlOwogCXVuc2lnbmVkIHJlc2VydmVkOjE7CiAJdW5zaWdu
ZWQgZW5hYmxlZDoxOworCXVuc2lnbmVkIHBvc3RlZDoxOwogfTsKIAogI2lmZGVmIENPTkZJR19B
UkNIX09NQVAxCkBAIC0xODEsMTYgKzIwNSwyNSBAQCBzdGF0aWMgc3RydWN0IGNsayAqKmRtX3Nv
dXJjZV9jbG9ja3M7CiAKIHN0YXRpYyBzcGlubG9ja190IGRtX3RpbWVyX2xvY2s7CiAKLXN0YXRp
YyBpbmxpbmUgdTMyIG9tYXBfZG1fdGltZXJfcmVhZF9yZWcoc3RydWN0IG9tYXBfZG1fdGltZXIg
KnRpbWVyLCBpbnQgcmVnKQordTMyIG9tYXBfZG1fdGltZXJfcmVhZF9yZWcoc3RydWN0IG9tYXBf
ZG1fdGltZXIgKnRpbWVyLCBpbnQgcmVnKQogeworCS8qIEEgcmVhZCBvZiBhIG5vbiBjb21wbGV0
ZWQgd3JpdGUgd2lsbCBiZSBhIHJlYWQgZXJyb3IgKi8KKwlpZiAodGltZXItPnBvc3RlZCkKKwkJ
d2hpbGUgKHJlYWRsKHRpbWVyLT5pb19iYXNlICsgT01BUF9USU1FUl9XUklURV9QRU5EX1JFRykg
JgorCQkJKDEgPDwgV1BJTkRFWChyZWcpKSkKKwkJCTsKIAlyZXR1cm4gcmVhZGwodGltZXItPmlv
X2Jhc2UgKyByZWcpOwogfQogCi1zdGF0aWMgdm9pZCBvbWFwX2RtX3RpbWVyX3dyaXRlX3JlZyhz
dHJ1Y3Qgb21hcF9kbV90aW1lciAqdGltZXIsIGludCByZWcsIHUzMiB2YWx1ZSkKK3N0YXRpYyB2
b2lkIG9tYXBfZG1fdGltZXJfd3JpdGVfcmVnKHN0cnVjdCBvbWFwX2RtX3RpbWVyICp0aW1lciwg
aW50IHJlZywKKwkJCQkJdTMyIHZhbHVlKQogeworCS8qIEEgd3JpdGUgb24gYSByZWdpc3RlciB3
aGljaCBoYXMgYSBwZW5kaW5nIHdyaXRlIHdpbGwgYmUgbG9zdCAqLworCWlmICh0aW1lci0+cG9z
dGVkKQorCQl3aGlsZSAocmVhZGwodGltZXItPmlvX2Jhc2UgKyBPTUFQX1RJTUVSX1dSSVRFX1BF
TkRfUkVHKSAmCisJCQkoMSA8PCBXUElOREVYKHJlZykpKQorCQkJOwogCXdyaXRlbCh2YWx1ZSwg
dGltZXItPmlvX2Jhc2UgKyByZWcpOwotCXdoaWxlIChvbWFwX2RtX3RpbWVyX3JlYWRfcmVnKHRp
bWVyLCBPTUFQX1RJTUVSX1dSSVRFX1BFTkRfUkVHKSkKLQkJOwogfQogCiBzdGF0aWMgdm9pZCBv
bWFwX2RtX3RpbWVyX3dhaXRfZm9yX3Jlc2V0KHN0cnVjdCBvbWFwX2RtX3RpbWVyICp0aW1lcikK
QEAgLTIxNywxNSArMjUwLDE3IEBAIHN0YXRpYyB2b2lkIG9tYXBfZG1fdGltZXJfcmVzZXQoc3Ry
dWN0IG9tYXBfZG1fdGltZXIgKnRpbWVyKQogCX0KIAlvbWFwX2RtX3RpbWVyX3NldF9zb3VyY2Uo
dGltZXIsIE9NQVBfVElNRVJfU1JDXzMyX0tIWik7CiAKLQkvKiBTZXQgdG8gc21hcnQtaWRsZSBt
b2RlICovCiAJbCA9IG9tYXBfZG1fdGltZXJfcmVhZF9yZWcodGltZXIsIE9NQVBfVElNRVJfT0NQ
X0NGR19SRUcpOwotCWwgfD0gMHgwMiA8PCAzOworCWwgfD0gMHgwMiA8PCAzOyAgLyogU2V0IHRv
IHNtYXJ0LWlkbGUgbW9kZSAqLworCWwgfD0gMHgyIDw8IDg7ICAgLyogU2V0IGNsb2NrIGFjdGl2
aXR5IHRvIHBlcnNlcnZlIGYtY2xvY2sgb24gaWRsZSAqLwogCi0JaWYgKGNwdV9jbGFzc19pc19v
bWFwMigpICYmIHRpbWVyID09ICZkbV90aW1lcnNbMF0pIHsKLQkJLyogRW5hYmxlIHdha2UtdXAg
b25seSBmb3IgR1BUMSBvbiBPTUFQMiBDUFVzKi8KKwlpZiAoY3B1X2NsYXNzX2lzX29tYXAyKCkg
JiYgKHRpbWVyID09ICZkbV90aW1lcnNbMF0pKSB7CisJCS8qIEVuYWJsZSB3YWtlLXVwIG9ubHkg
Zm9yIEdQVDEgb24gT01BUDIgQ1BVcyAqLworCQkvKiBGSVhNRTogQWxsIHNob3VsZCBoYXZlIHRo
aXMgZW5hYmxlZCBhbmQgY2xlYXIgUFJDTSBzdGF0dXMgKi8KIAkJbCB8PSAxIDw8IDI7Ci0JCS8q
IE5vbi1wb3N0ZWQgbW9kZSAqLwotCQlvbWFwX2RtX3RpbWVyX3dyaXRlX3JlZyh0aW1lciwgT01B
UF9USU1FUl9JRl9DVFJMX1JFRywgMCk7CisJCS8qIEVuc3VyZSBwb3N0ZWQgbW9kZSAqLworCQlv
bWFwX2RtX3RpbWVyX3dyaXRlX3JlZyh0aW1lciwgT01BUF9USU1FUl9JRl9DVFJMX1JFRywKKwkJ
CQkoMSA8PCAyKSk7CiAJfQogCW9tYXBfZG1fdGltZXJfd3JpdGVfcmVnKHRpbWVyLCBPTUFQX1RJ
TUVSX09DUF9DRkdfUkVHLCBsKTsKIH0KQEAgLTQzNCw2ICs0NjksOCBAQCB2b2lkIG9tYXBfZG1f
dGltZXJfc2V0X2xvYWQoc3RydWN0IG9tYXBfZG1fdGltZXIgKnRpbWVyLCBpbnQgYXV0b3JlbG9h
ZCwKIAkJbCAmPSB+T01BUF9USU1FUl9DVFJMX0FSOwogCW9tYXBfZG1fdGltZXJfd3JpdGVfcmVn
KHRpbWVyLCBPTUFQX1RJTUVSX0NUUkxfUkVHLCBsKTsKIAlvbWFwX2RtX3RpbWVyX3dyaXRlX3Jl
Zyh0aW1lciwgT01BUF9USU1FUl9MT0FEX1JFRywgbG9hZCk7CisJLyogPyBodyBmZWF0dXJlLCB0
dGdyIG92ZXJ0YWtpbmcgdGxkciAqLworCXdoaWxlIChyZWFkbCh0aW1lci0+aW9fYmFzZSArIE9N
QVBfVElNRVJfV1JJVEVfUEVORF9SRUcpKTsKIAlvbWFwX2RtX3RpbWVyX3dyaXRlX3JlZyh0aW1l
ciwgT01BUF9USU1FUl9UUklHR0VSX1JFRywgMCk7CiB9CiAKQEAgLTU2OCw2ICs2MDUsNyBAQCBp
bnQgX19pbml0IG9tYXBfZG1fdGltZXJfaW5pdCh2b2lkKQogCWZvciAoaSA9IDA7IGkgPCBkbV90
aW1lcl9jb3VudDsgaSsrKSB7CiAJCXRpbWVyID0gJmRtX3RpbWVyc1tpXTsKIAkJdGltZXItPmlv
X2Jhc2UgPSAodm9pZCBfX2lvbWVtICopaW9fcDJ2KHRpbWVyLT5waHlzX2Jhc2UpOworCQl0aW1l
ci0+cG9zdGVkID0gMTsgIC8qIHBvc3QgYnkgZGVmYXVsdCAqLwogI2lmIGRlZmluZWQoQ09ORklH
X0FSQ0hfT01BUDIpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDMpCiAJCWlmIChjcHVfY2xh
c3NfaXNfb21hcDIoKSkgewogCQkJY2hhciBjbGtfbmFtZVsxNl07Cg==

------_=_NextPart_001_01C8896A.92E155C2--
