From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT* read/write
Date: Tue, 11 Sep 2012 12:49:00 +0530
Message-ID: <CAMQu2gxkQ1JAjbuhFZqUxgrgzrFLhMZk_Q8TzXW5q9Lr3JOmqQ@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
 <20120910185535.GC1303@atomide.com> <CAMQu2gxUES=s8fMpwJ77tnY1wz4b_T=yustj+C+WNkEMmEOx4w@mail.gmail.com>
 <alpine.DEB.2.00.1209110636310.23042@utopia.booyaka.com> <CAMQu2gyXOEs3Zbo=JrPwN2LmUNyYVc35iPWwGZqXCE3BCsn7xg@mail.gmail.com>
 <alpine.DEB.2.00.1209110643010.23042@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54fb4f298daaf04c967e4bf
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34694 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751483Ab2IKHTW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 03:19:22 -0400
Received: by ghbg21 with SMTP id g21so254191ghb.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 00:19:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209110643010.23042@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org

--bcaec54fb4f298daaf04c967e4bf
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Sep 11, 2012 at 12:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Sep 11, 2012 at 12:07 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:
>> >
>> >> On Tue, Sep 11, 2012 at 12:25 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
>> >> >>
>> >> >> Will you able to pick up these couple of wakeupgen fixes from  here or
>> >> >> do you want me to send you a pull request for 3.6-rc5/6
>> >> >
>> >> > I can pick them into fixes-noncritical. But if the second one is
>> >> > a major bug for the -rc series, the patch should be describe what
>> >> > breaks (regression? oops?).
>> >> >
>> >> Fixes non critical is fine. No major issue without these patches.
>> >
>> > There's an ordering constraint though: Santosh's patch needs to go in
>> > first, then mine.
>> >
>> Its other way round ;-)
>> Mine I created after applying your change.
>
> The problem is that if my patch is applied first, then there will be a
> point after my patch where the AUXCOREBOOT1 register won't be saved, which
> might break PM.  So the patches may need to be updated.
>
Good point. It's trivial to re-order them.

Tony,
Updated patches in the end of the email. Also attached.

Regards
Santosh

>From 4e1da2a44d92b956c3a740f5af6a45ff1c2dc294 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 11 Sep 2012 12:43:18 +0530
Subject: [PATCH 2/2] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write

The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
AUXCOREBOOT1 register contents twice.  This seems like a waste of
time, so, remove the duplicates.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index c3795c2..567f672 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -233,12 +233,6 @@ static inline void omap4_irq_save_context(void)
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
-
-	/* Save SyncReq generation logic */
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
 	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
-- 
1.7.9.5


>From 6e3b8a3f6ec231f588b860d87b7a80f6ba38ce98 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 6 Sep 2012 11:51:34 +0530
Subject: [PATCH 1/2] ARM: OMAP4: wakeupgen: Fix the typo in AUXCOREBOOT
 register save

The wakeupgen context-save code reads AUXCOREBOOT0 register
instead of AUXCOREBOOT1 register contents while saving AUXCOREBOOT1.

Fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c
b/arch/arm/mach-omap2/omap-wakeupgen.c
index 05fdebf..c3795c2 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -229,7 +229,7 @@ static inline void omap4_irq_save_context(void)
 	/* Save AuxBoot* registers */
 	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);

 	/* Save SyncReq generation logic */
-- 
1.7.9.5

--bcaec54fb4f298daaf04c967e4bf
Content-Type: application/octet-stream;
	name="0002-ARM-OMAP4-wakeupgen-remove-duplicate-AUXCOREBOOT-rea.patch"
Content-Disposition: attachment;
	filename="0002-ARM-OMAP4-wakeupgen-remove-duplicate-AUXCOREBOOT-rea.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h6yo26qb0

RnJvbSA0ZTFkYTJhNDRkOTJiOTU2YzNhNzQwZjVhZjZhNDVmZjFjMmRjMjk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2FuLmNvbT4KRGF0ZTog
VHVlLCAxMSBTZXAgMjAxMiAxMjo0MzoxOCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBBUk06
IE9NQVA0OiB3YWtldXBnZW46IHJlbW92ZSBkdXBsaWNhdGUgQVVYQ09SRUJPT1QqCiByZWFkL3dy
aXRlCgpUaGUgd2FrZXVwZ2VuIGNvbnRleHQtc2F2ZSBjb2RlIHJlYWRzIGFuZCBzdG9yZXMgdGhl
IEFVWENPUkVCT09UMCBhbmQKQVVYQ09SRUJPT1QxIHJlZ2lzdGVyIGNvbnRlbnRzIHR3aWNlLiAg
VGhpcyBzZWVtcyBsaWtlIGEgd2FzdGUgb2YKdGltZSwgc28sIHJlbW92ZSB0aGUgZHVwbGljYXRl
cy4KCkFja2VkLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29t
PgpTaWduZWQtb2ZmLWJ5OiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2FuLmNvbT4KLS0tCiBhcmNo
L2FybS9tYWNoLW9tYXAyL29tYXAtd2FrZXVwZ2VuLmMgfCAgICA2IC0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9v
bWFwLXdha2V1cGdlbi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLXdha2V1cGdlbi5jCmlu
ZGV4IGMzNzk1YzIuLjU2N2Y2NzIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21h
cC13YWtldXBnZW4uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAtd2FrZXVwZ2VuLmMK
QEAgLTIzMywxMiArMjMzLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIG9tYXA0X2lycV9zYXZlX2Nv
bnRleHQodm9pZCkKIAlfX3Jhd193cml0ZWwodmFsLCBzYXJfYmFzZSArIEFVWENPUkVCT09UMV9P
RkZTRVQpOwogCiAJLyogU2F2ZSBTeW5jUmVxIGdlbmVyYXRpb24gbG9naWMgKi8KLQl2YWwgPSBf
X3Jhd19yZWFkbCh3YWtldXBnZW5fYmFzZSArIE9NQVBfQVVYX0NPUkVfQk9PVF8wKTsKLQlfX3Jh
d193cml0ZWwodmFsLCBzYXJfYmFzZSArIEFVWENPUkVCT09UMF9PRkZTRVQpOwotCXZhbCA9IF9f
cmF3X3JlYWRsKHdha2V1cGdlbl9iYXNlICsgT01BUF9BVVhfQ09SRV9CT09UXzApOwotCV9fcmF3
X3dyaXRlbCh2YWwsIHNhcl9iYXNlICsgQVVYQ09SRUJPT1QxX09GRlNFVCk7Ci0KLQkvKiBTYXZl
IFN5bmNSZXEgZ2VuZXJhdGlvbiBsb2dpYyAqLwogCXZhbCA9IF9fcmF3X3JlYWRsKHdha2V1cGdl
bl9iYXNlICsgT01BUF9QVE1TWU5DUkVRX01BU0spOwogCV9fcmF3X3dyaXRlbCh2YWwsIHNhcl9i
YXNlICsgUFRNU1lOQ1JFUV9NQVNLX09GRlNFVCk7CiAJdmFsID0gX19yYXdfcmVhZGwod2FrZXVw
Z2VuX2Jhc2UgKyBPTUFQX1BUTVNZTkNSRVFfRU4pOwotLSAKMS43LjkuNQoK
--bcaec54fb4f298daaf04c967e4bf
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP4-wakeupgen-Fix-the-typo-in-AUXCOREBOOT-regi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h6yo2cly1

RnJvbSA2ZTNiOGEzZjZlYzIzMWY1ODhiODYwZDg3YjdhODBmNmJhMzhjZTk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDYgU2VwIDIwMTIgMTE6NTE6MzQgKzA1MzAKU3ViamVjdDogW1BB
VENIIDEvMl0gQVJNOiBPTUFQNDogd2FrZXVwZ2VuOiBGaXggdGhlIHR5cG8gaW4gQVVYQ09SRUJP
T1QKIHJlZ2lzdGVyIHNhdmUKClRoZSB3YWtldXBnZW4gY29udGV4dC1zYXZlIGNvZGUgcmVhZHMg
QVVYQ09SRUJPT1QwIHJlZ2lzdGVyCmluc3RlYWQgb2YgQVVYQ09SRUJPT1QxIHJlZ2lzdGVyIGNv
bnRlbnRzIHdoaWxlIHNhdmluZyBBVVhDT1JFQk9PVDEuCgpGaXggdGhlIHNhbWUuCgpTaWduZWQt
b2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgotLS0K
IGFyY2gvYXJtL21hY2gtb21hcDIvb21hcC13YWtldXBnZW4uYyB8ICAgIDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtb21hcDIvb21hcC13YWtldXBnZW4uYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21h
cC13YWtldXBnZW4uYwppbmRleCAwNWZkZWJmLi5jMzc5NWMyIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL29tYXAtd2FrZXVwZ2VuLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9v
bWFwLXdha2V1cGdlbi5jCkBAIC0yMjksNyArMjI5LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG9t
YXA0X2lycV9zYXZlX2NvbnRleHQodm9pZCkKIAkvKiBTYXZlIEF1eEJvb3QqIHJlZ2lzdGVycyAq
LwogCXZhbCA9IF9fcmF3X3JlYWRsKHdha2V1cGdlbl9iYXNlICsgT01BUF9BVVhfQ09SRV9CT09U
XzApOwogCV9fcmF3X3dyaXRlbCh2YWwsIHNhcl9iYXNlICsgQVVYQ09SRUJPT1QwX09GRlNFVCk7
Ci0JdmFsID0gX19yYXdfcmVhZGwod2FrZXVwZ2VuX2Jhc2UgKyBPTUFQX0FVWF9DT1JFX0JPT1Rf
MCk7CisJdmFsID0gX19yYXdfcmVhZGwod2FrZXVwZ2VuX2Jhc2UgKyBPTUFQX0FVWF9DT1JFX0JP
T1RfMSk7CiAJX19yYXdfd3JpdGVsKHZhbCwgc2FyX2Jhc2UgKyBBVVhDT1JFQk9PVDFfT0ZGU0VU
KTsKIAogCS8qIFNhdmUgU3luY1JlcSBnZW5lcmF0aW9uIGxvZ2ljICovCi0tIAoxLjcuOS41Cgo=
--bcaec54fb4f298daaf04c967e4bf--
