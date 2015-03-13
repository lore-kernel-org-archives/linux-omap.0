From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
Date: Fri, 13 Mar 2015 09:17:18 +0100
Message-ID: <CAFqH_53D52WGDZUTv=w7SguTeROwrzmn9XLB+cTg-3y+Q4FxfQ@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-6-git-send-email-eliad@wizery.com>
 <CABxcv=mETO9ESVa04YjRO1d-h5ksEwvwGKb1G-jxVk6ttr9JYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABxcv=mETO9ESVa04YjRO1d-h5ksEwvwGKb1G-jxVk6ttr9JYg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Rob Herring <robh+dt@kernel.org>, Eliad Peller <eliad@wizery.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?Q?Agust=C3=AD?= <afontquerni@gmail.com>, Pau Pajuel <paupa13@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

SGVsbG8sCgoyMDE1LTAzLTEzIDk6MDEgR01UKzAxOjAwIEphdmllciBNYXJ0aW5leiBDYW5pbGxh
cyA8amF2aWVyQGRvd2hpbGUwLm9yZz46Cj4gSGVsbG8gRWxpYWQsCj4KPiBPbiBUaHUsIE1hciAx
MiwgMjAxNSBhdCAxOjA5IFBNLCBFbGlhZCBQZWxsZXIgPGVsaWFkQHdpemVyeS5jb20+IHdyb3Rl
Ogo+PiBSZXBsYWNlIGFsbCB0aGUgcGRhdGEtcXVpcmtzIGZvciBzZXR0aW5nIHdsMTJ4eC93bDE4
eHgKPj4gcGxhdGZvcm0gZGF0YSB3aXRoIHByb3BlciBEVCBkZWZpbml0aW9ucy4KPj4KPj4gVGhl
IHBhdGNoIHdhcyBjb21waWxlLXRlc3RlZCBvbmx5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFbGlh
ZCBQZWxsZXIgPGVsaWFkQHdpemVyeS5jb20+Cj4+IC0tLQo+Cj4gSSB3YW50ZWQgdG8gdGVzdCB5
b3VyIHNlcmllcyBidXQgSSByZWFsaXplZCB0aGF0IHRoZSBJR0VQdjIgSSd2ZQo+IGFjY2VzcyBp
cyB0aGUgb2xkIHJldmlzaW9uIHRoYXQgaGFzIGFub3RoZXIgU0RJTyB3bGFuIG1vZHVsZSBpbnN0
ZWFkCj4gb2YgYSBXaWxpbms4Lgo+Cj4gTWF5YmUgRW5yaWMgaGF2ZSB0aGUgbmV3IHJldmlzaW9u
PyBJIGFsc28gYWRkZWQgdG8gUGF1IFBhanVlbCBhcyBjYwo+IHdobyBzdGlsbCB3b3JrcyBpbiB0
aGUgY29tcGFueSBtYW51ZmFjdHVyaW5nIHRoZXNlIGJvYXJkcyBzbyBoZSBzaG91bGQKPiBiZSBh
YmxlIHRvIHRlc3QgaXQuCj4KClNvcnJ5LCBub3cgSSBvbmx5IGhhdmUgYW4gb2xkIHJldmlzaW9u
IHRvbywgc28gSSBjYW4ndCB0ZXN0LCBjYydpbmcKQWd1c3TDrSB0aGF0IGhhcyBhY2Nlc3MgdG8g
dGhlIGhhcmR3YXJlLCBtYXliZSBoZSBjYW4gdGVzdCBpdCBvciBoZSBjYW4KcHJvdmlkZSB0byB1
cyBhIGJvYXJkIDspCgo+IEJ1dCBpbiBhbnkgY2FzZSwgeW91ciBwYXRjaCBsb29rcyBnb29kIHRv
IG1lIHNvIGZvciB0aGUKPiBhcmNoL2FybS9ib290L2R0cy9vbWFwMy1pZ2VwMDAqIGNoYW5nZXM6
Cj4KPiBBY2tlZC1ieTogSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIDxqYXZpZXJAZG93aGlsZTAu
b3JnPgo+CgpGb3IgbXkgcGFydCBhbHNvIGxvb2tzIGdvb2QuCgpBY2tlZC1ieTogRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYSA8ZWJhbGxldGJvQGdtYWlsLmNvbT4KCkJlc3QgcmVnYXJkcywKICAgRW5y
aWMKCj4gQmVzdCByZWdhcmRzLAo+IEphdmllcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
