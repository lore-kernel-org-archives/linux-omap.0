From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3.4-rc4] ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base
 in FIQ handler
Date: Mon, 7 May 2012 15:10:07 -0700
Message-ID: <20120507221007.GN5088@atomide.com>
References: <1335806769-23711-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20120504165948.GC5613@atomide.com> <1470735.vzc89Ry7Ka@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470735.vzc89Ry7Ka@acer>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBKYW51c3ogS3J6eXN6dG9maWsgPGprcnp5c3p0QHRpcy5pY25ldC5wbD4gWzEyMDUwNyAxNDoy
MV06Cj4gRG5pYSBwacSFdGVrLCA0IG1hamEgMjAxMiAwOTo1OTo0OSBUb255IExpbmRncmVuIHBp
c3plOgo+ID4gKiBKYW51c3ogS3J6eXN6dG9maWsgPGprcnp5c3p0QHRpcy5pY25ldC5wbD4gWzEy
MDQzMCAxMDozMF06Cj4gPiA+IENvbW1pdCAzODRlYmUxYzI4NDkxNjBkMDQwZGYzZTY4NjM0ZWM1
MDZmMTNkOWZmLCAiZ3Bpby9vbWFwOiBBZGQgRFQKPiA+ID4gc3VwcG9ydCB0byBHUElPIGRyaXZl
ciIsIGludHJvZHVjZWQgZHluYW1pYyBJUlEgbnVtYmVyaW5nIG9mIE9NQVAgCj4gR1BJTwo+ID4g
PiBpbnRlcnJ1cHRzLCBicmVha2luZyBhbGwgSUhfR1BJT19CQVNFIGJhc2VkIElSUSBudW1iZXIg
Y2FsY3VsYXRpb25zLgo+ID4gPiBUaGlzIGlzc3VlIHdhcyBjb3JyZWN0ZWQgaW4gdGhlIE9NQVAg
R1BJTyBkcml2ZXIgYW5kIHRoZSByZWxhdGVkIAo+IGhlYWRlcgo+ID4gPiBmaWxlIHdpdGggY29t
bWl0IDI1ZGI3MTFkZjMyNThkMTI1ZGMxMjA5ODAwMzE3ZTVjMGVmM2M4NzAsIAo+ICJncGlvL29t
YXA6Cj4gPiA+IEZpeCBJUlEgaGFuZGxpbmcgZm9yIFNQQVJTRV9JUlEiLgo+ID4gPiAKPiA+ID4g
SG93ZXZlciwgdGhlIEFtc3RyYWQgRGVsdGEgRklRIGhhbmRsZXIsIHdoaWNoIHJlcGxhY2VzIHRo
ZSBncGlvLW9tYXAKPiA+ID4gZHJpdmVyIGluIHNlcnZpbmcgR1BJTyBpbnRlcnJ1cHRzIG9uIHRo
aXMgYm9hcmQsIHN0aWxsIHVzZXMgdGhhdAo+ID4gPiBvdXRkYXRlZCBtZXRob2QuIEZpeCBpdC4K
PiA+IAo+ID4gVGhhbmtzIGFwcGx5aW5nIGludG8gZml4ZXMuCj4gCj4gSGkgVG9ueSwKPiBUaGFu
a3MgZm9yIHRha2luZyB0aGlzIHBhdGNoLCBidXQgSSBjYSd0IHNlZSBpdCBhcHBsaWVkIGludG8g
eW91ciBmaXhlcyAKPiBicmFuY2ggKHRoZSBsYXN0IG9uZSBzaXR0aW5nIHRoZXJlIGlzICJMaW51
eCAzLjQtcmM0IiBieSBMaW51cykuIEFtIEkgCj4gbWlzc2luZyBzb21ldGhpbmc/CgpPb3BzLCBz
b3JyeSBmb3Jnb3QgdG8gcHVzaCBpdCBvdXQuIFB1c2hlZCBvdXQgbm93LCBzbyBpdCBzaG91bGQg
YXBwZWFyCm9uIHRoZSBtaXJyb3JzIHNob3J0bHkuCgpUb255CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
