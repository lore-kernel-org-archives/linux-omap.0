From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix omap5 SDIO dat1 interrupt
Date: Wed,  1 Jun 2016 09:21:52 -0700
Message-ID: <1464798112-8793-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, =?UTF-8?q?Agust=C3=AD=20Fontquerni?= <af@iseebcn.com>, Eduard Gavin <egavin@iseebcn.com>, linux-arm-kernel@lists.infradead.org, Uri Mashiach <uri.mashiach@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

VGhlIFNESU8gd2FrZWlycSBpcyB3cm9uZywgaXQgbmVlZHMgdG8gYmUgU0RJTyBkYXQxIGxpbmUs
IG5vdCBkYXQwLgpPdGhlcndpc2UgdGhlIHN5c3RlbSB3b24ndCB3YWtlIHRvIFNESU8gaW50ZXJy
dXB0cyBmcm9tIGlkbGUgc3RhdGVzLgoKVGhpcyBtYWtlcyB0aGUgd2wxMnh4IGJlaGF2ZSBiZXR0
ZXIgb24gaWdlcHY1LCBvdGhlcndpc2Ugd2UgbWF5IGhhdmUgaGFyZAp0aW1lIGNvbm5lY3Rpbmcg
dG8gYW4gYWNjZXNzIHBvaW50LgoKQW5kIG9tYXA1LXVldm0gb3Igd2wxOHh4IHN0aWxsIHNlZW1z
IHRvIGhhdmUgc29tZSBvdGhlciBpc3N1ZXMgcmVtYWluaW5nLgoKQ2M6IEFndXN0w60gRm9udHF1
ZXJuaSA8YWZAaXNlZWJjbi5jb20+CkNjOiBFZHVhcmQgR2F2aW4gPGVnYXZpbkBpc2VlYmNuLmNv
bT4KQ2M6IEVucmljIEJhbGxldGJvIFNlcnJhIDxlYmFsbGV0Ym9AZ21haWwuY29tPgpDYzogVXJp
IE1hc2hpYWNoIDx1cmkubWFzaGlhY2hAY29tcHVsYWIuY28uaWw+ClNpZ25lZC1vZmYtYnk6IFRv
bnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvb21h
cDUtYm9hcmQtY29tbW9uLmR0c2kgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LWJvYXJkLWNv
bW1vbi5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA1LWJvYXJkLWNvbW1vbi5kdHNp
CkBAIC0zNTcsNyArMzU3LDcgQEAKIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwogCXBpbmN0
cmwtMCA9IDwmbW1jM19waW5zICZ3bGNvcmVfaXJxX3Bpbj47CiAJaW50ZXJydXB0cy1leHRlbmRl
ZCA9IDwmZ2ljIEdJQ19TUEkgOTQgSVJRX1RZUEVfTEVWRUxfSElHSAotCQkJICAgICAgICZvbWFw
NV9wbXhfY29yZSAweDE2OD47CisJCQkgICAgICAgJm9tYXA1X3BteF9jb3JlIDB4MTZhPjsKIAog
CSNhZGRyZXNzLWNlbGxzID0gPDE+OwogCSNzaXplLWNlbGxzID0gPDA+OwotLSAKMi44LjEKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
