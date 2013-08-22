From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Subject: RE: [PATCH v4 2/3] usb: phy: Add Qualcomm SS-USB and HS-USB drivers
 for DWC3 core
Date: Thu, 22 Aug 2013 21:24:49 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458DECB7C@US01WEMBX2.internal.synopsys.com>
References: <1376992565-22292-1-git-send-email-iivanov@mm-sol.com>
	 <1376992565-22292-3-git-send-email-iivanov@mm-sol.com>
	 <20130820122907.GU26587@radagast>
	 <1377005543.26268.22.camel@iivanov-dev.int.mm-sol.com>
	 <20130820133712.GC26587@radagast>
	 <1377007751.26268.27.camel@iivanov-dev.int.mm-sol.com>
	 <20130820143319.GG26587@radagast>
	 <1377010458.26268.30.camel@iivanov-dev.int.mm-sol.com>
	 <8691FDFE-326E-4198-838A-202D9EC988E1@codeaurora.org>
 <1377012381.26268.42.camel@iivanov-dev.int.mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377012381.26268.42.camel@iivanov-dev.int.mm-sol.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>, Kumar Gala <galak@codeaurora.org>
Cc: "balbi@ti.com" <balbi@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "idos@codeaurora.org" <idos@codeaurora.org>, "mgautam@codeaurora.org" <mgautam@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

PiBGcm9tOiBJdmFuIFQuIEl2YW5vdiBbbWFpbHRvOmlpdmFub3ZAbW0tc29sLmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDIwLCAyMDEzIDg6MjYgQU0NCj4gDQo+IE9uIFR1ZSwgMjAxMy0w
OC0yMCBhdCAxMDowMSAtMDUwMCwgS3VtYXIgR2FsYSB3cm90ZToNCj4gPiBPbiBBdWcgMjAsIDIw
MTMsIGF0IDk6NTQgQU0sIEl2YW4gVC4gSXZhbm92IHdyb3RlOg0KPiA+DQo+ID4gPg0KPiA+ID4g
SGksDQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyMDEzLTA4LTIwIGF0IDA5OjMzIC0wNTAwLCBGZWxp
cGUgQmFsYmkgd3JvdGU6DQo+ID4gPj4gT24gVHVlLCBBdWcgMjAsIDIwMTMgYXQgMDU6MDk6MTFQ
TSArMDMwMCwgSXZhbiBULiBJdmFub3Ygd3JvdGU6DQo+ID4gPj4+DQo+ID4gPj4+IE9uIFR1ZSwg
MjAxMy0wOC0yMCBhdCAwODozNyAtMDUwMCwgRmVsaXBlIEJhbGJpIHdyb3RlOg0KPiA+ID4+Pj4N
Cj4gPiA+Pj4+IE9uIFR1ZSwgQXVnIDIwLCAyMDEzIGF0IDA0OjMyOjIzUE0gKzAzMDAsIEl2YW4g
VC4gSXZhbm92IHdyb3RlOg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gSSB0aGluayB0aGV5IGFyZSBT
TlBTIERlc2lnbldhcmUgUEhZJ3MsIGFkZGl0aW9uYWxseQ0KPiA+ID4+Pj4+IHdyYXBwZWQgd2l0
aCBRdWFsY29tbSBsb2dpYy4gSSBjb3VsZCBzdWJzdGl0dXRlICJkd2MzIg0KPiA+ID4+Pj4+IHdp
dGgganVzdCAiZHciLCB3aGljaCB3aWxsIGJlIG1vcmUgY29ycmVjdC4NCj4gPiA+Pj4+DQo+ID4g
Pj4+PiBhbHJpZ2h0LCB0aGFuayB5b3UuIExldCdzIGFkZCBQYXVsIHRvIHRoZSBsb29wIHNpbmNl
IGhlIG1pZ2h0IGhhdmUgdmVyeQ0KPiA+ID4+Pj4gZ29vZCBpbnNpZ2h0IGluIHRoZSBzeW5vcHN5
cyBQSFlzLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IG1lbnRhbCBub3RlOiBpZiBhbnkgb3RoZXIgcGxh
dGZvcm0gc2hvd3MgdXAgd2l0aCBTeW5vcHN5cyBQSFksIGFzayB0aGVtDQo+ID4gPj4+PiB0byB1
c2UgdGhpcyBkcml2ZXIgaW5zdGVhZCA6LSkNCj4gPiA+Pj4NCj4gPiA+Pj4gSSByZWFsbHkgZG91
YnQgdGhhdCB0aGlzIHdpbGwgYmkgcG9zc2libGUuIENvbnRyb2wgb2YgdGhlIFBIWSdzIGlzDQo+
ID4gPj4+IG5vdCBkaXJlY3RseSB0cm91Z2ggVUxQSSwgVVRNSSBvciBQSVBFMyBpbnRlcmZhY2Vz
LCBidXQgdHJvdWdoDQo+ID4gPj4+IFFTQ1JBVENIIHJlZ2lzdGVycywgd2hpY2ggb2YgY291cnNl
IGlzIGhpZ2hseSBRdWFsY29tbSBzcGVjaWZpYy4NCj4gPiA+Pg0KPiA+ID4+IGlzbid0IGl0IGEg
bWVtb3J5IG1hcHBlZCBJUCA/IGRvZXNuJ3Qgc3lub3BzeXMgcHJvdmlkZSB0aGVpciBvd24gc2V0
IG9mDQo+ID4gPj4gcmVnaXN0ZXJzID8NCj4gPiA+DQo+ID4gPiBGcm9tIHdoYXQgSSBzZWUgaXQg
aXMgbm90IGRpcmVjdGx5IG1hcHBlZC4gSG93IFFTQ1JBVENIIHdyaXRlIGFuZA0KPiA+ID4gcmVh
ZHMgdHJhbnNhY3Rpb25zIGFyZSB0cmFuc2xhdGVkIHRvIERXIElQIGlzIHVuY2xlYXIgdG8gbWUu
DQo+ID4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHF1ZXN0aW9uIGlzIGhvdyBkb2VzIFNXIGFjY2Vz
cyB0aGVtPw0KPiANCj4gIlVTQiBRU0NSQVRDSCBIYXJkd2FyZSByZWdpc3RlcnMiIGRvbid0IGFz
ayBtZSB3aGF0IGlzIHRoaXMgOi0pDQo+IG9yIGxpa2UgUGF3ZWwgc2F5czogIml0IGRlcGVuZHMg
b24gdGhlIFNPQyIgLg0KDQpUbyBhbnN3ZXIgdGhlIHF1ZXN0aW9uICJkb2Vzbid0IHN5bm9wc3lz
IHByb3ZpZGUgdGhlaXIgb3duIHNldCBvZg0KcmVnaXN0ZXJzIiwgd2UgcHJvdmlkZSByZWdpc3Rl
cnMgaW4gb3VyIFVTQiBjb3JlcyB0byBhY2Nlc3MgdGhlIFBIWXMNCnRocm91Z2ggSTJDLCBVTFBJ
L1VUTUksIG9yIFBJUEUzIGludGVyZmFjZXMuIEJ1dCBpZiBzb21lb25lIHdhbnRzIHRvIHVzZQ0K
b3VyIFBIWSB3aXRoIHNvbWUgb3RoZXIgY29udHJvbGxlciB0aGF0IGRvZXNuJ3QgcHJvdmlkZSB0
aGF0LCB0aGVuIHRoZXkNCm1heSBuZWVkIHRvIGltcGxlbWVudCB0aGVpciBvd24gcmVnaXN0ZXIg
c2V0LCBhcyBRdWFsY29tbSBoYXMgYXBwYXJlbnRseQ0KZG9uZS4NCg0KLS0gDQpQYXVsDQoNCg==
