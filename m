From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V4 3/3] ARM: logicpd-torpedo-37xx-devkit-28: Reference new DRM
 panel
Date: Tue,  1 Oct 2019 18:39:20 -0500
Message-ID: <20191001233923.16514-3-aford173@gmail.com>
References: <20191001233923.16514-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191001233923.16514-1-aford173@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, adam.ford@logicpd.com, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

V2l0aCB0aGUgcmVtb3ZhbCBvZiB0aGUgcGFuZWwtZHBpIGZyb20gdGhlIG9tYXAgZHJpdmVycywg
dGhlCkxDRCBubyBsb25nZXIgd29ya3MuICBUaGlzIHBhdGNoIHBvaW50cyB0aGUgZGV2aWNlIHRy
ZWUgdG8KYSBuZXdseSBjcmVhdGVkIHBhbmVsIG5hbWVkICJsb2dpY3BkLHR5cGUyOCIKCkZpeGVz
OiA4YmY0YjE2MjExNzggKCJkcm0vb21hcDogUmVtb3ZlIHBhbmVsLWRwaSBkcml2ZXIiKQoKU2ln
bmVkLW9mZi1ieTogQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+CkFja2VkLWJ5OiBTYW0g
UmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+Ci0tLQpWNDogIE5vIENoYW5nZQpWMzogIE5vIGNo
YW5nZQpWMjogIFJlbW92ZSBsZWdhY3kgJ2xhYmVsJyBmcm9tIGJpbmRpbmcKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9sb2dpY3BkLXRvcnBlZG8tMzd4eC1kZXZraXQtMjguZHRzIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbG9naWNwZC10b3JwZWRvLTM3eHgtZGV2a2l0LTI4LmR0cwppbmRl
eCAwN2FjOTliOWNkYTYuLmNkYjg5YjNlMmE5YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvbG9naWNwZC10b3JwZWRvLTM3eHgtZGV2a2l0LTI4LmR0cworKysgYi9hcmNoL2FybS9ib290
L2R0cy9sb2dpY3BkLXRvcnBlZG8tMzd4eC1kZXZraXQtMjguZHRzCkBAIC0xMSwyMiArMTEsNiBA
QAogI2luY2x1ZGUgImxvZ2ljcGQtdG9ycGVkby0zN3h4LWRldmtpdC5kdHMiCiAKICZsY2QwIHsK
LQotCWxhYmVsID0gIjI4IjsKLQotCXBhbmVsLXRpbWluZyB7Ci0JCWNsb2NrLWZyZXF1ZW5jeSA9
IDw5MDAwMDAwPjsKLQkJaGFjdGl2ZSA9IDw0ODA+OwotCQl2YWN0aXZlID0gPDI3Mj47Ci0JCWhm
cm9udC1wb3JjaCA9IDwzPjsKLQkJaGJhY2stcG9yY2ggPSA8Mj47Ci0JCWhzeW5jLWxlbiA9IDw0
Mj47Ci0JCXZiYWNrLXBvcmNoID0gPDM+OwotCQl2ZnJvbnQtcG9yY2ggPSA8Mj47Ci0JCXZzeW5j
LWxlbiA9IDwxMT47Ci0JCWhzeW5jLWFjdGl2ZSA9IDwxPjsKLQkJdnN5bmMtYWN0aXZlID0gPDE+
OwotCQlkZS1hY3RpdmUgPSA8MT47Ci0JCXBpeGVsY2xrLWFjdGl2ZSA9IDwwPjsKLQl9OworCS8q
IFRvIG1ha2UgaXQgd29yaywgc2V0IENPTkZJR19PTUFQMl9EU1NfTUlOX0ZDS19QRVJfUENLPTQg
Ki8KKwljb21wYXRpYmxlID0gImxvZ2ljcGQsdHlwZTI4IjsKIH07Ci0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
