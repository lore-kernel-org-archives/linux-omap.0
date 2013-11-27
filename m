From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Wed, 27 Nov 2013 17:23:34 +0000
Message-ID: <20ADAB092842284E95860F279283C5640AAF43B1@BGSMSX104.gar.corp.intel.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30486 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3K0RXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 12:23:38 -0500
In-Reply-To: <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "freemangordon@abv.bg" <freemangordon@abv.bg>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "pavel@ucw.cz" <pavel@ucw.cz>

DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAxLzNdIHBvd2VyX3N1cHBseTogQWRkIHBvd2VyX3N1cHBs
eSBub3RpZmllcg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGEgbm90aWZpZXIgY2hhaW4gdG8gdGhl
IHBvd2VyX3N1cHBseS4NCj4gVGhpcyBub3RpZmllciBoZWxwcyBkcml2ZXJzIGluIG90aGVyIHN1
YnN5c3RlbSB0byBsaXN0ZW4gdG8gY2hhbmdlcyBpbiBwb3dlciBzdXBwbHkNCj4gc3Vic3lzdGVt
LiBUaGlzIHdvdWxkIGhlbHAgdG8gdGFrZSBzb21lIGFjdGlvbnMgaW4gdGhvc2UgZHJpdmVycyBv
biBjaGFuZ2luZyB0aGUgcG93ZXINCj4gc3VwcGx5IHByb3BlcnRpZXMuDQo+IE9uZSBzdWNoIHNj
ZW5hcmlvIGlzIHRvIGluY3JlYXNlL2RlY3JlYXNlIHN5c3RlbSBwZXJmb3JtYW5jZSBiYXNlZCBv
biB0aGUgYmF0dGVyeQ0KPiBjYXBhY2l0eS92b2x0YWdlLiBBbm90aGVyIHNjZW5hcmlvIGlzIHRv
IGFkanVzdCB0aGUgaC93IHBlYWsgY3VycmVudCBkZXRlY3Rpb24NCj4gdm9sdGFnZS9jdXJyZW50
IHRocmVzaG9sZHMgYmFzZWQgb24gYmF0dGVyeSB2b2x0YWdlL2NhcGFjaXR5LiBUaGUgbm90aWZp
ZXIgaGVscHMgZHJpdmVycyB0bw0KPiBsaXN0ZW4gdG8gY2hhbmdlcyBpbiBwb3dlcl9zdXBweSBz
dXNieXN0ZW0gd2l0aG91dCBwb2xsaW5nIHRoZSBwb3dlcl9zdXBwbHkgcHJvcGVydGllcw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSmVubnkgVEMgPGplbm55LnRjQGludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPg0KPiAtLS0NCg0KQWNr
ZWQtYnk6IEplbm55IFRDIDxqZW5ueS50Y0BpbnRlbC5jb20+DQo=
