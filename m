From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
 omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 16:03:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:51285 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbYFZKdg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2008 06:33:36 -0400
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

DQpQYXVsDQoNCj4gVG86IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnDQo+IENjOiBHYWRpeWFy
LCBBbmFuZDsgay5rb29pQHN0dWRlbnQudXR3ZW50ZS5ubDsgZGlyay5iZWhtZUBnb29nbGVtYWls
LmNvbTsNCj4gaWdvci5zdG9wcGFAbm9raWEuY29tOyBXb29kcnVmZiwgUmljaGFyZDsgam91bmku
aG9nYW5kZXJAbm9raWEuY29tRA0KPiBTdWJqZWN0OiBbUEFUQ0ggMC80XSBPTUFQMi8zIGNsb2Nr
OiBmaXggc29tZSBidWdzIGluDQo+IG9tYXAyX2Nsa193YWl0X3JlYWR5KCkNCj4NCj4gVGhpcyBw
YXRjaCBzZXJpZXMgZml4ZXMgc29tZSBidWdzIGluIG9tYXAyX2Nsa193YWl0X3JlYWR5KCkuICBU
aGlzDQo+IGZ1bmN0aW9uDQoNCkkgaG9wZSB0aGlzIGhhcyBmaXhlZDoNCiJDbG9jayB1c2Job3N0
XzQ4bV9mY2sgZGlkbid0IGVuYWJsZSBpbiAxMDAwMDAgdHJpZXMiDQoNCg0KPiB3YWl0cyBmb3Ig
YW4gT01BUCBtb2R1bGUgdG8gYmVjb21lIHJlYWR5IGFmdGVyIGJvdGggaXRzIGZ1bmN0aW9uYWwg
YW5kDQo+IGludGVyZmFjZSBjbG9ja3MgYXJlIGVuYWJsZWQuICBOb3QgYWxsIE9NQVAgbW9kdWxl
cyBzdXBwb3J0IHRoaXMgcHJvY2Vzcy4NCj4NCg==
