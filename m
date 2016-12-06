From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 01/12] phy: rcar-gen3-usb2: Replace the deprecated extcon
 API
Date: Tue, 06 Dec 2016 09:25:25 +0900
Message-ID: <58460575.8030008@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161130055741epcas1p36e85f3cae0322b7382471a963a9b2bca@epcas1p3.samsung.com>
 <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, linux-pm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, wens@csie.org, chanwoo@kernel.org, maxime.ripard@free-electrons.com, linux-omap@vger.kernel.org, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

SGkgS2lzaG9uLAoKQ291bGQgeW91IHJldmlldyBhbmQgcGljayB0aGUgcGF0Y2gxLzIgZm9yIHBo
eSBkcml2ZXI/CgpCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQoKT24gMjAxNuuFhCAxMeyblCAz
MOydvCAxNDo1NywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IFRoaXMgcGF0Y2ggcmVwbGFjZXMgdGhl
IGRlcHJlY2F0ZWQgZXh0Y29uIEFQSSBhcyBmb2xsb3dpbmc6Cj4gLSBleHRjb25fc2V0X2NhYmxl
X3N0YXRlXygpIC0+IGV4dGNvbl9zZXRfc3RhdGVfc3luYygpCj4gCj4gU2lnbmVkLW9mZi1ieTog
Q2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvcGh5
L3BoeS1yY2FyLWdlbjMtdXNiMi5jIHwgOCArKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bo
eS9waHktcmNhci1nZW4zLXVzYjIuYyBiL2RyaXZlcnMvcGh5L3BoeS1yY2FyLWdlbjMtdXNiMi5j
Cj4gaW5kZXggYmQyNDMwZDczMzljLi43ZjgwODFmMTU3ZjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9waHkvcGh5LXJjYXItZ2VuMy11c2IyLmMKPiArKysgYi9kcml2ZXJzL3BoeS9waHktcmNhci1n
ZW4zLXVzYjIuYwo+IEBAIC05MywxMSArOTMsMTEgQEAgc3RhdGljIHZvaWQgcmNhcl9nZW4zX3Bo
eV91c2IyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAJCQkJCQkgd29yayk7Cj4g
IAo+ICAJaWYgKGNoLT5leHRjb25faG9zdCkgewo+IC0JCWV4dGNvbl9zZXRfY2FibGVfc3RhdGVf
KGNoLT5leHRjb24sIEVYVENPTl9VU0JfSE9TVCwgdHJ1ZSk7Cj4gLQkJZXh0Y29uX3NldF9jYWJs
ZV9zdGF0ZV8oY2gtPmV4dGNvbiwgRVhUQ09OX1VTQiwgZmFsc2UpOwo+ICsJCWV4dGNvbl9zZXRf
c3RhdGVfc3luYyhjaC0+ZXh0Y29uLCBFWFRDT05fVVNCX0hPU1QsIHRydWUpOwo+ICsJCWV4dGNv
bl9zZXRfc3RhdGVfc3luYyhjaC0+ZXh0Y29uLCBFWFRDT05fVVNCLCBmYWxzZSk7Cj4gIAl9IGVs
c2Ugewo+IC0JCWV4dGNvbl9zZXRfY2FibGVfc3RhdGVfKGNoLT5leHRjb24sIEVYVENPTl9VU0Jf
SE9TVCwgZmFsc2UpOwo+IC0JCWV4dGNvbl9zZXRfY2FibGVfc3RhdGVfKGNoLT5leHRjb24sIEVY
VENPTl9VU0IsIHRydWUpOwo+ICsJCWV4dGNvbl9zZXRfc3RhdGVfc3luYyhjaC0+ZXh0Y29uLCBF
WFRDT05fVVNCX0hPU1QsIGZhbHNlKTsKPiArCQlleHRjb25fc2V0X3N0YXRlX3N5bmMoY2gtPmV4
dGNvbiwgRVhUQ09OX1VTQiwgdHJ1ZSk7Cj4gIAl9Cj4gIH0KPiAgCj4gCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
