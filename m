From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan
 clocks
Date: Mon, 4 Jun 2018 19:28:01 +0530
Message-ID: <6df7e0cd-5574-aa19-6c99-4438e5e377e0@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
 <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
 <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
 <d7532c7a-d2ae-5cbf-cfd0-c347b975ed6b@ti.com>
 <20180601142613.GU5705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180601142613.GU5705@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, paul@pwsan.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiBGcmlkYXkgMDEgSnVuZSAyMDE4IDA3OjU2IFBNLCBUb255IExpbmRncmVuIHdyb3Rl
Ogo+ICogRmFpeiBBYmJhcyA8ZmFpel9hYmJhc0B0aS5jb20+IFsxODA2MDEgMDY6NDldOgo+PiBI
aSwKPj4KPj4gT24gVGh1cnNkYXkgMzEgTWF5IDIwMTggMDY6NTkgUE0sIFRlcm8gS3Jpc3RvIHdy
b3RlOgo+Pj4gT24gMzEvMDUvMTggMTM6MTQsIEZhaXogQWJiYXMgd3JvdGU6Cj4+Pj4gSGksCj4+
Pj4KPj4+PiBPbiBUaHVyc2RheSAzMSBNYXkgMjAxOCAwOTozMyBBTSwgUm9iIEhlcnJpbmcgd3Jv
dGU6Cj4+Pj4+IE9uIFdlZCwgTWF5IDMwLCAyMDE4IGF0IDA3OjQxOjMwUE0gKzA1MzAsIEZhaXog
QWJiYXMgd3JvdGU6Cj4+Pj4+PiBBZGQgY2xrY3RybCBkYXRhIGZvciB0aGUgbV9jYW4gY2xvY2tz
IGFuZCByZWdpc3RlciBpdCB3aXRoaW4gdGhlCj4+Pj4gLi4uCj4+Pj4+PiDCoCBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9kcmE3LmgKPj4+Pj4+IGIvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9kcmE3LmgKPj4+Pj4+IGluZGV4IDVlMTA2MWIxNWFlZC4uZDc1NDljNTdj
YWMzIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9kcmE3LmgK
Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZHJhNy5oCj4+Pj4+PiBAQCAt
MTY4LDUgKzE2OCw2IEBACj4+Pj4+PiDCoCAjZGVmaW5lIERSQTdfQ09VTlRFUl8zMktfQ0xLQ1RS
TMKgwqDCoCBEUkE3X0NMS0NUUkxfSU5ERVgoMHg1MCkKPj4+Pj4+IMKgICNkZWZpbmUgRFJBN19V
QVJUMTBfQ0xLQ1RSTMKgwqDCoCBEUkE3X0NMS0NUUkxfSU5ERVgoMHg4MCkKPj4+Pj4+IMKgICNk
ZWZpbmUgRFJBN19EQ0FOMV9DTEtDVFJMwqDCoMKgIERSQTdfQ0xLQ1RSTF9JTkRFWCgweDg4KQo+
Pj4+Pj4gKyNkZWZpbmUgRFJBN19BRENfQ0xLQ1RSTMKgwqDCoCBEUkE3X0NMS0NUUkxfSU5ERVgo
MHhhMCkKPj4+Pj4KPj4+Pj4gQURDIGFuZCBtY2FuIGFyZSB0aGUgc2FtZSB0aGluZz8KPj4+Pj4K
Pj4+Pgo+Pj4+IFRoZSByZWdpc3RlciB0byBjb250cm9sIE1DQU4gY2xvY2tzIGlzIGNhbGxlZCBB
RENfQ0xLQ1RSTCwgWWVzLgo+Pj4KPj4+IElzIHRoZXJlIGFueSByZWFzb24gZm9yIHRoaXMgb3Ig
aXMgdGhhdCBqdXN0IGEgZG9jdW1lbnRhdGlvbiBidWc/Cj4+Pgo+Pgo+PiBMb29rcyBsaWtlIHRo
ZXkgbWVhbnQgdG8gaGF2ZSBhbiBBREMgaW4gZHJhNzQgb3IgZHJhNzIgYnV0IGRlY2lkZWQKPj4g
YWdhaW5zdCBpdCBhbmQgdGhlbiBtYW55IHllYXJzIGxhdGVyIHVzZWQgdGhlIHNhbWUgcmVnaXN0
ZXJzIGZvciBNQ0FOCj4+IGluc3RlYWQuIFlvdSBjYW4gc2VlIEFEQ19DTEtDVFJMIGV4aXN0cyBp
biBkcmE3MiBUUk0gYnV0IGlzIGV4cGxpY2l0bHkKPj4gZGlzYWJsZWQuCj4+Cj4+IGh0dHA6Ly93
d3cudGkuY29tL2xpdC91Zy9zcHJ1aWMyYi9zcHJ1aWMyYi5wZGYgcGc6MTUyNAo+IAo+IEhvdyBh
Ym91dCBtYWtlIGFkZCBhbHNvIHNvbWV0aGluZyBsaWtlIHRvIGRyYTcuaDoKPiAKPiAjZGVmaW5l
IERSQTdfTUNBTl9DTEtDVFJMIERSQTdfQURDX0NMS0NUUkwKPiAKPiBBbmQgeW91IGNhbiBhZGQg
YSBjb21tZW50IHRvIHRoZSBkdHMgZmlsZSB0byBhdm9pZCBwZW9wbGUKPiBnZXR0aW5nIGNvbmZ1
c2VkIHdpdGggdGhpcyBjb25zdGFudGx5Lgo+IAoKSSB3b3VsZCBwcmVmZXIgdG8gZm9sbG93IHRo
ZSBUUk0gc28gdGhhdCBwZW9wbGUgZG9uJ3QgbG9vayBmb3IgcmVnaXN0ZXJzCnRoYXQgZG9uJ3Qg
ZXhpc3QgYXQgYWxsLgoKVGhhbmtzLApGYWl6CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
