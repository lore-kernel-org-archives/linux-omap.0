From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] memory: omap-gpmc: dump "before" state before first
 modification
Date: Wed, 7 Oct 2015 10:37:18 +0300
Message-ID: <5614CBAE.8030603@ti.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

T24gMDYvMTAvMTUgMjM6MDcsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+IFdoZW4gZ3BtY19j
c19zaG93X3RpbWluZ3MgaXMgY2FsbGVkIGluIGdwbWNfY3Nfc2V0X3RpbWluZ3MoKQo+IGdwbWNf
Y3NfcHJvZ3JhbV9zZXR0aW5ncygpIHdhcyBhbHJlYWR5IHJ1biB3aGljaCBtb2RpZmllcyB0aGUg
Q09ORklHMQo+IHJlZ2lzdGVyLiBTbyB0byBiZSBtb3JlIHVzZWZ1bCBkbyB0aGUgImJlZm9yZSIg
ZHVtcCBlYXJsaWVyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CgpBY2tlZC1ieTogUm9nZXIgUXVhZHJvcyA8cm9n
ZXJxQHRpLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvbWVtb3J5L29tYXAtZ3BtYy5jIHwgMiArLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkvb21hcC1ncG1jLmMgYi9kcml2ZXJzL21lbW9yeS9vbWFw
LWdwbWMuYwo+IGluZGV4IDMyYWMwNDlmMmJjNC4uNjUxNWRmYzJiODA1IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvbWVtb3J5L29tYXAtZ3BtYy5jCj4gKysrIGIvZHJpdmVycy9tZW1vcnkvb21hcC1n
cG1jLmMKPiBAQCAtNjk2LDcgKzY5Niw2IEBAIGludCBncG1jX2NzX3NldF90aW1pbmdzKGludCBj
cywgY29uc3Qgc3RydWN0IGdwbWNfdGltaW5ncyAqdCwKPiAgCWludCBkaXY7Cj4gIAl1MzIgbDsK
PiAgCj4gLQlncG1jX2NzX3Nob3dfdGltaW5ncyhjcywgImJlZm9yZSBncG1jX2NzX3NldF90aW1p
bmdzIik7Cj4gIAlkaXYgPSBncG1jX2NhbGNfZGl2aWRlcih0LT5zeW5jX2Nsayk7Cj4gIAlpZiAo
ZGl2IDwgMCkKPiAgCQlyZXR1cm4gZGl2Owo+IEBAIC0xOTg4LDYgKzE5ODcsNyBAQCBzdGF0aWMg
aW50IGdwbWNfcHJvYmVfZ2VuZXJpY19jaGlsZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
LAo+ICAJaWYgKHJldCA8IDApCj4gIAkJZ290byBlcnI7Cj4gIAo+ICsJZ3BtY19jc19zaG93X3Rp
bWluZ3MoY3MsICJiZWZvcmUgZ3BtY19jc19wcm9ncmFtX3NldHRpbmdzIik7Cj4gIAlyZXQgPSBn
cG1jX2NzX3Byb2dyYW1fc2V0dGluZ3MoY3MsICZncG1jX3MpOwo+ICAJaWYgKHJldCA8IDApCj4g
IAkJZ290byBlcnI7Cj4gCgpjaGVlcnMsCi1yb2dlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
