From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or
	__vmalloc()
Date: Thu, 13 May 2010 22:36:01 +0300
Message-ID: <AANLkTikIZXTq2OAS96Od8h4HFtk0yM3hpXQymT_UYjAO@mail.gmail.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:45673 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab0EMTgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 15:36:03 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1290527fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 12:36:01 -0700 (PDT)
In-Reply-To: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

T24gRnJpLCBBcHIgOSwgMjAxMCBhdCAyOjQzIEFNLCBHb21leiBDYXN0ZWxsYW5vcywgSXZhbgo8
aXZhbi5nb21lekB0aS5jb20+IHdyb3RlOgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RzcC9icmlk
Z2Uvd21kL3VlX2RlaC5jIGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC91ZV9kZWguYwo+IGluZGV4
IDc1YTYyYjAuLjZjMWIzMTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC91
ZV9kZWguYwo+ICsrKyBiL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdWVfZGVoLmMKPiBAQCAtMjM5
LDggKzIzOSw4IEBAIHZvaWQgYnJpZGdlX2RlaF9ub3RpZnkoc3RydWN0IGRlaF9tZ3IgKmhkZWhf
bWdyLCB1MzIgdWxFdmVudE1hc2ssIHUzMiBkd0VyckluZm8pCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcmludGsoS0VSTl9JTkZPCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgImJyaWRnZV9kZWhfbm90aWZ5OiBEU1BfTU1VRkFVTFQs
IGZhdWx0ICIKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAi
YWRkcmVzcyA9IDB4JXhcbiIsICh1bnNpZ25lZCBpbnQpZmF1bHRfYWRkcik7Cj4gLSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkdW1teV92YV9hZGRyID0KPiAtIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICh1MzIpIG1lbV9jYWxsb2Moc2l6ZW9mKGNoYXIp
ICogMHgxMDAwLCBNRU1fUEFHRUQpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZHVtbXlfdmFfYWRkciA9ICh1MzIpIGt6YWxsb2Moc2l6ZW9mKGNoYXIpICogMHgxMDAwLAo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgR0ZQX0FUT01JQyk7CgpzaXpl
b2YoZm9vKSByZXR1cm5zIHRoZSBzaXplIG9mIGZvbyBpbiBjaGFycywgc28gb2J2aW91c2x5IHNp
emVvZihjaGFyKSBpcyAxLgoKLS0gCkZlbGlwZSBDb250cmVyYXMK
