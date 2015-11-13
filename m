From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 0/2] Disable planes on blanked CRTC and enable on
 unblank
Date: Fri, 13 Nov 2015 17:53:13 +0200
Message-ID: <cover.1447428525.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

U2luY2UgZmlyc3QgUkZDIHZlcnNpb246Ci0gQWRkZWQgImRybS9hdG9taWM6IFRyYWNrIGRybV9w
bGFuZSdzIGFjdGl2ZSBzdGF0ZSItcGF0Y2gKCldlIHdvdWxkIG5lZWQgc29tZXRoaW5nIGxpa2Ug
dGhpcyB0byBnZXQgcmlkIG9mZiBPTUFQRFNTIHNvbWV3aGF0Cm1lc3N5IHJ1bnRpbWVfcmVzdW1l
IGNvZGUuIEhvdyBkb2VzIHRoaXMgbG9vaywgY291bGQgdGhpcyBnZW5lcmljCnNvbHV0aW9uIGJl
IHJlZmluZWQgdG8gYmUgYWNjZXB0YWJsZSBmb3IgbWFpbmxpbmUsIG9yIHNob3VsZCB3ZSBzdGFy
dApsb29raW5nIGEgbG9jYWwgc29sdXRpb24gdG8gb21hcGRybT8KCkp5cmkgU2FyaGEgKDIpOgog
IGRybS9hdG9taWM6IFRyYWNrIGRybV9wbGFuZSdzIGFjdGl2ZSBzdGF0ZQogIGRybS9hdG9taWM6
IERpc2FibGUgcGxhbmVzIG9uIGJsYW5rZWQgQ1JUQyBhbmQgZW5hYmxlIG9uIHVuYmxhbmsKCiBk
cml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyB8IDgyICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmVfaGVscGVyLmMg
IHwgMTAgKy0tLS0KIGluY2x1ZGUvZHJtL2RybV9hdG9taWNfaGVscGVyLmggICAgIHwgMzkgKy0t
LS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRlL2RybS9kcm1fY3J0Yy5oICAgICAgICAgICAgICB8ICAy
ICsKIDQgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgNjMgZGVsZXRpb25zKC0pCgot
LSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
