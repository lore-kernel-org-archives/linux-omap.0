From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V5 3/3] ARM: logicpd-torpedo-37xx-devkit-28: Reference new DRM
 panel
Date: Wed, 16 Oct 2019 08:51:47 -0500
Message-ID: <20191016135147.7743-3-aford173@gmail.com>
References: <20191016135147.7743-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191016135147.7743-1-aford173@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

V2l0aCB0aGUgcmVtb3ZhbCBvZiB0aGUgcGFuZWwtZHBpIGZyb20gdGhlIG9tYXAgZHJpdmVycywg
dGhlCkxDRCBubyBsb25nZXIgd29ya3MuICBUaGlzIHBhdGNoIHBvaW50cyB0aGUgZGV2aWNlIHRy
ZWUgdG8KYSBuZXdseSBjcmVhdGVkIHBhbmVsIG5hbWVkICJsb2dpY3BkLHR5cGUyOCIKCkZpeGVz
OiA4YmY0YjE2MjExNzggKCJkcm0vb21hcDogUmVtb3ZlIHBhbmVsLWRwaSBkcml2ZXIiKQoKU2ln
bmVkLW9mZi1ieTogQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+CkFja2VkLWJ5OiBTYW0g
UmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+Ci0tLQpWNTogIE5vIENoYW5nZQpWNDogIE5vIENo
YW5nZQpWMzogIE5vIGNoYW5nZQpWMjogIFJlbW92ZSBsZWdhY3kgJ2xhYmVsJyBmcm9tIGJpbmRp
bmcKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sb2dpY3BkLXRvcnBlZG8tMzd4eC1k
ZXZraXQtMjguZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbG9naWNwZC10b3JwZWRvLTM3eHgtZGV2
a2l0LTI4LmR0cwppbmRleCAwN2FjOTliOWNkYTYuLmNkYjg5YjNlMmE5YiAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvbG9naWNwZC10b3JwZWRvLTM3eHgtZGV2a2l0LTI4LmR0cworKysg
Yi9hcmNoL2FybS9ib290L2R0cy9sb2dpY3BkLXRvcnBlZG8tMzd4eC1kZXZraXQtMjguZHRzCkBA
IC0xMSwyMiArMTEsNiBAQAogI2luY2x1ZGUgImxvZ2ljcGQtdG9ycGVkby0zN3h4LWRldmtpdC5k
dHMiCiAKICZsY2QwIHsKLQotCWxhYmVsID0gIjI4IjsKLQotCXBhbmVsLXRpbWluZyB7Ci0JCWNs
b2NrLWZyZXF1ZW5jeSA9IDw5MDAwMDAwPjsKLQkJaGFjdGl2ZSA9IDw0ODA+OwotCQl2YWN0aXZl
ID0gPDI3Mj47Ci0JCWhmcm9udC1wb3JjaCA9IDwzPjsKLQkJaGJhY2stcG9yY2ggPSA8Mj47Ci0J
CWhzeW5jLWxlbiA9IDw0Mj47Ci0JCXZiYWNrLXBvcmNoID0gPDM+OwotCQl2ZnJvbnQtcG9yY2gg
PSA8Mj47Ci0JCXZzeW5jLWxlbiA9IDwxMT47Ci0JCWhzeW5jLWFjdGl2ZSA9IDwxPjsKLQkJdnN5
bmMtYWN0aXZlID0gPDE+OwotCQlkZS1hY3RpdmUgPSA8MT47Ci0JCXBpeGVsY2xrLWFjdGl2ZSA9
IDwwPjsKLQl9OworCS8qIFRvIG1ha2UgaXQgd29yaywgc2V0IENPTkZJR19PTUFQMl9EU1NfTUlO
X0ZDS19QRVJfUENLPTQgKi8KKwljb21wYXRpYmxlID0gImxvZ2ljcGQsdHlwZTI4IjsKIH07Ci0t
IAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
