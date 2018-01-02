From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
Date: Tue, 2 Jan 2018 11:01:59 -0800
Message-ID: <20180102190159.GH7997@codeaurora.org>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
 <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: linux-mips@linux-mips.org, mturquette@baylibre.com, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>, linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gMTIvMzEsIEJyeWFuIE8nRG9ub2dodWUgd3JvdGU6Cj4gT24gMzAvMTIvMTcgMTY6MzYsIE1p
a2tvIFBlcnR0dW5lbiB3cm90ZToKPiA+RldJVywgd2UgaGFkIHRoaXMgcHJvYmxlbSBzb21lIHll
YXJzIGFnbyB3aXRoIHRoZSBUZWdyYSBDUFUgY2xvY2sKPiA+LSB0aGVuIGl0IHdhcyBkZXRlcm1p
bmVkIHRoYXQgYSBzaW1wbGVyIHNvbHV0aW9uIHdhcyB0byBoYXZlIHRoZQo+ID5kZXRlcm1pbmVf
cmF0ZSBjYWxsYmFjayBzdXBwb3J0IHVuc2lnbmVkIGxvbmcgcmF0ZXMgLSBzbyBjbG9jawo+ID5k
cml2ZXJzIHRoYXQgbmVlZCB0byByZXR1cm4gcmF0ZXMgaGlnaGVyIHRoYW4gMl4zMSBjYW4gaW5z
dGVhZAo+ID5pbXBsZW1lbnQgdGhlIGRldGVybWluZV9yYXRlIGNhbGxiYWNrLiBUaGF0IGlzIHdo
YXQncyBjdXJyZW50bHkKPiA+aW1wbGVtZW50ZWQuCj4gPgo+ID5NaWtrbwo+IAo+IEdyYW50ZWQg
d2UgY291bGQgd29yayBhcm91bmQgaXQgYnV0LCBoYXZpbmcgYm90aCB6ZXJvIGFuZCBsZXNzIHRo
YW4KPiB6ZXJvIGluZGljYXRlIGVycm9yIG1lYW5zIHlvdSBjYW4ndCBzdXBwb3J0IGxhcmdlciB0
aGFuIExPTkdfTUFYCj4gd2hpY2ggaXMgSSB0aGluayB3b3J0aCBmaXhpbmcuCj4gCgpPay4gQnV0
IGNhbiB5b3UgaW1wbGVtZW50IHRoZSBkZXRlcm1pbmVfcmF0ZSBvcCBpbnN0ZWFkIG9mIHRoZQpy
b3VuZF9yYXRlIG9wIGZvciB5b3VyIGNsaz8gSXQncyBub3QgYSB3b3JrLWFyb3VuZCwgaXQncyB0
aGUKcHJlZmVycmVkIHNvbHV0aW9uLiBUaGF0IHdvdWxkIGFsbG93IHJhdGVzIGxhcmdlciB0aGFu
IDJeMzEgZm9yCnRoZSBjbGsgd2l0aG91dCBwdXNoaW5nIHRocm91Z2ggYSBjaGFuZ2UgdG8gYWxs
IHRoZSBkcml2ZXJzIHRvCmV4cHJlc3MgemVybyBhcyAiZXJyb3IiIGFuZCBub24temVybyBhcyB0
aGUgcm91bmRlZCByYXRlLgoKSSdtIG5vdCBlbnRpcmVseSBvcHBvc2VkIHRvIHRoaXMgYXBwcm9h
Y2gsIGJlY2F1c2Ugd2UgcHJvYmFibHkKZG9uJ3QgY2FyZSB0byBwYXNzIHRoZSBwYXJ0aWN1bGFy
IGVycm9yIHZhbHVlIGZyb20gYSBjbGsgcHJvdmlkZXIKdG8gYSBjbGsgY29uc3VtZXIgYWJvdXQg
d2hhdCB0aGUgZXJyb3IgaXMuIEl0J3MgYWN0dWFsbHkgd2hhdCB3ZQpwcm9wb3NlZCBhcyB0aGUg
c29sdXRpb24gZm9yIGNsa19yb3VuZF9yYXRlKCkgdG8gcmV0dXJuIHZhbHVlcwpsYXJnZXIgdGhh
biBMT05HX01BWCB0byBjb25zdW1lcnMuIEJ1dCBkb2luZyB0aGF0IGNvbnN1bWVyIEFQSQpjaGFu
Z2Ugb3IgdGhpcyBwcm92aWRlciBzaWRlIGNoYW5nZSBpcyBnb2luZyB0byByZXF1aXJlIHVzIHRv
CmV2YWx1YXRlIGFsbCB0aGUgY29uc3VtZXJzIG9mIHRoZXNlIGNsa3MgdG8gbWFrZSBzdXJlIHRo
ZXkgZG9uJ3QKY2hlY2sgZm9yIHNvbWUgZXJyb3IgdmFsdWUgdGhhdCdzIGxlc3MgdGhhbiB6ZXJv
LiBUaGlzIHNlcmllcwpkb2VzIGhhbGYgdGhlIHdvcmssIGJ5IGNoYW5naW5nIHRoZSBwcm92aWRl
ciBzaWRlLCB3aGlsZSBpZ25vcmluZwp0aGUgY29uc3VtZXIgc2lkZSBhbmQgYW55IHBvdGVudGlh
bCBmYWxsb3V0IG9mIHRoZSBsZXNzIHRoYW4gemVybwp0byB6ZXJvIHJldHVybiB2YWx1ZSBjaGFu
Z2UuCgotLSAKUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIgb2Yg
Q29kZSBBdXJvcmEgRm9ydW0sCmEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2pl
Y3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
