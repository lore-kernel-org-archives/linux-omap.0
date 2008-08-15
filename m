From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Fri, 15 Aug 2008 15:16:29 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
	 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
	 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
	 <20080815112112.GB16840@atomide.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
	 <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com>
 <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49495 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758240AbYHOUQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Aug 2008 16:16:44 -0400
In-Reply-To: <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>

SGkgRmVsaXBlLA0KDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEZlbGlw
ZSBDb250cmVyYXMNCg0KPHNuaXA+DQoNCj4gPj4gQXMgcGFydCBvZiBjb250cmlidXRpbmcgdGhp
cyBjb2RlIHRoZXJlIGhhcyBiZWVuIGEgbG90IG9mIHJld29ya2luZw0KPiBvZiB0aGUgY29kZS4g
TGFzdCBJIGhhZCBoZWFyZCBjaGVja3BhdGNoIGFuZCBzcGFyc2Ugd2FybmluZ3MgaGFkIGJlZW4N
Cj4ga2lsbGVkLiBUaGVyZSB3YXMgYWxzbyBhIGxvdCBvZiB3b3JrIGluIG1ha2luZyBzdXJlIHRo
ZXJlIHdvdWxkIGJlIG5vDQo+IGxlZ2FsIGltcGFjdCB0byB0aGUga2VybmVsIHRvIGNsZWFyIGl0
cyBhYmlsaXR5IHRvIGJlIGNvbnRyaWJ1dGVkLg0KPiA+DQo+ID4gTm90IHRydWU6IDEzIGVycm9y
cywgMjQ2IHdhcm5pbmdzLg0KDQpUb2RheSBhbm90aGVyIHNldCBvZiB3YXJuaW5nIGNoYW5nZXMg
aXMgaW4gcXVldWUuIFdpbGwgaGF2ZSB0byBjaGVjayB3aGF0IHRoZSBjdXJyZW50IG51bWJlciBo
YXMgYmVjb21lLiBJdCB3aWxsIGJlIGxvdy4gVGhlIHN0YXJ0IG51bWJlciBhIHdoaWxlIGJhY2sg
d2FzIGRlZmlhbnRseSB2ZXJ5IGhpZ2guDQoNCkNoZWNrcGF0Y2gucGwgaXMganVzdCBhIGd1aWRl
LiAgQ29tcGxldGVseSBjaGFuZ2luZyBjb2RlIGZvciB0aGUgdG9vbCBpc24ndCBwcm9iYWJseSBh
IGdvb2QgaWRlYS4gSXQgbWlnaHQgZXZlbiBnZXQgeW91IHNldmVyYWxseSBmbGFtZWQgb24gTEtN
TCA6KSAgVGhlIHJlY2VudCB0aHJlYWRzIGFyZSBpbmZvcm1hdGl2ZSAob2sgdG8gcmVhZCwgYmFk
IHRvIGJlIGluKS4NCg0KSW5jaWRlbnRhbGx5LCB3aGVuIEkgYXNrZWQgdGhlIHBlcnNvbiB3b3Jr
aW5nIHRoZXNlIGNoYW5nZXMsIHRoZXkgaGFkIHJlcG9ydGVkIDAgZnVuY3Rpb25hbCBlcnJvcnMg
aGFkIGJlZW4gZml4ZWQgYnkgdGhlIGNoZWNrcGF0Y2ggY2hhbmdlcy4gIEEgbG90IG9mIHRoZSBu
b2lzZSB3YXMgdHlwZWRlZiByZWR1Y3Rpb24uDQoNCjxzbmlwPg0KDQo+IEVyciwgSSBnb3QgY29u
ZnVzZWQgYWJvdXQgdGhlIENFL0xpbmssIEkgbWVhbnQgdGhlIHhkY3Rvb2xzLi4uIG9yDQo+IHdo
YXRldmVyIGlzIG5lZWRlZCB0byBjb21waWxlIERTUCBub2Rlcy4gQUZBSUsgdGhlIERTUCBjb21w
aWxlciBpcyBub3QNCj4gZW5vdWdoLg0KDQpZb3UgYXJlIGNvcnJlY3QgdGhhdCB0aGUgaW50ZXJu
YWwgRFNQIGFyY2hpdGVjdHVyZSBpcyBub3Qgb3BlbmVkIHVwIG9ubHkgdGhlIEFSTSBzaWRlIGFu
ZCB0aGUgcGVyaXBoZXJhbHMuICBEU1AgaW50ZXJuYWxzIGlzIGFub3RoZXIgdG9waWMuICBZb3Ug
c2hvdWxkIGJlIGFibGUgdG8gY29tcGlsZSB0aGUgQVJNIHNpZGUuDQoNCkEgZmV3IHllYXJzIGJh
Y2sgSSBoYWQgaGVhcmQgYWJvdXQgc29tZSBwZW9wbGUgZXZlbiBzdWNjZXNzZnVsbHkgcnVubmlu
ZyBMaW51eCBvbiB0aGUgQzZ4IERTUC4gIEkgdGhpbmsgaXQgcmFuIHdlbGwsIGJ1dCBraW5kIG9m
IG5lYXQgYWxsIHRoZSBzYW1lLiAgRFNQQklPUyBvciBvdGhlciB0aW55IE9TZXMgd29yayBtdWNo
IGJldHRlciB0aGVyZS4NCg0KUmVnYXJkcywNClJpY2hhcmQgVy4NCg0K
