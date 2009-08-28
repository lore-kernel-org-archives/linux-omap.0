From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Sat, 29 Aug 2009 00:13:13 +0300
Message-ID: <5ec8ebd50908281413j139f01a8q25c9e9c4339e5a25@mail.gmail.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:18127 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbZH1VNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 17:13:13 -0400
Received: by ey-out-2122.google.com with SMTP id 25so507579eya.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 14:13:14 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

T24gRnJpLCBBdWcgMjgsIDIwMDkgYXQgMTE6NTggUE0sIEd1em1hbiBMdWdvLAoKCj4gQEAgLTMy
NCw3ICszMjQsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBicmlkZ2VfaW5pdCh2b2lkKQo+IMKgIMKg
IMKgIMKgaWYgKHJlc3VsdCA8IDApIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEdUXzF0cmFj
ZShkcml2ZXJUcmFjZSwgR1RfN0NMQVNTLCAiYnJpZGdlX2luaXQ6ICIKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCJDYW4ndCBnZXQgTWFqb3IgJWQgXG4i
LCBkcml2ZXJfbWFqb3IpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJlc3VsdDsK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyMTsKPiDCoCDCoCDCoCDCoH0KPgo+IMKg
IMKgIMKgIMKgZHJpdmVyX21ham9yID0gTUFKT1IoZGV2KTsKPiBAQCAtMzMyLDE5ICszMzIsMTcg
QEAgc3RhdGljIGludCBfX2luaXQgYnJpZGdlX2luaXQodm9pZCkKPiDCoCDCoCDCoCDCoGJyaWRn
ZV9kZXZpY2UgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgYnJpZGdlX2RldiksIEdGUF9LRVJORUwp
Owo+IMKgIMKgIMKgIMKgaWYgKCFicmlkZ2VfZGV2aWNlKSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXN1bHQgPSAtRU5PTUVNOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5yZWdpc3Rl
cl9jaHJkZXZfcmVnaW9uKGRldiwgMSk7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4g
cmVzdWx0Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnIyOwo+IMKgIMKgIMKgIMKg
fQo+IMKgIMKgIMKgIMKgY2Rldl9pbml0KCZicmlkZ2VfZGV2aWNlLT5jZGV2LCAmYnJpZGdlX2Zv
cHMpOwo+IMKgIMKgIMKgIMKgYnJpZGdlX2RldmljZS0+Y2Rldi5vd25lciA9IFRISVNfTU9EVUxF
Owo+IMKgIMKgIMKgIMKgYnJpZGdlX2RldmljZS0+Y2Rldi5vcHMgPSAmYnJpZGdlX2ZvcHM7Cj4K
PiDCoCDCoCDCoCDCoHN0YXR1cyA9IGNkZXZfYWRkKCZicmlkZ2VfZGV2aWNlLT5jZGV2LCBkZXYs
IDEpOwo+IC0KPiDCoCDCoCDCoCDCoGlmIChzdGF0dXMpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoEdUXzB0cmFjZShkcml2ZXJUcmFjZSwgR1RfN0NMQVNTLAo+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIkZhaWxlZCB0byBhZGQgdGhlIGJyaWRnZSBk
ZXZpY2UgXG4iKTsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBzdGF0dXM7CnJlc3Vs
dCA9IHN0YXR1cywgaXNuJ3QgaXM/Cm9yIGNoYW5nZSBzdGF0dXMgdG8gcmVzdWx0IG9uIHByZXZp
b3VzIGxpbmVzLgoKCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycjM7Cj4gwqAgwqAg
wqAgwqB9Cj4KPiDCoCDCoCDCoCDCoC8qIHVkZXYgc3VwcG9ydCAqLwo+IEBAIC00NzQsNyArNDcy
LDE3IEBAIHN0YXRpYyBpbnQgX19pbml0IGJyaWRnZV9pbml0KHZvaWQpCj4gwqAgwqAgwqAgwqBE
QkNfQXNzZXJ0KHN0YXR1cyA9PSAwKTsKPiDCoCDCoCDCoCDCoERCQ19Bc3NlcnQoRFNQX1NVQ0NF
RURFRChpbml0U3RhdHVzKSk7Cj4gwqAgwqAgwqAgwqBHVF8wdHJhY2UoZHJpdmVyVHJhY2UsIEdU
X0VOVEVSLCAiIDwtIGRyaXZlcl9pbml0XG4iKTsKPiAtIMKgIMKgIMKgIHJldHVybiBzdGF0dXM7
Cj4gKwo+ICsgwqAgwqAgwqAgcmV0dXJuIDA7Cj4gKwo+ICtlcnIzOgo+ICsgwqAgwqAgwqAga2Zy
ZWUoYnJpZGdlX2RldmljZSk7Cj4gKwo+ICtlcnIyOgo+ICsgwqAgwqAgwqAgdW5yZWdpc3Rlcl9j
aHJkZXZfcmVnaW9uKGRldiwgMSk7Cj4gKwo+ICtlcnIxOgo+ICsgwqAgwqAgwqAgcmV0dXJuIHJl
c3VsdDsKPiDCoH0KPgo+IMKgLyogwqBUaGlzIGZ1bmN0aW9uIGlzIGludm9rZWQgZHVyaW5nIHVu
bGlua2luZyBvZiB0aGUgYnJpZGdlIG1vZHVsZSBmcm9tIHRoZQoKCi0tIApXaXRoIEJlc3QgUmVn
YXJkcywKQW5keSBTaGV2Y2hlbmtvCg==
