From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [RESEND PATCH v3 2/2] phy: Group vendor specific phy drivers
Date: Wed, 15 Mar 2017 20:21:55 +0530
Message-ID: <CAFp+6iGO=zPFq7dLupPa6XitBmFOj+tk75CtQGfm8h1yKJjeEA@mail.gmail.com>
References: <1489472080-23711-2-git-send-email-vivek.gautam@codeaurora.org>
 <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
 <2492681.1VCl1nfEs0@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2492681.1VCl1nfEs0@diego>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-renesas-soc@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, kishon <kishon@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

T24gV2VkLCBNYXIgMTUsIDIwMTcgYXQgMTozOCBQTSwgSGVpa28gU3TDvGJuZXIgPGhlaWtvQHNu
dGVjaC5kZT4gd3JvdGU6Cj4gQW0gRGllbnN0YWcsIDE0LiBNw6RyeiAyMDE3LCAxMTo1Mjo1MCBD
RVQgc2NocmllYiBWaXZlayBHYXV0YW06Cj4+IEFkZGluZyB2ZW5kb3Igc3BlY2lmaWMgZGlyZWN0
b3JpZXMgaW4gcGh5IHRvIGdyb3VwCj4+IHBoeSBkcml2ZXJzIHVuZGVyIHRoZWlyIHJlc3BlY3Rp
dmUgdmVuZG9yIHVtYnJlbGxhLgo+Pgo+PiBBbHNvIHVwZGF0ZWQgdGhlIE1BSU5UQUlORVJTIGZp
bGUgdG8gcmVmbGVjdCB0aGUgY29ycmVjdAo+PiBkaXJlY3Rvcnkgc3RydWN0dXJlIGZvciBwaHkg
ZHJpdmVycy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogVml2ZWsgR2F1dGFtIDx2aXZlay5nYXV0YW1A
Y29kZWF1cm9yYS5vcmc+Cj4+IEFja2VkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNo
LmRlPgo+PiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4K
Pj4gQ2M6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+Cj4+IENjOiBEYXZp
ZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Cj4+IENjOiBHZWVydCBVeXR0ZXJob2V2
ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPgo+PiBDYzogWW9zaGloaXJvIFNoaW1vZGEgPHlv
c2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPgo+PiBDYzogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pgo+PiBDYzogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4K
Pj4gQ2M6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Cj4+IENjOiBNYXhp
bWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGZyZWUtZWxlY3Ryb25zLmNvbT4KPj4gQ2M6IENoZW4t
WXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4KPj4gQ2M6IFN5bHdlc3RlciBOYXdyb2NraSA8cy5uYXdy
b2NraUBzYW1zdW5nLmNvbT4KPj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4KPj4gQ2M6IEphZWhvb24gQ2h1bmcgPGpoODAuY2h1bmdAc2Ftc3VuZy5jb20+Cj4+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gQ2M6IGxpbnV4LWFybS1t
c21Admdlci5rZXJuZWwub3JnCj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+
IENjOiBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9yZwo+PiBDYzogbGludXgtcmVuZXNhcy1zb2NA
dmdlci5rZXJuZWwub3JnCj4+IENjOiBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cj4+IENjOiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPj4gQ2M6IGxpbnV4LXVz
YkB2Z2VyLmtlcm5lbC5vcmcKPj4gLS0tCj4+Cj4+IENvcnJlY3RlZCBLcnp5c3p0b2YncyBlbWFp
bC1pZC4gQWRkZWQgbGludXgtYXJtLW1zbS4KPj4KPj4gSGkgSGVpa28sIFZpcmVzaCwKPj4gSXQn
cyBiZWVuIGEgeWVhciBzaW5jZSB0aGUgbGFzdCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggd2FzIHBv
c3RlZC4KPj4gS2lzaG9uIGhhcyBhZ3JlZWQgdG8gcHVsbCB0aGlzIGNoYW5nZSBub3cuIEkgYW0g
Y2FycnlpbmcgZm9yd2FyZAo+PiB5b3VyIEFja3Mgc2luY2UgdGhlcmUgYXJlIG5vIGZ1bmN0aW9u
YWwgY2hhbmdlcy4KPj4gSSBoYXZlIHRha2VuIGNhcmUgb2YgdGhlIGRyaXZlcnMgdGhhdCB3ZXJl
IGFkZGVkL3JlbW92ZWQgc2luY2UKPj4gdGhlIGxhc3QgdmVyc2lvbi4KPj4gUGxlYXNlIGZlZWwg
ZnJlZSB0byBqdW1wIGluIGlmIHlvdSBoYXZlIGFueSBjb25jZXJucy4KPgo+IHN0aWxsIGxvb2tz
IGFsbCBnb29kIGFuZCBJIGdhdmUgdGhhdCBhIHRyeSBvbiA0LjExLXJjMiB5ZXN0ZXJkYXkgYXMg
d2VsbC4KClRoYW5rcyBIZWlrbyBmb3IgdGVzdGluZyB0aGlzIHBhdGNoLgoKQmVzdCBSZWdhcmRz
ClZpdmVrCj4KPgo+IEhlaWtvCj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDog
c2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtYXJtLW1zbSIgaW4KPiB0aGUgYm9keSBv
ZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21v
IGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbAoKCgot
LSAKUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIgb2YgQ29kZSBB
dXJvcmEgRm9ydW0sCmEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2plY3QKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
