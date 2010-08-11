From: Gregory CLEMENT <gclement00@gmail.com>
Subject: [PATCH 1/2] spi: Add hook on suspend/resume for spi master
Date: Wed, 11 Aug 2010 16:43:36 +0200
Message-ID: <AANLkTik8F_Cy3q=E+oDCym=eGTuajbavPqtoLMfxoJWi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e65bc156535654048d8d4611
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50348 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0HKOni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 10:43:38 -0400
Received: by fxm13 with SMTP id 13so147283fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 07:43:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>
Cc: linux-omap <linux-omap@vger.kernel.org>, Gregory CLEMENT <gclement00@gmail.com>

--0016e65bc156535654048d8d4611
Content-Type: text/plain; charset=ISO-8859-1

Some spi master need to do some action when system is going to suspend
or when it will be resumed.
Spi driver offer possibility to handle suspend and resume only for device.
Spi master will do its suspend actions after the devices and will do
its resume action before the devices.

Signed-off-by: Gregory CLEMENT <gclement00@gmail.com>
---
 drivers/spi/spi.c       |   15 ++++++++++++++-
 include/linux/spi/spi.h |    4 +++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bb1b88..fe8140e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -17,7 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -106,6 +105,11 @@ static int spi_suspend(struct device *dev,
pm_message_t message)
 {
 	int			value = 0;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
+	struct spi_device *spi_dev = to_spi_device(dev);
+	struct spi_master *master = NULL;
+
+	if (spi_dev)
+		master = spi_dev->master;

 	/* suspend will stop irqs and dma; no more i/o */
 	if (drv) {
@@ -114,6 +118,9 @@ static int spi_suspend(struct device *dev,
pm_message_t message)
 		else
 			dev_dbg(dev, "... can't suspend\n");
 	}
+	if (master && master->suspend )
+		master->suspend(spi_dev);
+
 	return value;
 }

@@ -121,7 +128,11 @@ static int spi_resume(struct device *dev)
 {
 	int			value = 0;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
+	struct spi_device *spi_dev = to_spi_device(dev);
+	struct spi_master *master = NULL;

+	if (spi_dev)
+		master = spi_dev->master;
 	/* resume may restart the i/o queue */
 	if (drv) {
 		if (drv->resume)
@@ -129,6 +140,8 @@ static int spi_resume(struct device *dev)
 		else
 			dev_dbg(dev, "... can't resume\n");
 	}
+	if (master && master->resume )
+		master->resume(spi_dev);
 	return value;
 }

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af56071..2483a1d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -293,7 +293,9 @@ struct spi_master {
 						struct spi_message *mesg);

 	/* called on release() to free memory provided by spi_master */
-	void			(*cleanup)(struct spi_device *spi);
+        void			(*cleanup)(struct spi_device *spi);
+     void (*suspend)(struct spi_device *spi);
+     void (*resume)(struct spi_device *spi);
 };

 static inline void *spi_master_get_devdata(struct spi_master *master)

--0016e65bc156535654048d8d4611
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-spi-Add-hook-on-suspend-resume-for-spi-master.patch"
Content-Disposition: attachment;
	filename="0001-spi-Add-hook-on-suspend-resume-for-spi-master.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf14ea1f9cd74bbb_0.1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS5jIGIvZHJpdmVycy9zcGkvc3BpLmMNCmluZGV4
IDFiYjFiODguLmZlODE0MGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGkuYw0KKysrIGIv
ZHJpdmVycy9zcGkvc3BpLmMNCkBAIC0xNyw3ICsxNyw2IEBADQogICogYWxvbmcgd2l0aCB0aGlz
IHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUNCiAgKiBGb3VuZGF0
aW9uLCBJbmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4NCiAgKi8N
Ci0NCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RldmljZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQpAQCAtMTA2LDYgKzEwNSwxMSBAQCBzdGF0aWMg
aW50IHNwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IG1lc3NhZ2Up
DQogew0KIAlpbnQJCQl2YWx1ZSA9IDA7DQogCXN0cnVjdCBzcGlfZHJpdmVyCSpkcnYgPSB0b19z
cGlfZHJpdmVyKGRldi0+ZHJpdmVyKTsNCisJc3RydWN0IHNwaV9kZXZpY2UgKnNwaV9kZXYgPSB0
b19zcGlfZGV2aWNlKGRldik7DQorCXN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIgPSBOVUxMOw0K
Kw0KKwlpZiAoc3BpX2RldikNCisJCW1hc3RlciA9IHNwaV9kZXYtPm1hc3RlcjsNCiANCiAJLyog
c3VzcGVuZCB3aWxsIHN0b3AgaXJxcyBhbmQgZG1hOyBubyBtb3JlIGkvbyAqLw0KIAlpZiAoZHJ2
KSB7DQpAQCAtMTE0LDYgKzExOCw5IEBAIHN0YXRpYyBpbnQgc3BpX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2LCBwbV9tZXNzYWdlX3QgbWVzc2FnZSkNCiAJCWVsc2UNCiAJCQlkZXZfZGJnKGRl
diwgIi4uLiBjYW4ndCBzdXNwZW5kXG4iKTsNCiAJfQ0KKwlpZiAobWFzdGVyICYmIG1hc3Rlci0+
c3VzcGVuZCApDQorCQltYXN0ZXItPnN1c3BlbmQoc3BpX2Rldik7DQorDQogCXJldHVybiB2YWx1
ZTsNCiB9DQogDQpAQCAtMTIxLDcgKzEyOCwxMSBAQCBzdGF0aWMgaW50IHNwaV9yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJaW50CQkJdmFsdWUgPSAwOw0KIAlzdHJ1Y3Qgc3BpX2Ry
aXZlcgkqZHJ2ID0gdG9fc3BpX2RyaXZlcihkZXYtPmRyaXZlcik7DQorCXN0cnVjdCBzcGlfZGV2
aWNlICpzcGlfZGV2ID0gdG9fc3BpX2RldmljZShkZXYpOw0KKwlzdHJ1Y3Qgc3BpX21hc3RlciAq
bWFzdGVyID0gTlVMTDsNCiANCisJaWYgKHNwaV9kZXYpDQorCQltYXN0ZXIgPSBzcGlfZGV2LT5t
YXN0ZXI7DQogCS8qIHJlc3VtZSBtYXkgcmVzdGFydCB0aGUgaS9vIHF1ZXVlICovDQogCWlmIChk
cnYpIHsNCiAJCWlmIChkcnYtPnJlc3VtZSkNCkBAIC0xMjksNiArMTQwLDggQEAgc3RhdGljIGlu
dCBzcGlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJCWVsc2UNCiAJCQlkZXZfZGJnKGRl
diwgIi4uLiBjYW4ndCByZXN1bWVcbiIpOw0KIAl9DQorCWlmIChtYXN0ZXIgJiYgbWFzdGVyLT5y
ZXN1bWUgKQ0KKwkJbWFzdGVyLT5yZXN1bWUoc3BpX2Rldik7DQogCXJldHVybiB2YWx1ZTsNCiB9
DQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zcGkvc3BpLmggYi9pbmNsdWRlL2xpbnV4
L3NwaS9zcGkuaA0KaW5kZXggYWY1NjA3MS4uMjQ4M2ExZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
bGludXgvc3BpL3NwaS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaA0KQEAgLTI5Myw3
ICsyOTMsOSBAQCBzdHJ1Y3Qgc3BpX21hc3RlciB7DQogCQkJCQkJc3RydWN0IHNwaV9tZXNzYWdl
ICptZXNnKTsNCiANCiAJLyogY2FsbGVkIG9uIHJlbGVhc2UoKSB0byBmcmVlIG1lbW9yeSBwcm92
aWRlZCBieSBzcGlfbWFzdGVyICovDQotCXZvaWQJCQkoKmNsZWFudXApKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGkpOw0KKyAgICAgICAgdm9pZAkJCSgqY2xlYW51cCkoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSk7DQorICAgICB2b2lkICgqc3VzcGVuZCkoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSk7DQor
ICAgICB2b2lkICgqcmVzdW1lKShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKTsNCiB9Ow0KIA0KIHN0
YXRpYyBpbmxpbmUgdm9pZCAqc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShzdHJ1Y3Qgc3BpX21hc3Rl
ciAqbWFzdGVyKQ0K
--0016e65bc156535654048d8d4611--
