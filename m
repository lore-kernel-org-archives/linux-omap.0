From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan
 clocks
Date: Fri, 1 Jun 2018 12:18:37 +0530
Message-ID: <d7532c7a-d2ae-5cbf-cfd0-c347b975ed6b@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
 <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
 <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiBUaHVyc2RheSAzMSBNYXkgMjAxOCAwNjo1OSBQTSwgVGVybyBLcmlzdG8gd3JvdGU6
Cj4gT24gMzEvMDUvMTggMTM6MTQsIEZhaXogQWJiYXMgd3JvdGU6Cj4+IEhpLAo+Pgo+PiBPbiBU
aHVyc2RheSAzMSBNYXkgMjAxOCAwOTozMyBBTSwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4+PiBPbiBX
ZWQsIE1heSAzMCwgMjAxOCBhdCAwNzo0MTozMFBNICswNTMwLCBGYWl6IEFiYmFzIHdyb3RlOgo+
Pj4+IEFkZCBjbGtjdHJsIGRhdGEgZm9yIHRoZSBtX2NhbiBjbG9ja3MgYW5kIHJlZ2lzdGVyIGl0
IHdpdGhpbiB0aGUKPj4gLi4uCj4+Pj4gwqAgZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svZHJhNy5oCj4+Pj4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2RyYTcuaAo+
Pj4+IGluZGV4IDVlMTA2MWIxNWFlZC4uZDc1NDljNTdjYWMzIDEwMDY0NAo+Pj4+IC0tLSBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZHJhNy5oCj4+Pj4gKysrIGIvaW5jbHVkZS9kdC1iaW5k
aW5ncy9jbG9jay9kcmE3LmgKPj4+PiBAQCAtMTY4LDUgKzE2OCw2IEBACj4+Pj4gwqAgI2RlZmlu
ZSBEUkE3X0NPVU5URVJfMzJLX0NMS0NUUkzCoMKgwqAgRFJBN19DTEtDVFJMX0lOREVYKDB4NTAp
Cj4+Pj4gwqAgI2RlZmluZSBEUkE3X1VBUlQxMF9DTEtDVFJMwqDCoMKgIERSQTdfQ0xLQ1RSTF9J
TkRFWCgweDgwKQo+Pj4+IMKgICNkZWZpbmUgRFJBN19EQ0FOMV9DTEtDVFJMwqDCoMKgIERSQTdf
Q0xLQ1RSTF9JTkRFWCgweDg4KQo+Pj4+ICsjZGVmaW5lIERSQTdfQURDX0NMS0NUUkzCoMKgwqAg
RFJBN19DTEtDVFJMX0lOREVYKDB4YTApCj4+Pgo+Pj4gQURDIGFuZCBtY2FuIGFyZSB0aGUgc2Ft
ZSB0aGluZz8KPj4+Cj4+Cj4+IFRoZSByZWdpc3RlciB0byBjb250cm9sIE1DQU4gY2xvY2tzIGlz
IGNhbGxlZCBBRENfQ0xLQ1RSTCwgWWVzLgo+IAo+IElzIHRoZXJlIGFueSByZWFzb24gZm9yIHRo
aXMgb3IgaXMgdGhhdCBqdXN0IGEgZG9jdW1lbnRhdGlvbiBidWc/Cj4gCgpMb29rcyBsaWtlIHRo
ZXkgbWVhbnQgdG8gaGF2ZSBhbiBBREMgaW4gZHJhNzQgb3IgZHJhNzIgYnV0IGRlY2lkZWQKYWdh
aW5zdCBpdCBhbmQgdGhlbiBtYW55IHllYXJzIGxhdGVyIHVzZWQgdGhlIHNhbWUgcmVnaXN0ZXJz
IGZvciBNQ0FOCmluc3RlYWQuIFlvdSBjYW4gc2VlIEFEQ19DTEtDVFJMIGV4aXN0cyBpbiBkcmE3
MiBUUk0gYnV0IGlzIGV4cGxpY2l0bHkKZGlzYWJsZWQuCgpodHRwOi8vd3d3LnRpLmNvbS9saXQv
dWcvc3BydWljMmIvc3BydWljMmIucGRmIHBnOjE1MjQKCgpUaGFua3MsCkZhaXoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
