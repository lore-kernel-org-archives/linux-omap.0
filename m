From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.de>
Subject: [PATCH 2/2] mtd/nand/omap2: fix module loading
Date: Fri, 31 Aug 2012 13:35:42 +0200
Message-ID: <1346412942-4015-3-git-send-email-andreas@biessmann.de>
References: <1346412942-4015-1-git-send-email-andreas@biessmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1346412942-4015-1-git-send-email-andreas@biessmann.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas@biessmann.de>
List-Id: linux-omap@vger.kernel.org

VW5sb2FkaW5nIHRoZSBvbWFwMiBuYW5kIGRyaXZlciBtaXNzZWQgdG8gcmVsZWFzZSB0aGUgbWVt
b3J5IHJlZ2lvbiB3aGljaCB3aWxsCnJlc3VsdCBpbiBub3QgYmVpbmcgYWJsZSB0byByZXF1ZXN0
IGl0IGFnYWluIGlmIG9uZSB3YW50IHRvIGxvYWQgdGhlIGRyaXZlcgpsYXRlciBvbi4KClRoaXMg
cGF0Y2ggZml4ZXMgZm9sbG93aW5nIGVycm9yIHdoZW4gbG9hZGluZyBvbWFwMiBtb2R1bGUgYWZ0
ZXIgdW5sb2FkaW5nOgotLS04PC0tLQp+ICQgcm1tb2Qgb21hcDIKfiAkIG1vZHByb2JlIG9tYXAy
ClsgICAzNy40MjA5MjhdIG9tYXAyLW5hbmQ6IHByb2JlIG9mIG9tYXAyLW5hbmQuMCBmYWlsZWQg
d2l0aCBlcnJvciAtMTYKfiAkCi0tLT44LS0tCgpUaGlzIGVycm9yIHdhcyBpbnRyb2R1Y2VkIGlu
IDY3Y2UwNGJmMjc0NmY4YTFmOGMyYTEwNGIzMTNkMjBjNjNmNjgzNzggd2hpY2gKd2FzIHRoZSBm
aXJzdCBjb21taXQgb2YgdGhpcyBkcml2ZXIuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEJpZcOf
bWFubiA8YW5kcmVhc0BiaWVzc21hbm4uZGU+CmNjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFk
Lm9yZwotLS0KIGRyaXZlcnMvbXRkL25hbmQvb21hcDIuYyB8ICAgIDEgKwogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9vbWFwMi5j
IGIvZHJpdmVycy9tdGQvbmFuZC9vbWFwMi5jCmluZGV4IDRjZDdhYzAuLjQ4ZjFkNGUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbXRkL25hbmQvb21hcDIuYworKysgYi9kcml2ZXJzL210ZC9uYW5kL29t
YXAyLmMKQEAgLTEzODcsNiArMTM4Nyw3IEBAIHN0YXRpYyBpbnQgb21hcF9uYW5kX3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCS8qIFJlbGVhc2UgTkFORCBkZXZpY2UsIGl0
cyBpbnRlcm5hbCBzdHJ1Y3R1cmVzIGFuZCBwYXJ0aXRpb25zICovCiAJbmFuZF9yZWxlYXNlKCZp
bmZvLT5tdGQpOwogCWlvdW5tYXAoaW5mby0+bmFuZC5JT19BRERSX1IpOworCXJlbGVhc2VfbWVt
X3JlZ2lvbihpbmZvLT5waHlzX2Jhc2UsIE5BTkRfSU9fU0laRSk7CiAJa2ZyZWUoaW5mbyk7CiAJ
cmV0dXJuIDA7CiB9Ci0tIAoxLjcuMTAuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxp
c3QKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQv
Cg==
