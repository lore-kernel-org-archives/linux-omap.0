From: "Reizer, Eyal" <eyalr@ti.com>
Subject: RE: [PATCH 2/2] am335x-evm: add bluetooth support
Date: Tue, 5 May 2015 06:06:39 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B236603EC@DFRE01.ent.ti.com>
References: <1430655569-27849-1-git-send-email-eyalr@ti.com>
 <1430655569-27849-2-git-send-email-eyalr@ti.com>
 <CAL_JsqJd=6nG1S-Mds+MiS4wSmKnOUo2nBnA6wjGSycXECLpcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8665E2433BC68541A24DFFCA87B70F5B236603ECDFRE01entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38414 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973AbbEEGHJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 May 2015 02:07:09 -0400
In-Reply-To: <CAL_JsqJd=6nG1S-Mds+MiS4wSmKnOUo2nBnA6wjGSycXECLpcQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Eyal Reizer <eyalreizer@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Eliad Peller <eliad@wizery.com>

--_002_8665E2433BC68541A24DFFCA87B70F5B236603ECDFRE01entticom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUm9iLA0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guIA0KSSBoYXZlIHJlY2VpdmVkIHB1
c2hiYWNrIG9uIGEgc2ltaWxhciBwYXRjaCBmb3IgYSBkaWZmZXJlbnQgcGxhdGZvcm0gKGFtNDM3
eC1ldm0pIGFuZCBzdWJtaXR0ZWQgYSB2MiAoYXR0YWNoZWQpIHRoYXQgb25seSBpbml0aWFsaXpl
cyB0aGUgdWFydCB3aXRob3V0IHVzaW5nIHRoZSBzaGFyZWQgdHJhbnNwb3J0IGRyaXZlci4NCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWls
dG86cm9iaGVycmluZzJAZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMDUsIDIwMTUg
MToyOCBBTQ0KPiBUbzogRXlhbCBSZWl6ZXINCj4gQ2M6IFRvbnkgTGluZGdyZW47IFJvYiBIZXJy
aW5nOyBQYXdlbCBNb2xsOyBNYXJrIFJ1dGxhbmQ7IElhbiBDYW1wYmVsbDsNCj4gS3VtYXIgR2Fs
YTsgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4OyBsaW51eC1vbWFwOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgRWxpYWQgUGVsbGVyOyBSZWl6ZXIsIEV5YWwNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAyLzJdIGFtMzM1eC1ldm06IGFkZCBibHVldG9vdGggc3VwcG9ydA0KPiANCj4gT24g
U3VuLCBNYXkgMywgMjAxNSBhdCA3OjE5IEFNLCBFeWFsIFJlaXplciA8ZXlhbHJlaXplckBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+IEZyb206IEVsaWFkIFBlbGxlciA8ZWxpYWRAd2l6ZXJ5LmNvbT4N
Cj4gPg0KPiA+IHVhcnQxIGlzIHVzZWQgZm9yIHNoYXJlZCB0cmFuc3BvcnQgKHVzZWQgZm9yIG11
bHRpcGxleGluZyBibHVldG9vdGgNCj4gPiBhbmQgbmZjIGRhdGEpLiBhZGQgdGhlIG5lZWRlZCBt
dXhlcyBhbmQgZGVmaW5pdGlvbnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbGlhZCBQZWxs
ZXIgPGVsaWFkQHdpemVyeS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXlhbCBSZWl6ZXIgPGV5
YWxyQHRpLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5k
dHMgfCAgIDI4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9hbTMzNXgtZXZtLmR0cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2
bS5kdHMNCj4gPiBpbmRleCAwZjM5OGZhLi41OTY4Y2RlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2FtMzM1eC1ldm0uZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
YW0zMzV4LWV2bS5kdHMNCj4gPiBAQCAtMTM1LDYgKzEzNSwxOCBAQA0KPiA+ICAgICAgICAgICAg
ICAgICB9Ow0KPiA+ICAgICAgICAgfTsNCj4gPg0KPiA+ICsgICAgICAga2ltIHsNCj4gPiArICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJraW0iOw0KPiANCj4gV2hvIGlzIGtpbT8NCj4gDQo+
ID4gKyAgICAgICAgICAgICAgIG5zaHV0ZG93bl9ncGlvID0gPDExNz47IC8qIEJhbmszLCBwaW4y
MSAqLw0KPiANCj4gV2UgaGF2ZSBhIHN0YW5kYXJkIHdheSB0byBzcGVjaWZ5IGdwaW9zLg0KPiAN
Cj4gPiArICAgICAgICAgICAgICAgZGV2X25hbWUgPSAiL2Rldi90dHlTMSI7DQo+IA0KPiBVaCwg
TGludXggc3BlY2lmaWMuIE5vLg0KPiANCj4gPiArICAgICAgICAgICAgICAgZmxvd19jbnRybCA9
IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgYmF1ZF9yYXRlID0gPDMwMDAwMDA+Ow0KPiANCj4g
SSBiZWxpZXZlIHRoZXJlIGFyZSBzdGFuZGFyZCBwcm9wZXJ0aWVzIGZvciB1YXJ0cyBmb3IgYm90
aCBvZiB0aGVzZS4NCj4gDQo+IElzIGFueSBvZiB0aGlzIGRvY3VtZW50ZWQ/DQo+IA0KPiBSb2IN
Cg0KQmVzdCBSZWdhcmRzLA0KRXlhbA0K

--_002_8665E2433BC68541A24DFFCA87B70F5B236603ECDFRE01entticom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 05 May 2015 06:06:38 GMT";
	modification-date="Tue, 05 May 2015 06:06:38 GMT"

Received: from dlelxv84.itg.ti.com (172.17.0.246) by DFRE70.ent.ti.com
 (10.167.188.34) with Microsoft SMTP Server id 14.3.224.2; Mon, 4 May 2015
 14:42:00 +0200
Received: from white.ext.ti.com (white.ext.ti.com [192.94.93.38])	by
 dlelxv84.itg.ti.com (8.14.3/8.13.8) with ESMTP id t44CfxdO002642	for
 <eyalr@ti.com>; Mon, 4 May 2015 07:41:59 -0500
Received: from mail6.bemta7.messagelabs.com (mail6.bemta7.messagelabs.com
 [216.82.255.55])	by white.ext.ti.com (8.13.7/8.13.7) with ESMTP id
 t44CfxXJ010217	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=OK)	for <eyalr@ti.com>; Mon, 4 May 2015 07:42:00 -0500
Received: from [216.82.253.147] by server-10.bemta-7.messagelabs.com id
 B5/77-29949-61967455; Mon, 04 May 2015 12:41:58 +0000
Received: (qmail 7108 invoked from network); 4 May 2015 12:41:58 -0000
Received: from mail-wg0-f45.google.com (HELO mail-wg0-f45.google.com)
 (74.125.82.45)  by server-8.tower-165.messagelabs.com with RC4-SHA encrypted
 SMTP; 4 May 2015 12:41:58 -0000
Received: by wgyo15 with SMTP id o15so148749181wgy.2        for
 <eyalr@ti.com>; Mon, 04 May 2015 05:41:56 -0700 (PDT)
Received: from localhost.localdomain ([188.120.148.166])        by
 mx.google.com with ESMTPSA id gj7sm11066091wib.4.2015.05.04.05.41.53
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Mon,
 04 May 2015 05:41:56 -0700 (PDT)
From: Eyal Reizer <eyalreizer@gmail.com>
To: "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com"
	<tony@atomide.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk"
	<ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org"
	<galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
CC: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eliad Peller
	<eliad@wizery.com>, "Reizer, Eyal" <eyalr@ti.com>
Subject: [PATCHv2] am335x-evm: add bluetooth support
Thread-Topic: [PATCHv2] am335x-evm: add bluetooth support
Thread-Index: AQHQhme3uWJQNscYVkGMhIzPPnbtlQ==
Date: Mon, 4 May 2015 12:41:13 +0000
Message-ID: <1430743273-2518-1-git-send-email-eyalr@ti.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthMechanism: 10
X-MS-Exchange-Organization-AuthSource: DFRE70.ent.ti.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com;
 s=20120113;        h=from:to:cc:subject:date:message-id;
        bh=Zk1wZlOKE2PgeoAyDyJLWNl+jqmntEtD7DKRPBzDezQ=;
        b=BSCQ5FaN3AZSTHCDSTW1GPZfmM57bv2xWxcyFvAIC4ziiXcXgdLLxwFRLuRnu2BYSV
         5IV4Qd+RCUnWd7CwuQCNXlBvVoL7bHAkiVWBlh3ZIp8xN7I9Qwcmpw6NHqiyjDDddyBk
         KJTYFu+bXEDBaerxFS43xG0TPg1cTqcx0cFymJevXrjmvUwUiSL8VeHZcIebg2F42H6l
         7oheRdrTKllpFU7ykK1QOHXlVIbarZsaG4ZqVAiGs9Qzt9WXMuRuyTZ+mFxmTXtCStBa
         Hh92fRVraNxfUceNCIMJf3pbB8G74gKpGtDXHCHbbRCXaN3uCRnEJ5E2k8Slz7gXMs7X
         j6YQ==
x-originating-ip: [74.125.82.45]
x-exclaimer-md-config: f9c360f5-3d1e-4c3c-8703-f45bf52eff6b
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

From: Eliad Peller <eliad@wizery.com>

uart1 is used for connecting to wilink8 bluetooth subsystem.
add the needed muxes and definitions.

Signed-off-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
Changes in v2:
removed ti shared transport bindings

 arch/arm/boot/dts/am335x-evm.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-ev=
m.dts
index 0f398fa..765be27 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -191,6 +191,15 @@
                >;
        };

+       uart1_pins: pinmux_uart1_pins {
+               pinctrl-single,pins =3D <
+                       0x178 (PIN_INPUT | MUX_MODE0)           /* uart1_ct=
sn.uart1_ctsn */
+                       0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_rt=
sn.uart1_rtsn */
+                       0x180 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_rx=
d.uart1_rxd */
+                       0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_tx=
d.uart1_txd */
+               >;
+       };
+
        clkout2_pin: pinmux_clkout2_pin {
                pinctrl-single,pins =3D <
                        0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3) /* xdma_eve=
nt_intr1.clkout2 */
@@ -357,6 +366,13 @@
        status =3D "okay";
 };

+&uart1 {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&uart1_pins>;
+
+       status =3D "okay";
+};
+
 &i2c0 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&i2c0_pins>;
--
1.7.9.5


--_002_8665E2433BC68541A24DFFCA87B70F5B236603ECDFRE01entticom_--
