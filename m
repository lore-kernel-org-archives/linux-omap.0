From: Vignesh R <vigneshr@ti.com>
Subject: Re: 4.16 OMAP serial transmit corruption?
Date: Tue, 17 Apr 2018 14:50:26 +0530
Message-ID: <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416154545.GA5671@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

CgpPbiBNb25kYXkgMTYgQXByaWwgMjAxOCAwOToxNSBQTSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToK
PiAqIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCA8bGludXhAYXJtbGludXgub3JnLnVrPiBbMTgw
NDE2IDE1OjE5XToKPj4gSGksCj4+Cj4+IEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGF0J3MgZ29p
bmcgb24sIGJ1dCBJIHNlZSBjb3JydXB0ZWQgY2hhcmFjdGVycwo+PiB3aXRoIHRoZSBzZXJpYWwg
Y29uc29sZSBvbiB0aGUgT01BUDQ0MzAgU0RQIGJvYXJkLiAgRHVyaW5nIGJvb3QsCj4+IGV2ZXJ5
dGhpbmcgc2VlbXMgZmluZSwgdGhlIHByb2JsZW0gYXBwZWFycyB0byBiZSB1c2Vyc3BhY2Ugb3V0
cHV0Lgo+Pgo+PiBGb3IgZXhhbXBsZSwgaWYgSSBlZGl0IGEgZmlsZSwgdGhlbiBxdWl0IHZpOgo+
Pgo+PiA6ceKWoOKWoCXilqDilqBC4pag4pagWuKWoHJvb3RAb21hcC00NDMwc2RwOn4jCj4gCj4g
SSBkb24ndCB0aGluayBJJ3ZlIHNlZW4gdGhhdCBvbmUuIFdoYXQgSSd2ZSBzZWVuIGZldyB0aW1l
cyBpcwo+IHR5cGluZyBhIGtleSBvbiB0aGUgc2VyaWFsIGNvbnNvbGUgZWNob2luZyBiYWNrIHRo
ZSBwcmV2aW91cwo+IGNoYXJhY3RlciB0eXBlZCB3aGlsZSB0aGUgbmV3IGNoYXJhY3RlciB3b24n
dCBnZXQgZGlzcGxheWVkCj4gdW50aWwgaGl0dGluZyBrZXlib2FyZCBhZ2Fpbi4gT25seSByZWJv
b3RpbmcgdGhlIGRldmljZSBzZWVtcwo+IHRvIHNvbHZlIHRoaXMuIFRoaXMgaXMgd2l0aCA0NDMw
IEVTMi4zIHJldmlzaW9uLgo+IAo+IEkgd29uZGVyIGlmIHdlJ3JlIG1pc3Npbmcgc29tZSBwYXJ0
cyBvZiBlcnJhdGEgaTIwMiBoYW5kbGluZwo+IGluIG9tYXBfODI1MF9tZHIxX2VycmF0YXNldCgp
Pwo+IAo+IEFsc28sIEknbSBzZWVpbmcgYW4gaXNzdWUgd2hlcmUgdGhlIFVBUlRzIHdvbid0IGlk
bGUgb24gaW5pdAo+IHdpdGggODI1MF9vbWFwIGRyaXZlciBpZiBjb25uZWN0ZWQgdG8gdGhlIHds
MTJ4eCBibHVldG9vdGggcG9ydAo+IHVubGVzcyBJIHdyaXRlIHNvbWUgZGF0YSB0byB0aGUgcG9y
dCBmaXJzdC4gSXQgZG9lcyBub3Qgc2VlbQo+IHRvIGJlIHJlbGF0ZWQgdG8gdGhlIHJ0cy9jdHMg
bGluZXMgYmVpbmcgd2lyZWQgYXMgSSd2ZSB0ZXN0ZWQKPiBtdXhpbmcgdGhlbSBvdXQgb2YgdGhl
IHdheS4KPiAKCklmIHRoaXMgaW5zdGFuY2Ugb2YgVUFSVCBpcyB1c2luZyBETUEgdGhlbiBpdCBt
aWdodCBiZSBkdWUgYW4gZXJyYXRhCndvcmtlZCBhcm91bmQgaW4gQU0zMy9BTTQzL0RSQTc6Cmh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvNjc4NDMzMS8KCgotLSAKUmVnYXJkcwpW
aWduZXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
