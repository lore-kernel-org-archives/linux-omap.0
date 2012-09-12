From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Wed, 12 Sep 2012 09:50:13 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com> <20120911184606.GN23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab2ILJuZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 05:50:25 -0400
In-Reply-To: <20120911184606.GN23092@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

SGkgVG9ueSwNCg0KT24gV2VkLCBTZXAgMTIsIDIwMTIgYXQgMDA6MTY6MDYsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6DQoNCj4gSGVyZSBhcmUgdGhlIHRpbWluZyBjaGFuZ2VzIHdpdGggYW5kIHdpdGhv
dXQgdGhpcyBwYXRjaCBmcm9tDQo+IG15IG44MDAuIFlvdSBjYW4ganVzdCBkaWZmIHRoZSB0d28g
ZmlsZXMgdG8gc2VlIHNvbWUgZGlmZmVyZW5jZXMuDQoNCkhtbS4uIHRoYXQgd2FzIHByZXR0eSBj
bG9zZSwgT25lTkFORCBhc3luYyxzeW5jIGFzIHdlbGwgYXMNCnR1c2Igc3luYyB2YWx1ZXMgd2Vy
ZSBzYW1lLg0KDQpCdXQgc29tZSBvZiB0aGUgdHVzYiBhc3luYyB2YWx1ZXMgaXMgbGVzcyBieSBv
bmUuIEkgbmVlZA0KdG8gZ2V0IGl0IHJpZ2h0Lg0KDQpBbmQgdGhhbmtzIGZvciBzZW5kaW5nIG1l
IHRoZSBlYXNpbHkgZGlmZi1hYmxlIGxvZ3MuDQoNClJlZ2FyZHMNCkFmemFsDQo=
