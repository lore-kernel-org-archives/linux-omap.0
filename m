From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: dma_alloc_coherent bug?
Date: Mon, 16 Mar 2009 14:09:19 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF5A46E5@dlee02.ent.ti.com>
References: <87sklh1ki5.fsf@deeprootsystems.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD141D@dbde02.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A4274@dlee02.ent.ti.com>
 <269694c00903161029x37c44fe8q9e550b7b81b01913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbZCPTJc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 15:09:32 -0400
In-Reply-To: <269694c00903161029x37c44fe8q9e550b7b81b01913@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbWV5YSBQYWxhbmRlIFttYWls
dG86MmFtZXlhQGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNiwgMjAwOSA3OjMw
IFBNDQo+IFRvOiBNZW5vbiwgTmlzaGFudGgNCj4gQ2M6IEd1cHRhLCBSYW1lc2g7IEtldmluIEhp
bG1hbjsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc7IFJhbWlyZXogTHVuYSwNCj4gT21hcjsg
S2FuaWdlcmksIEhhcmk7IEFtZXlhIFBhbGFuZGU7IEd1em1hbiBMdWdvLCBGZXJuYW5kbw0KPiBT
dWJqZWN0OiBSZTogZG1hX2FsbG9jX2NvaGVyZW50IGJ1Zz8NCj4gDQo+IFRoZXJlIHNlZW1zIHRv
IGJlIGEgYnVnIHNvbWUgd2hlcmUgaW5zaWRlIERNQSAvIFZNIGFyZWEgd2hpY2ggaXMNCj4gY2F1
c2luZyB0aGlzIGZyYWdtZW50YXRpb24uDQo+IA0KPiBBbnkgY2x1ZT8/DQpSdXNzZWxsIG1lbnRp
b25lZCBzb21ldGltZSBiYWNrOg0KaHR0cDovL2xrbWwuaW5kaWFuYS5lZHUvaHlwZXJtYWlsL2xp
bnV4L2tlcm5lbC8wNzA2LjAvMDM3MC5odG1sDQoNClNvIEkgc3VwcG9zZSBkbWFfYWxsb2NfY29o
ZXJlbnQgZm9yID4gMXBhZ2Ugc2l6ZSg0MDk2KSBpcyBiYWQ/IElmIHNvIGhtbS4uIEkgYW0gZ3Vl
c3NpbmcgYXVkaW8gZHJpdmVyIGFuZCBvdGhlcnMgZG8gdXNlIGRtYV9hbGxvY19jb2hlcmVudC4u
IEkgdHJpZWQgbXkgZHVtbXkgZHJpdmVyIG9uIG9tYXB6b29tIG1hc3RlciBhbmQgaXQgc2VlbWQg
dG8gd29yayBmaW5lIHRoZXJlIGZvciAxMEsgaXRlcmF0aW9ucyA6KC4uIHNob3VsZCdudCB0aGUg
c2FtZSBmcmFnbWVudGF0aW9uIGhpdCB0aGVyZSB0b28/DQoNCkFueSBjbHVlcz8NCg0KUmVnYXJk
cywNCk5pc2hhbnRoIE1lbm9uDQoNCg==
