From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
Date: Fri, 13 Mar 2015 08:13:02 -0700
Message-ID: <20150313151301.GJ5264@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-7-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1426162154-8716-7-git-send-email-eliad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eliad Peller <eliad@wizery.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-wireless@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Luciano Coelho <luca@coelho.fi>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBFbGlhZCBQZWxsZXIgPGVsaWFkQHdpemVyeS5jb20+IFsxNTAzMTIgMDU6MTBdOgo+IE5vdyB0
aGF0IHdlIGhhdmUgd2xjb3JlIGRldmljZS10cmVlIGJpbmRpbmdzIGluIHBsYWNlCj4gKGZvciBi
b3RoIHdsMTJ4eCBhbmQgd2wxOHh4KSwgcmVtb3ZlIHRoZSBsZWdhY3kKPiB3bDEyeHhfcGxhdGZv
cm1fZGF0YSBzdHJ1Y3QsIGFuZCBtb3ZlIGl0cyBtZW1iZXJzCj4gaW50byB0aGUgcGxhdGZvcm0g
ZGV2aWNlIGRhdGEgKHRoYXQgaXMgcGFzc2VkIHRvIHdsY29yZSkKPiAKPiBEYXZpbmNpIDg1MCBp
cyB0aGUgb25seSBwbGF0Zm9ybSB0aGF0IHN0aWxsIHNldAo+IHRoZSBwbGF0Zm9ybSBkYXRhIGlu
IHRoZSBsZWdhY3kgd2F5IChhbmQgZG9lc24ndAo+IGhhdmUgRFQgYmluZGluZ3MpLCBzbyByZW1v
dmUgdGhlIHJlbGV2YW50Cj4gY29kZS9LY29uZmlnIG9wdGlvbiBmcm9tIHRoZSBib2FyZCBmaWxl
IChhcyBzdWdnZXN0ZWQKPiBieSBTZWtoYXIgTm9yaSkKPiAKPiBTaWduZWQtb2ZmLWJ5OiBMdWNp
YW5vIENvZWxobyA8bHVjYUBjb2VsaG8uZmk+Cj4gU2lnbmVkLW9mZi1ieTogRWxpYWQgUGVsbGVy
IDxlbGlhZEB3aXplcnkuY29tPgo+IC0tLQo+ICBhcmNoL2FybS9tYWNoLWRhdmluY2kvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgIHwgIDExIC0tLQo+ICBhcmNoL2FybS9tYWNoLWRhdmluY2kvYm9h
cmQtZGE4NTAtZXZtLmMgICAgICAgIHwgMTEzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2lsaW5rX3BsYXRmb3JtX2RhdGEuYyB8ICAyNSAtLS0t
LS0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2wxMnh4L21haW4uYyAgICAgICAgICB8ICAx
OSArKy0tLQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy90aS93bGNvcmUvYm9vdC5jICAgICAgICAg
IHwgICAxIC0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2xjb3JlL21haW4uYyAgICAgICAg
ICB8ICAgNCArLQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy90aS93bGNvcmUvc2Rpby5jICAgICAg
ICAgIHwgIDc1ICsrKysrLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2xj
b3JlL3dsY29yZV9pLmggICAgICB8ICAgOCArLQo+ICBpbmNsdWRlL2xpbnV4L3dsMTJ4eC5oICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDI1IC0tLS0tLQo+ICA5IGZpbGVzIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDI0NSBkZWxldGlvbnMoLSkKCkkgZ290IGEgYnVpbGQgZXJyb3IgcmVs
YXRlZCB0byB0aGUgU1BJIGRyaXZlciB3aXRoIHRoaXMgc2VyaWVzLCBwcm9iYWJseQpuZWVkIHRv
IHVwZGF0ZSB0aGlzIHBhdGNoOgoKZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2xjb3JlL3NwaS5j
OiBJbiBmdW5jdGlvbiDigJh3bDEyNzFfcHJvYmXigJk6CmRyaXZlcnMvbmV0L3dpcmVsZXNzL3Rp
L3dsY29yZS9zcGkuYzozMzQ6MTE6IGVycm9yOiDigJhzdHJ1Y3Qgd2xjb3JlX3BsYXRkZXZfZGF0
YeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHBkYXRh4oCZCiAgcGRldl9kYXRhLnBkYXRhID0g
ZGV2X2dldF9wbGF0ZGF0YSgmc3BpLT5kZXYpOwogICAgICAgICAgIF4KZHJpdmVycy9uZXQvd2ly
ZWxlc3MvdGkvd2xjb3JlL3NwaS5jOjMzNToxNjogZXJyb3I6IOKAmHN0cnVjdCB3bGNvcmVfcGxh
dGRldl9kYXRh4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYcGRhdGHigJkKICBpZiAoIXBkZXZf
ZGF0YS5wZGF0YSkgewoKUmVnYXJkcywKClRvbnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
