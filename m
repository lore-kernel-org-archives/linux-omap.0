From: y@pengutronix.de
Subject: [PATCH 06/11] i2c/i2c-omap: add a const qualifier
Date: Fri, 13 Jul 2012 14:32:09 +0200
Message-ID: <42460.9110028998$1342183964@news.gmane.org>
References: <1342182734-321-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1342182734-321-1-git-send-email-y>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClRoaXMgcHJlcGFyZXMgb2ZfZGV2aWNlX2lkLmRhdGEgYmVjb21pbmcgY29uc3QuIFdpdGhvdXQg
dGhpcyBjaGFuZ2UKdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIG9jY3VyOgoKCWRyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtb21hcC5jOiBJbiBmdW5jdGlvbiAnb21hcF9pMmNfcHJvYmUnOgoJZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1vbWFwLmM6MTAyNTogd2FybmluZzogYXNzaWdubWVudCBkaXNj
YXJkcyBxdWFsaWZpZXJzIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZQoKU2lnbmVkLW9mZi1ieTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KQ2M6IFRv
bnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+CkNjOiBXb2xmcmFtIFNhbmcgPHcuc2FuZ0Bw
ZW5ndXRyb25peC5kZT4KQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnCkNjOiBsaW51eC1p
MmNAdmdlci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vbWFwLmMgfCAg
ICAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jIGIvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1vbWFwLmMKaW5kZXggODAxZGY2MC4uNGZjNTg1ZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1vbWFwLmMKKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1v
bWFwLmMKQEAgLTk4Nyw3ICs5ODcsOCBAQCBvbWFwX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCXN0cnVjdCBvbWFwX2kyY19kZXYJKmRldjsKIAlzdHJ1Y3QgaTJjX2Fk
YXB0ZXIJKmFkYXA7CiAJc3RydWN0IHJlc291cmNlCQkqbWVtLCAqaXJxLCAqaW9hcmVhOwotCXN0
cnVjdCBvbWFwX2kyY19idXNfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBwZGV2LT5kZXYucGxhdGZv
cm1fZGF0YTsKKwljb25zdCBzdHJ1Y3Qgb21hcF9pMmNfYnVzX3BsYXRmb3JtX2RhdGEgKnBkYXRh
ID0KKwkJcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CiAJc3RydWN0IGRldmljZV9ub2RlCSpub2Rl
ID0gcGRldi0+ZGV2Lm9mX25vZGU7CiAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7
CiAJaXJxX2hhbmRsZXJfdCBpc3I7Ci0tIAoxLjcuMTAuNAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
