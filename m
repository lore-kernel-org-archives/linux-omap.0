From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: [PATCH] ARM: OMAP: Remove unnecessary memset in dsp task.c
Date: Mon, 4 Dec 2006 23:57:26 +0530
Message-ID: <3a5b1be00612041027h2e3cefefwf140897ee1bb4717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_30247_30593440.1165256846095"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_30247_30593440.1165256846095
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There is much more duplicated code can be removed in task.c by using
already available wait_for_event_{un}interruptible_{timeout},
prepare_wait, finish_wait etc calls. What do you say?

-- 
---Komal Shah
http://komalshah.blogspot.com

------=_Part_30247_30593440.1165256846095
Content-Type: text/plain;
	name=0001-ARM-OMAP-Remove-unnecessary-memset-in-dsp-task.c.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evb7qg2y
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Remove-unnecessary-memset-in-dsp-task.c.txt"

RnJvbSA0ZTg5Y2VhNTVmN2FhMjE2MmE3NTQxMTA2NDQzZWVmNjA5NjY2ZWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9vLmNv
bT4KRGF0ZTogTW9uLCA0IERlYyAyMDA2IDIzOjUyOjExICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
QVJNOiBPTUFQOiBSZW1vdmUgdW5uZWNlc3NhcnkgbWVtc2V0IGluIGRzcCB0YXNrLmMKCi0gYW5k
IHJlbW92ZSBjb21tZW50ZWQgInN0cnVjdCBkZXZpY2VfZHJpdmVyIgoKU2lnbmVkLW9mZi1ieTog
S29tYWwgU2hhaCA8a29tYWxfc2hhaDgwMjAwM0B5YWhvby5jb20+Ci0tLQogYXJjaC9hcm0vcGxh
dC1vbWFwL2RzcC90YXNrLmMgfCAgICA0IC0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9k
c3AvdGFzay5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC90YXNrLmMKaW5kZXggN2ZjYzA2YS4u
ODA3YzQwOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC90YXNrLmMKKysrIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL2RzcC90YXNrLmMKQEAgLTEwOCw3ICsxMDgsNiBAQCBzdHJ1Y3Qg
cmN2ZHRfYmtfc3RydWN0IHsKIAogc3RydWN0IHRhc2tkZXYgewogCXN0cnVjdCBidXNfdHlwZSAq
YnVzOwotLy8Jc3RydWN0IGRldmljZV9kcml2ZXIgKmRyaXZlcjsKIAlzdHJ1Y3QgZGV2aWNlIGRl
djsJLyogR2VuZXJpYyBkZXZpY2UgaW50ZXJmYWNlICovCiAKIAlsb25nIHN0YXRlOwpAQCAtNTY0
LDkgKzU2Myw2IEBAIGludCBkc3BfdGFza19jb25maWdfYWxsKHU4IG4pCiAJc3RydWN0IGRzcHRh
c2sgKnRhc2toZWFwOwogCXNpemVfdCBkZXZoZWFwc3osIHRhc2toZWFwc3o7CiAKLQltZW1zZXQo
dGFza2RldiwgMCwgc2l6ZW9mKHZvaWQgKikgKiBUQVNLREVWX01BWCk7Ci0JbWVtc2V0KGRzcHRh
c2ssIDAsIHNpemVvZih2b2lkICopICogVEFTS0RFVl9NQVgpOwotCiAJcHJpbnRrKEtFUk5fSU5G
TyAib21hcGRzcDogZm91bmQgJWQgdGFzayhzKVxuIiwgbik7CiAJaWYgKG4gPT0gMCkKIAkJcmV0
dXJuIDA7Ci0tIAoxLjQuMy40Lmc4MmNjCgo=
------=_Part_30247_30593440.1165256846095
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_30247_30593440.1165256846095--
