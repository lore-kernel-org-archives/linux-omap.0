From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/9] ARM: dts: omap5-uevm: update SMPS9 settings
Date: Wed, 17 Jul 2013 11:45:31 -0500
Message-ID: <1374079538-19548-3-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374079538-19548-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Y29tbWl0IGUwMGMyN2VmM2I0YzIzZTM5ZDBhNzdiN2M4ZTViZTQ0YzI4MDAxYzcKKEFSTTogZHRz
OiBPTUFQNTogQWRkIFBhbG1hcyBNRkQgbm9kZSBhbmQgcmVndWxhdG9yIG5vZGVzKQppbnRyb2R1
Y2VkIHJlZ3VsYXRvciBlbnRyaWVzIGZvciBPTUFQNXVFVk0uCgpIb3dldmVyLCBUaGUgcmVndWxh
dG9yIGluZm9ybWF0aW9uIGlzIGJhc2VkIG9uIGFuIG9sZGVyIHRlbXBvcmFyeQpwcmUtcHJvZHVj
dGlvbiBib2FyZCB2YXJpYW50IGFuZCBkb2VzIG5vdCByZWZsZWN0IHByb2R1Y3Rpb24gYm9hcmQK
NzUwLTI2MjgtWFhYIGJvYXJkcy4KClNNUFM5IHN1cHBsaWVzIFRXTDYwNDAgb3ZlciBWRERBXzJ2
MV9BVUQuIFRoaXMgcmVndWxhdG9yIG5lZWRzIHRvIGJlCmVuYWJsZWQgb25seSB3aGVuIGF1ZGlv
IGlzIGFjdGl2ZS4gU2luY2UgaXQgZG9lcyBub3QgY29tZSBhY3RpdmUgYnkKZGVmYXVsdCwgaXQg
ZG9lcyBub3QgcmVxdWlyZSAiYWx3YXlzLW9uIiBvciAiYm9vdC1vbiIuCgpSZXBvcnRlZC1ieTog
TWFyYyBKw7x0dG5lciA8bS1qdWV0dG5lckB0aS5jb20+ClNpZ25lZC1vZmYtYnk6IE5pc2hhbnRo
IE1lbm9uIDxubUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUtdWV2bS5kdHMg
fCAgICAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9vbWFwNS11ZXZtLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1
LXVldm0uZHRzCmluZGV4IGI0MzBiOGYuLjY3MDlmMWUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL29tYXA1LXVldm0uZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LXVldm0u
ZHRzCkBAIC0zMzEsOCArMzMxLDYgQEAKIAkJCQkJcmVndWxhdG9yLW5hbWUgPSAic21wczkiOwog
CQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyMTAwMDAwPjsKIAkJCQkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MjEwMDAwMD47Ci0JCQkJCXJlZ3VsYXRvci1hbHdheXMtb247Ci0J
CQkJCXJlZ3VsYXRvci1ib290LW9uOwogCQkJCQl0aSxzbXBzLXJhbmdlID0gPDB4ODA+OwogCQkJ
CX07CiAKLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRldmljZXRyZWUtZGlzY3VzcyBtYWlsaW5nIGxpc3QKZGV2aWNldHJlZS1kaXNj
dXNzQGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2Rl
dmljZXRyZWUtZGlzY3Vzcwo=
