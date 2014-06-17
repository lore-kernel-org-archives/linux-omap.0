From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH/RESEND 4/9] drm/tilcdc: tfp410: fix dangling sysfs connector
 node
Date: Tue, 17 Jun 2014 11:17:06 -0300
Message-ID: <1403014631-18072-5-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

QWRkIGEgZHJtX3N5c2ZzX2Nvbm5lY3Rvcl9yZW1vdmUgY2FsbCB3aGVuIHdlIGRlc3Ryb3kgdGhl
IHBhbmVsIHRvIG1ha2UKc3VyZSB0aGUgY29ubmVjdG9yIG5vZGUgaW4gc3lzZnMgZ2V0cyBkZWxl
dGVkLgoKVGhpcyBpcyByZXF1aXJlZCBmb3IgcHJvcGVyIHVubG9hZCBhbmQgcmUtbG9hZCBvZiB0
aGlzIGRyaXZlciwgb3RoZXJ3aXNlCndlIHdpbGwgZ2V0IGEgd2FybmluZyBhYm91dCBhIGR1cGxp
Y2F0ZSBmaWxlbmFtZSBpbiBzeXNmcy4KClNpZ25lZC1vZmYtYnk6IEd1aWRvIE1hcnTDrW5leiA8
Z3VpZG9AdmFuZ3VhcmRpYXN1ci5jb20uYXI+CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4g
I3YzLjkrCi0tLQogZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfdGZwNDEwLmMgfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS90aWxjZGMvdGlsY2RjX3RmcDQxMC5jIGIvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxj
ZGNfdGZwNDEwLmMKaW5kZXggYzM4YjU2Yi4uY2U3NWFjOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3RpbGNkYy90aWxjZGNfdGZwNDEwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3RpbGNk
Yy90aWxjZGNfdGZwNDEwLmMKQEAgLTE2Nyw2ICsxNjcsNyBAQCBzdHJ1Y3QgdGZwNDEwX2Nvbm5l
Y3RvciB7CiBzdGF0aWMgdm9pZCB0ZnA0MTBfY29ubmVjdG9yX2Rlc3Ryb3koc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3RvcikKIHsKIAlzdHJ1Y3QgdGZwNDEwX2Nvbm5lY3RvciAqdGZwNDEw
X2Nvbm5lY3RvciA9IHRvX3RmcDQxMF9jb25uZWN0b3IoY29ubmVjdG9yKTsKKwlkcm1fc3lzZnNf
Y29ubmVjdG9yX3JlbW92ZShjb25uZWN0b3IpOwogCWRybV9jb25uZWN0b3JfY2xlYW51cChjb25u
ZWN0b3IpOwogCWtmcmVlKHRmcDQxMF9jb25uZWN0b3IpOwogfQotLSAKMi4wLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
