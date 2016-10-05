From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Wed, 5 Oct 2016 09:31:23 +0300
Message-ID: <de6bbf1c-e9e2-83b1-73c2-49aa64cc939c@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
 <20161003130318.12591-3-mugunthanvnm@ti.com>
 <0ff2c6ef-3fa1-dc8b-fb6e-1a4dcfea8ea9@ti.com>
 <e9c3108e-ffd1-472a-a2d3-2948665de217@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e9c3108e-ffd1-472a-a2d3-2948665de217@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "Andrew F . Davis" <afd@ti.com>, John Syne <john3909@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gMTAvMDUvMTYgMDk6MjEsIE11Z3VudGhhbiBWIE4gd3JvdGU6Cj4gT24gVHVlc2RheSAwNCBP
Y3RvYmVyIDIwMTYgMDI6MDIgUE0sIFBldGVyIFVqZmFsdXNpIHdyb3RlOgo+PiBPbiAxMC8wMy8x
NiAxNjowMywgTXVndW50aGFuIFYgTiB3cm90ZToKPj4+ICtzdGF0aWMgaW50IHRpYWRjX3JlcXVl
c3RfZG1hKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCj4+PiArCQkJICAgICBzdHJ1Y3Qg
dGlhZGNfZGV2aWNlICphZGNfZGV2KQo+Pj4gK3sKPj4+ICsJc3RydWN0IHRpYWRjX2RtYQkqZG1h
ID0gJmFkY19kZXYtPmRtYTsKPj4+ICsJZG1hX2NhcF9tYXNrX3QJCW1hc2s7Cj4+PiArCj4+PiAr
CS8qIERlZmF1bHQgc2xhdmUgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzICovCj4+PiArCWRtYS0+
Y29uZi5kaXJlY3Rpb24gPSBETUFfREVWX1RPX01FTTsKPj4+ICsJZG1hLT5jb25mLnNyY19hZGRy
X3dpZHRoID0gRE1BX1NMQVZFX0JVU1dJRFRIXzJfQllURVM7Cj4+PiArCWRtYS0+Y29uZi5zcmNf
YWRkciA9IGFkY19kZXYtPm1mZF90c2NhZGMtPnRzY2FkY19waHlzX2Jhc2UgKyBSRUdfRklGTzE7
Cj4+PiArCj4+PiArCWRtYV9jYXBfemVybyhtYXNrKTsKPj4+ICsJZG1hX2NhcF9zZXQoRE1BX0NZ
Q0xJQywgbWFzayk7Cj4+PiArCj4+PiArCS8qIEdldCBhIGNoYW5uZWwgZm9yIFJYICovCj4+PiAr
CWRtYS0+Y2hhbiA9IGRtYV9yZXF1ZXN0X2NoYW4oYWRjX2Rldi0+bWZkX3RzY2FkYy0+ZGV2LCAi
ZmlmbzEiKTsKPj4+ICsJaWYgKCFkbWEtPmNoYW4pCj4+PiArCQlyZXR1cm4gLUVOT0RFVjsKPj4K
Pj4gZG1hX3JlcXVlc3RfY2hhbigpIEVSUl9QVFIgaW4gY2FzZSBvZiBmYWlsdXJlLCBuZXZlciBO
VUxMLiBZb3Ugc2hvdWxkIHJldXNlCj4+IHRoZSByZXR1cm5lZCBlcnJvciBjb2RlIHRvIHN1cHBv
cnQgZGVmZXJyZWQgcHJvYmluZy4KPiAKPiBXaWxsIGZpeCB0aGlzIGluIHYzLgo+IAo+Pgo+Pj4g
Kwo+Pj4gKwkvKiBSWCBidWZmZXIgKi8KPj4+ICsJZG1hLT5idWYgPSBkbWFfYWxsb2NfY29oZXJl
bnQoZG1hLT5jaGFuLT5kZXZpY2UtPmRldiwgRE1BX0JVRkZFUl9TSVpFLAo+Pj4gKwkJCQkgICAg
ICAmZG1hLT5hZGRyLCBHRlBfS0VSTkVMKTsKPj4+ICsJaWYgKCFkbWEtPmJ1ZikKPj4+ICsJCWdv
dG8gZXJyOwo+Pj4gKwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICtlcnI6Cj4+PiArCWRtYV9yZWxlYXNl
X2NoYW5uZWwoZG1hLT5jaGFuKTsKPj4+ICsKPj4+ICsJcmV0dXJuIC1FTk9NRU07Cj4+PiArfQo+
Pj4gKwo+Pj4gIHN0YXRpYyBpbnQgdGlhZGNfcGFyc2VfZHQoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiwKPj4+ICAJCQkgIHN0cnVjdCB0aWFkY19kZXZpY2UgKmFkY19kZXYpCj4+PiAgewo+
Pj4gQEAgLTUxMiw4ICs2MzksMTQgQEAgc3RhdGljIGludCB0aWFkY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4gIAo+Pj4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBpbmRpb19kZXYpOwo+Pj4gIAo+Pj4gKwllcnIgPSB0aWFkY19yZXF1ZXN0X2RtYShwZGV2LCBh
ZGNfZGV2KTsKPj4+ICsJaWYgKGVyciAmJiBlcnIgIT0gLUVOT0RFVikKPj4+ICsJCWdvdG8gZXJy
X2RtYTsKPj4KPj4gWW91IHNob3VsZCBoYW5kbGUgdGhlIGRlZmVycmVkIHByb2JpbmcgZm9yIERN
QSBjaGFubmVsLgo+IAo+ICsJZG1hLT5jaGFuID0gZG1hX3JlcXVlc3RfY2hhbihhZGNfZGV2LT5t
ZmRfdHNjYWRjLT5kZXYsICJmaWZvMSIpOwo+ICsJaWYgKElTX0VSUihkbWEtPmNoYW4pKSB7Cj4g
KwkJaW50IHJldCA9IFBUUl9FUlIoZG1hLT5jaGFuKTsKPiArCj4gKwkJZG1hLT5jaGFuID0gTlVM
TDsKPiArCQlyZXR1cm4gcmV0OwoKWW91IGRvbid0IG5lZWQgdGhlICdyZXQnIHZhcmlhYmxlOgoJ
CXJldHVybiBQVFJfRVJSKGRtYS0+Y2hhbik7Cgo+ICsJfQo+IAo+IFdpdGggdGhpcyBwcm9iZSBk
ZWZlciB3aWxsIGJlIHRha2VuIGNhcmUgYW5kIEFEQyB3aWxsIGNvbnRpbnVlIHdpdGhvdXQKPiBE
TUEgd2hlbiByZXF1ZXN0IGNoYW5uZWwgcmV0dXJucyAtRU5PREVWLgoKSSB3b3VsZCByYXRoZXIg
aGF2ZSBleHBsaWNpdCBjaGVjayBmb3IgZGVmZXJyZWQgcHJvYmU6CgplcnIgPSB0aWFkY19yZXF1
ZXN0X2RtYShwZGV2LCBhZGNfZGV2KTsKaWYgKGVyciAmJiBlcnIgPT0gLUVQUk9CRV9ERUZFUikK
CWdvdG8gZXJyX2RtYTsKCgotLSAKUMOpdGVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
