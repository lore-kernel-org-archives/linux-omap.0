From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [ARM][OMAP] TWL4030 IRQ
Date: Wed, 1 Jul 2009 10:33:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5467016@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
	<20090624075756.GA13052@n2100.arm.linux.org.uk>
	<20090629093004.GA2111@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B546698E@dbde02.ent.ti.com>
 <871vp1491d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02B5467016dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58117 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbZGAFDq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Jul 2009 01:03:46 -0400
In-Reply-To: <871vp1491d.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B5467016dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: Wednesday, July 01, 2009 4:36 AM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux;=20
> linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: [ARM][OMAP] TWL4030 IRQ
>=20
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>=20
> > Kevin/Vikram,
> > Can this patch be included on omap_pm branch to check for=20
> any regression?
>=20
> Sure, I have it applied to the PM branch locally, but before I push,
> can you (or Russell) send me a descriptive changelog for this patch.

(Here is the patch with some description.)


>From 67d399fd88629f37b8debea1aa51bf20ff8957f6 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Wed, 1 Jul 2009 10:31:17 +0530
Subject: [PATCH] ARM: OMAP: TWL4030 IRQ

The TWL4030 IRQ handler has a bug which leads to spinlock lock-up. It is
calling the 'unmask' function in a process context. The mask/unmask/ack
functions are only designed to be called from the IRQ handler code,
or the proper API interfaces found in linux/interrupt.h.

Also there is no need to have IRQ chaining mechanism. The right way to
handle this is to claim the parent interrupt as a standard interrupt
and arrange for handle_twl4030_pih to take care of the rest of the devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/mfd/twl4030-irq.c |   54 ++++++++++++++++++++---------------------=
----
 1 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index aca2670..e30e7bc 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -180,14 +180,9 @@ static struct completion irq_event;
 static int twl4030_irq_thread(void *data)
 {
 	long irq =3D (long)data;
-	struct irq_desc *desc =3D irq_to_desc(irq);
 	static unsigned i2c_errors;
 	static const unsigned max_i2c_errors =3D 100;
=20
-	if (!desc) {
-		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
-		return -EINVAL;
-	}
=20
 	current->flags |=3D PF_NOFREEZE;
=20
@@ -240,7 +235,7 @@ static int twl4030_irq_thread(void *data)
 		}
 		local_irq_enable();
=20
-		desc->chip->unmask(irq);
+		enable_irq(irq);
 	}
=20
 	return 0;
@@ -255,23 +250,12 @@ static int twl4030_irq_thread(void *data)
  * thread.  All we do here is acknowledge and mask the interrupt and wakeu=
p
  * the kernel thread.
  */
-static void handle_twl4030_pih(unsigned int irq, irq_desc_t *desc)
+static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 {
 	/* Acknowledge, clear *AND* mask the interrupt... */
-	desc->chip->ack(irq);
-	complete(&irq_event);
-}
-
-static struct task_struct *start_twl4030_irq_thread(long irq)
-{
-	struct task_struct *thread;
-
-	init_completion(&irq_event);
-	thread =3D kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-irq");
-	if (!thread)
-		pr_err("twl4030: could not create irq %ld thread!\n", irq);
-
-	return thread;
+	disable_irq_nosync(irq);
+	complete(devid);
+	return IRQ_HANDLED;
 }
=20
 /*----------------------------------------------------------------------*/
@@ -734,18 +718,28 @@ int twl_init_irq(int irq_num, unsigned irq_base, unsi=
gned irq_end)
 	}
=20
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-	task =3D start_twl4030_irq_thread(irq_num);
-	if (!task) {
-		pr_err("twl4030: irq thread FAIL\n");
-		status =3D -ESRCH;
-		goto fail;
-	}
=20
-	set_irq_data(irq_num, task);
-	set_irq_chained_handler(irq_num, handle_twl4030_pih);
=20
-	return status;
+	init_completion(&irq_event);
=20
+	status =3D request_irq(irq_num, handle_twl4030_pih, IRQF_DISABLED,
+				"TWL4030-PIH", &irq_event);
+	if (status < 0) {
+		pr_err("twl4030: could not claim irq%d: %d\n", irq_num, status);
+		goto fail_rqirq;
+	}
+
+	task =3D kthread_run(twl4030_irq_thread, (void *)irq_num, "twl4030-irq");
+	if (IS_ERR(task)) {
+		pr_err("twl4030: could not create irq %d thread!\n", irq_num);
+		status =3D PTR_ERR(task);
+		goto fail_kthread;
+	}
+	return status;
+fail_kthread:
+	free_irq(irq_num, &irq_event);
+fail_rqirq:
+	/* clean up twl4030_sih_setup */
 fail:
 	for (i =3D irq_base; i < irq_end; i++)
 		set_irq_chip_and_handler(i, NULL, NULL);
--=20
1.5.4.7


Regards,
Santosh
 =

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B5467016dbde02enttico_
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-TWL4030-IRQ.patch"
Content-Description: 0001-ARM-OMAP-TWL4030-IRQ.patch
Content-Disposition: attachment; filename="0001-ARM-OMAP-TWL4030-IRQ.patch";
	size=3572; creation-date="Wed, 01 Jul 2009 10:35:38 GMT";
	modification-date="Wed, 01 Jul 2009 10:35:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2N2QzOTlmZDg4NjI5ZjM3YjhkZWJlYTFhYTUxYmYyMGZmODk1N2Y2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtLmxpbnV4Lm9y
Zy51az4KRGF0ZTogV2VkLCAxIEp1bCAyMDA5IDEwOjMxOjE3ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBUV0w0MDMwIElSUQoKVGhlIFRXTDQwMzAgSVJRIGhhbmRsZXIgaGFzIGEg
YnVnIHdoaWNoIGxlYWRzIHRvIHNwaW5sb2NrIGxvY2stdXAuIEl0IGlzCmNhbGxpbmcgdGhlICd1
bm1hc2snIGZ1bmN0aW9uIGluIGEgcHJvY2VzcyBjb250ZXh0LiA6VGhlIG1hc2svdW5tYXNrL2Fj
awpmdW5jdGlvbnMgYXJlIG9ubHkgZGVzaWduZWQgdG8gYmUgY2FsbGVkIGZyb20gdGhlIElSUSBo
YW5kbGVyIGNvZGUsCm9yIHRoZSBwcm9wZXIgQVBJIGludGVyZmFjZXMgZm91bmQgaW4gbGludXgv
aW50ZXJydXB0LmguCgpBbHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGF2ZSBJUlEgY2hhaW5pbmcg
bWVjaGFuaXNtLiBUaGUgcmlnaHQgd2F5IHRvCmhhbmRsZSB0aGlzIGlzIHRvIGNsYWltIHRoZSBw
YXJlbnQgaW50ZXJydXB0IGFzIGEgc3RhbmRhcmQgaW50ZXJydXB0CmFuZCBhcnJhbmdlIGZvciBo
YW5kbGVfdHdsNDAzMF9waWggdG8gdGFrZSBjYXJlIG9mIHRoZSByZXN0IG9mIHRoZSBkZXZpY2Vz
LgoKU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybS5saW51eC5vcmcu
dWs+ClRlc3RlZC1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNhbnRvc2guc2hpbGlta2FyQHRpLmNv
bT4KLS0tCiBkcml2ZXJzL21mZC90d2w0MDMwLWlycS5jIHwgICA1NCArKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvdHdsNDAz
MC1pcnEuYyBiL2RyaXZlcnMvbWZkL3R3bDQwMzAtaXJxLmMKaW5kZXggYWNhMjY3MC4uZTMwZTdi
YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZmQvdHdsNDAzMC1pcnEuYworKysgYi9kcml2ZXJzL21m
ZC90d2w0MDMwLWlycS5jCkBAIC0xODAsMTQgKzE4MCw5IEBAIHN0YXRpYyBzdHJ1Y3QgY29tcGxl
dGlvbiBpcnFfZXZlbnQ7CiBzdGF0aWMgaW50IHR3bDQwMzBfaXJxX3RocmVhZCh2b2lkICpkYXRh
KQogewogCWxvbmcgaXJxID0gKGxvbmcpZGF0YTsKLQlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MgPSBp
cnFfdG9fZGVzYyhpcnEpOwogCXN0YXRpYyB1bnNpZ25lZCBpMmNfZXJyb3JzOwogCXN0YXRpYyBj
b25zdCB1bnNpZ25lZCBtYXhfaTJjX2Vycm9ycyA9IDEwMDsKIAotCWlmICghZGVzYykgewotCQlw
cl9lcnIoInR3bDQwMzA6IEludmFsaWQgSVJROiAlbGRcbiIsIGlycSk7Ci0JCXJldHVybiAtRUlO
VkFMOwotCX0KIAogCWN1cnJlbnQtPmZsYWdzIHw9IFBGX05PRlJFRVpFOwogCkBAIC0yNDAsNyAr
MjM1LDcgQEAgc3RhdGljIGludCB0d2w0MDMwX2lycV90aHJlYWQodm9pZCAqZGF0YSkKIAkJfQog
CQlsb2NhbF9pcnFfZW5hYmxlKCk7CiAKLQkJZGVzYy0+Y2hpcC0+dW5tYXNrKGlycSk7CisJCWVu
YWJsZV9pcnEoaXJxKTsKIAl9CiAKIAlyZXR1cm4gMDsKQEAgLTI1NSwyMyArMjUwLDEyIEBAIHN0
YXRpYyBpbnQgdHdsNDAzMF9pcnFfdGhyZWFkKHZvaWQgKmRhdGEpCiAgKiB0aHJlYWQuICBBbGwg
d2UgZG8gaGVyZSBpcyBhY2tub3dsZWRnZSBhbmQgbWFzayB0aGUgaW50ZXJydXB0IGFuZCB3YWtl
dXAKICAqIHRoZSBrZXJuZWwgdGhyZWFkLgogICovCi1zdGF0aWMgdm9pZCBoYW5kbGVfdHdsNDAz
MF9waWgodW5zaWduZWQgaW50IGlycSwgaXJxX2Rlc2NfdCAqZGVzYykKK3N0YXRpYyBpcnFyZXR1
cm5fdCBoYW5kbGVfdHdsNDAzMF9waWgoaW50IGlycSwgdm9pZCAqZGV2aWQpCiB7CiAJLyogQWNr
bm93bGVkZ2UsIGNsZWFyICpBTkQqIG1hc2sgdGhlIGludGVycnVwdC4uLiAqLwotCWRlc2MtPmNo
aXAtPmFjayhpcnEpOwotCWNvbXBsZXRlKCZpcnFfZXZlbnQpOwotfQotCi1zdGF0aWMgc3RydWN0
IHRhc2tfc3RydWN0ICpzdGFydF90d2w0MDMwX2lycV90aHJlYWQobG9uZyBpcnEpCi17Ci0Jc3Ry
dWN0IHRhc2tfc3RydWN0ICp0aHJlYWQ7Ci0KLQlpbml0X2NvbXBsZXRpb24oJmlycV9ldmVudCk7
Ci0JdGhyZWFkID0ga3RocmVhZF9ydW4odHdsNDAzMF9pcnFfdGhyZWFkLCAodm9pZCAqKWlycSwg
InR3bDQwMzAtaXJxIik7Ci0JaWYgKCF0aHJlYWQpCi0JCXByX2VycigidHdsNDAzMDogY291bGQg
bm90IGNyZWF0ZSBpcnEgJWxkIHRocmVhZCFcbiIsIGlycSk7Ci0KLQlyZXR1cm4gdGhyZWFkOwor
CWRpc2FibGVfaXJxX25vc3luYyhpcnEpOworCWNvbXBsZXRlKGRldmlkKTsKKwlyZXR1cm4gSVJR
X0hBTkRMRUQ7CiB9CiAKIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCkBAIC03MzQsMTggKzcxOCwyOCBAQCBp
bnQgdHdsX2luaXRfaXJxKGludCBpcnFfbnVtLCB1bnNpZ25lZCBpcnFfYmFzZSwgdW5zaWduZWQg
aXJxX2VuZCkKIAl9CiAKIAkvKiBpbnN0YWxsIGFuIGlycSBoYW5kbGVyIHRvIGRlbXVsdGlwbGV4
IHRoZSBUV0w0MDMwIGludGVycnVwdCAqLwotCXRhc2sgPSBzdGFydF90d2w0MDMwX2lycV90aHJl
YWQoaXJxX251bSk7Ci0JaWYgKCF0YXNrKSB7Ci0JCXByX2VycigidHdsNDAzMDogaXJxIHRocmVh
ZCBGQUlMXG4iKTsKLQkJc3RhdHVzID0gLUVTUkNIOwotCQlnb3RvIGZhaWw7Ci0JfQogCi0Jc2V0
X2lycV9kYXRhKGlycV9udW0sIHRhc2spOwotCXNldF9pcnFfY2hhaW5lZF9oYW5kbGVyKGlycV9u
dW0sIGhhbmRsZV90d2w0MDMwX3BpaCk7CiAKLQlyZXR1cm4gc3RhdHVzOworCWluaXRfY29tcGxl
dGlvbigmaXJxX2V2ZW50KTsKIAorCXN0YXR1cyA9IHJlcXVlc3RfaXJxKGlycV9udW0sIGhhbmRs
ZV90d2w0MDMwX3BpaCwgSVJRRl9ESVNBQkxFRCwKKwkJCQkiVFdMNDAzMC1QSUgiLCAmaXJxX2V2
ZW50KTsKKwlpZiAoc3RhdHVzIDwgMCkgeworCQlwcl9lcnIoInR3bDQwMzA6IGNvdWxkIG5vdCBj
bGFpbSBpcnElZDogJWRcbiIsIGlycV9udW0sIHN0YXR1cyk7CisJCWdvdG8gZmFpbF9ycWlycTsK
Kwl9CisKKwl0YXNrID0ga3RocmVhZF9ydW4odHdsNDAzMF9pcnFfdGhyZWFkLCAodm9pZCAqKWly
cV9udW0sICJ0d2w0MDMwLWlycSIpOworCWlmIChJU19FUlIodGFzaykpIHsKKwkJcHJfZXJyKCJ0
d2w0MDMwOiBjb3VsZCBub3QgY3JlYXRlIGlycSAlZCB0aHJlYWQhXG4iLCBpcnFfbnVtKTsKKwkJ
c3RhdHVzID0gUFRSX0VSUih0YXNrKTsKKwkJZ290byBmYWlsX2t0aHJlYWQ7CisJfQorCXJldHVy
biBzdGF0dXM7CitmYWlsX2t0aHJlYWQ6CisJZnJlZV9pcnEoaXJxX251bSwgJmlycV9ldmVudCk7
CitmYWlsX3JxaXJxOgorCS8qIGNsZWFuIHVwIHR3bDQwMzBfc2loX3NldHVwICovCiBmYWlsOgog
CWZvciAoaSA9IGlycV9iYXNlOyBpIDwgaXJxX2VuZDsgaSsrKQogCQlzZXRfaXJxX2NoaXBfYW5k
X2hhbmRsZXIoaSwgTlVMTCwgTlVMTCk7Ci0tIAoxLjUuNC43Cgo=

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02B5467016dbde02enttico_--
