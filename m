From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] drivers: bus: omap_l3: Convert to use
 devm_request_and_ioremap()
Date: Tue, 4 Mar 2014 11:42:06 +0200
Message-ID: <53159FEE.3030801@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com>
 <1393924359.866301359@f148.i.mail.ru> <1393925000.716948505@f148.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393925000.716948505@f148.i.mail.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDMvMDQvMjAxNCAxMToyMyBBTSwgQWxleGFuZGVyIFNoaXlhbiB3cm90ZToKPj4+IC0JbDMt
PmwzX2Jhc2VbMl0gPSBpb3JlbWFwKHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSk7Cj4+
PiAtCWlmICghbDMtPmwzX2Jhc2VbMl0pIHsKPj4+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgImlv
cmVtYXAgZmFpbGVkXG4iKTsKPj4+IC0JCXJldCA9IC1FTk9NRU07Cj4+PiAtCQlnb3RvIGVycjI7
Cj4+PiArCQlsMy0+bDNfYmFzZVtpXSA9IGRldm1fcmVxdWVzdF9hbmRfaW9yZW1hcCgmcGRldi0+
ZGV2LCByZXMpOwo+Pj4gKwkJaWYgKCFsMy0+bDNfYmFzZVtpXSkgewo+Pgo+PiBpZiAoSVNfRVJS
KGwzLT5sM19iYXNlW2ldKSkKPiAKPiBBaGgsIEkgbWVzc2VkIHVwIHRoaXMgd2l0aCBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoKS4KPiBIb3dldmVyLCBpZiB0aGVyZSBpcyByZWFzb24gdG8gdXNlIGRl
dm1fcmVxdWVzdF9hbmRfaW9yZW1hcCgpIGhlcmU/CgpkZXZtX3JlcXVlc3RfYW5kX2lvcmVtYXAo
KSBpcyBqdXN0IGEgd3JhcHBlciBmb3IgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkuIEl0CnJldHVy
bnMgTlVMTCBpbiBjYXNlIG9mIGVycm9yIChlYXRzIHVwIHRoZSBlcnJvciBjb2RlIGF0IHRoZSBz
YW1lIHRpbWUpLgpJIGRvbid0IGhhdmUgc3Ryb25nIHByZWZlcmVuY2Ugb24gdGhpcyBzbyBJIGNh
biBjaGFuZ2UgaXQgdG8KZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkKCi0tIApQw6l0ZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
