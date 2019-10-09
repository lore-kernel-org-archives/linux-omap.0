From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] ARM: OMAP2+: make dra7xx_sha0_hwmod static
Date: Wed,  9 Oct 2019 09:56:45 +0100
Message-ID: <20191009085646.21755-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Ben Dooks <ben.dooks@codethink.co.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

VGhlIGRyYTd4eF9zaGEwX2h3bW9kIG9iamVjdCBpcyBub3QgZXhwb3J0ZWQgb3V0c2lkZSBvZgpv
bWFwX2h3bW9kXzd4eF9kYXRhLiBzbyBtYWtlIGl0IHN0YXRpYyB0byBhdm9pZCB0aGUKZm9sbG93
aW5nIHdhcm5pbmc6CgphcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfN3h4X2RhdGEuYzo2
ODY6MTk6IHdhcm5pbmc6IHN5bWJvbCAnZHJhN3h4X3NoYTBfaHdtb2QnIHdhcyBub3QgZGVjbGFy
ZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/CgpTaWduZWQtb2ZmLWJ5OiBCZW4gRG9va3MgPGJlbi5k
b29rc0Bjb2RldGhpbmsuY28udWs+Ci0tLQpDYzogIkJlbm/DrnQgQ291c3NvbiIgPGJjb3Vzc29u
QGJheWxpYnJlLmNvbT4KQ2M6IFBhdWwgV2FsbXNsZXkgPHBhdWxAcHdzYW4uY29tPgpDYzogVG9u
eSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwu
b3JnCi0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzd4eF9kYXRhLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfN3h4X2RhdGEuYyBiL2FyY2gvYXJt
L21hY2gtb21hcDIvb21hcF9od21vZF83eHhfZGF0YS5jCmluZGV4IGU1YmQ1NDlkMmE1ZS4uYmQz
OTJkNTkzODJiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfN3h4
X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfN3h4X2RhdGEuYwpA
QCAtNjgzLDcgKzY4Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZF9jbGFzcyBkcmE3eHhf
c2hhMF9od21vZF9jbGFzcyA9IHsKIAkuc3lzYwkJPSAmZHJhN3h4X3NoYTBfc3lzYywKIH07CiAK
LXN0cnVjdCBvbWFwX2h3bW9kIGRyYTd4eF9zaGEwX2h3bW9kID0geworc3RhdGljIHN0cnVjdCBv
bWFwX2h3bW9kIGRyYTd4eF9zaGEwX2h3bW9kID0gewogCS5uYW1lCQk9ICJzaGFtIiwKIAkuY2xh
c3MJCT0gJmRyYTd4eF9zaGEwX2h3bW9kX2NsYXNzLAogCS5jbGtkbV9uYW1lCT0gImw0c2VjX2Ns
a2RtIiwKLS0gCjIuMjMuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
