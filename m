From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
Date: Wed, 26 Oct 2016 13:17:30 +0100
Message-ID: <20161026121730.GS8574@dell>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com>
 <20160927194045.GK21388@dell>
 <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "Andrew F . Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gRnJpLCAzMCBTZXAgMjAxNiwgTXVndW50aGFuIFYgTiB3cm90ZToKCj4gT24gV2VkbmVzZGF5
IDI4IFNlcHRlbWJlciAyMDE2IDAxOjEwIEFNLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBPbiBXZWQs
IDIxIFNlcCAyMDE2LCBNdWd1bnRoYW4gViBOIHdyb3RlOgo+ID4gCj4gPj4gc3RvcmUgdGhlIHBo
eXNpY2FsIGFkZHJlc3Mgb2YgdGhlIGRldmljZSBpbiBpdHMgcHJpdiB0byB1c2UgaXQKPiA+PiBm
b3IgRE1BIGFkZHJlc3NpbmcgaW4gdGhlIGNsaWVudCBkcml2ZXJzLgo+ID4+Cj4gPj4gU2lnbmVk
LW9mZi1ieTogTXVndW50aGFuIFYgTiA8bXVndW50aGFudm5tQHRpLmNvbT4KPiA+PiAtLS0KPiA+
PiAgZHJpdmVycy9tZmQvdGlfYW0zMzV4X3RzY2FkYy5jICAgICAgIHwgMSArCj4gPj4gIGluY2x1
ZGUvbGludXgvbWZkL3RpX2FtMzM1eF90c2NhZGMuaCB8IDEgKwo+ID4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3Rp
X2FtMzM1eF90c2NhZGMuYyBiL2RyaXZlcnMvbWZkL3RpX2FtMzM1eF90c2NhZGMuYwo+ID4+IGlu
ZGV4IGM4ZjAyN2IuLjBmM2ZhYjQgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9tZmQvdGlfYW0z
MzV4X3RzY2FkYy5jCj4gPj4gKysrIGIvZHJpdmVycy9tZmQvdGlfYW0zMzV4X3RzY2FkYy5jCj4g
Pj4gQEAgLTE4Myw2ICsxODMsNyBAQCBzdGF0aWMJaW50IHRpX3RzY2FkY19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4+ICAJCXRzY2FkYy0+aXJxID0gZXJyOwo+ID4+ICAK
PiA+PiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwg
MCk7Cj4gPj4gKwl0c2NhZGMtPnRzY2FkY19waHlzX2Jhc2UgPSByZXMtPnN0YXJ0Owo+ID4gCj4g
PiBUaGlzIGlzIHVudXN1YWwuICBDYW4ndCB5b3UgdXNlIGEgdmlydF90b19waHlzKCkgdmFyaWFu
dCBpbnN0ZWFkPwo+ID4gCj4gCj4gSSB0cmllZCB1c2luZyB2aXJ0X3RvX3BoeXMoKSwgYnV0IGl0
cyBub3Qgd29ya2luZyBmb3IgbWUuCj4gQWxzbyBzYXcgbWFueSBkcml2ZXJzIHVzZXMgbGlrZSB0
aGlzIHRvIGdldCBwaHlzaWNhbCBhZGRyZXNzCj4gKCJnaXQgZ3JlcCAtbiAiIHJlcy0+c3RhcnQ7
IiBkcml2ZXJzLyoiKS4KClZlcnkgd2VsbDoKCkZvciBteSBvd24gcmVmZXJlbmNlOgogIEFja2Vk
LWZvci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpMZXQgbWUga25v
dyBob3cgeW91IHdpc2ggdGhpcyBzZXQgdG8gYmUgaGFuZGxlZC4KCi0tIApMZWUgSm9uZXMKTGlu
YXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sg
fCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
