From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mtd: nand: omap2: Do not assign omap_nand_info to
 platform drvdata
Date: Fri, 13 Oct 2017 15:06:27 +0300
Message-ID: <ba3bdf7e-fae9-0541-756a-b1447ffb2dc6@ti.com>
References: <20171010133245.jlwto3gpmin5bmtw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171010133245.jlwto3gpmin5bmtw@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-omap@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-Id: linux-omap@vger.kernel.org

77u/SGksCgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwg
MDAxODAgSGVsc2lua2kuIFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlr
a2EvRG9taWNpbGU6IEhlbHNpbmtpCgpPbiAxMC8xMC8xNyAxNjozMiwgTGFkaXNsYXYgTWljaGwg
d3JvdGU6Cj4gY29tbWl0IDY3Y2UwNGJmMjc0NiAoIm10ZDogbmFuZDogYWRkIE9NQVAyL09NQVAz
IE5BTkQgZHJpdmVyIikgYXNzaWduZWQKPiBwb2ludGVyIHRvIG9tYXBfbmFuZF9pbmZvIHRvIHRo
ZSBwbGF0Zm9ybSBkcnZkYXRhIGluIHByb2JlIGZ1bmN0aW9uCj4ganVzdCB0byBiZSByZWFzaWdu
ZWQgbGF0ZXIgdG8gdGhlIHBvaW50ZXIgdG8gbXRkX2luZm8sIHdoaWNoIGlzCj4gd2hhdCByZW1v
dmUgZnVuY3Rpb24gZXhwZWN0cyBpdCB0byBiZS4gUmVtb3ZlIHVzZWxlc3MgYXNzaWdubWVudC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBMYWRpc2xhdiBNaWNobCA8bGFkaXNAbGludXgtbWlwcy5vcmc+
CgpUZXN0ZWQgb24gZHJhNy1ldm0uCgpBY2tlZC1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRp
LmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvbXRkL25hbmQvb21hcDIuYyB8IDEgLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5k
L29tYXAyLmMgYi9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMKPiBpbmRleCAwMTM2OGE4ZjllM2Yu
LmE5N2MxYWVlZDU1ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMKPiAr
KysgYi9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMKPiBAQCAtMTgyMyw3ICsxODIzLDYgQEAgc3Rh
dGljIGludCBvbWFwX25hbmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAg
CWlmIChlcnIpCj4gIAkJcmV0dXJuIGVycjsKPiAgCj4gLQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBpbmZvKTsKPiAgCWluZm8tPm9wcyA9IGdwbWNfb21hcF9nZXRfbmFuZF9vcHMoJmluZm8t
PnJlZywgaW5mby0+Z3BtY19jcyk7Cj4gIAlpZiAoIWluZm8tPm9wcykgewo+ICAJCWRldl9lcnIo
JnBkZXYtPmRldiwgIkZhaWxlZCB0byBnZXQgR1BNQy0+TkFORCBpbnRlcmZhY2VcbiIpOwo+IAoK
LS0gCmNoZWVycywKLXJvZ2VyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K
