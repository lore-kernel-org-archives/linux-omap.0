From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 4/9] drm/tilcdc: tfp410: fix dangling sysfs connector node
Date: Sat,  7 Jun 2014 00:02:03 -0300
Message-ID: <1402110128-30471-5-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

QWRkIGEgZHJtX3N5c2ZzX2Nvbm5lY3Rvcl9yZW1vdmUgY2FsbCB3aGVuIHdlIGRlc3Ryb3kgdGhl
IHBhbmVsIHRvIG1ha2UKc3VyZSB0aGUgY29ubmVjdG9yIG5vZGUgaW4gc3lzZnMgZ2V0cyBkZWxl
dGVkLgoKVGhpcyBpcyByZXF1aXJlZCBmb3IgcHJvcGVyIHVubG9hZCBhbmQgcmUtbG9hZCBvZiB0
aGlzIGRyaXZlciwgb3RoZXJ3aXNlCndlIHdpbGwgZ2V0IGEgd2FybmluZyBhYm91dCBhIGR1cGxp
Y2F0ZSBmaWxlbmFtZSBpbiBzeXNmcy4KClNpZ25lZC1vZmYtYnk6IEd1aWRvIE1hcnTDrW5leiA8
Z3VpZG9AdmFuZ3VhcmRpYXN1ci5jb20uYXI+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCi0t
LQogZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfdGZwNDEwLmMgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aWxj
ZGMvdGlsY2RjX3RmcDQxMC5jIGIvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfdGZwNDEw
LmMKaW5kZXggYzM4YjU2Yi4uY2U3NWFjOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rp
bGNkYy90aWxjZGNfdGZwNDEwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNf
dGZwNDEwLmMKQEAgLTE2Nyw2ICsxNjcsNyBAQCBzdHJ1Y3QgdGZwNDEwX2Nvbm5lY3RvciB7CiBz
dGF0aWMgdm9pZCB0ZnA0MTBfY29ubmVjdG9yX2Rlc3Ryb3koc3RydWN0IGRybV9jb25uZWN0b3Ig
KmNvbm5lY3RvcikKIHsKIAlzdHJ1Y3QgdGZwNDEwX2Nvbm5lY3RvciAqdGZwNDEwX2Nvbm5lY3Rv
ciA9IHRvX3RmcDQxMF9jb25uZWN0b3IoY29ubmVjdG9yKTsKKwlkcm1fc3lzZnNfY29ubmVjdG9y
X3JlbW92ZShjb25uZWN0b3IpOwogCWRybV9jb25uZWN0b3JfY2xlYW51cChjb25uZWN0b3IpOwog
CWtmcmVlKHRmcDQxMF9jb25uZWN0b3IpOwogfQotLSAKMi4wLjAucmMyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
