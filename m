From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
Date: Wed, 31 May 2017 19:22:22 +0200
Message-ID: <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
 <20170531171932.GH3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531171932.GH3730@atomide.com>
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
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

SGkgVXdlLCBUb255LAoKT24gV2VkLCBNYXkgMzEsIDIwMTcgYXQgNzoxOSBQTSwgVG9ueSBMaW5k
Z3JlbiA8dG9ueUBhdG9taWRlLmNvbT4gd3JvdGU6Cj4gKiBVd2UgS2xlaW5lLUvDtm5pZyA8dXdl
QGtsZWluZS1rb2VuaWcub3JnPiBbMTcwNTI2IDExOjA5XToKPj4gQWNjb3JkaW5nIHRvIHRoZSBi
aW5kaW5nIGRvY3VtZW50YXRpb24gYW5kIHRoZSBzb3VyY2UgY29kZSB0aGUgb21hcC1ncGlvCj4+
IGNvbnRyb2xsZXIgdGFrZXMgSVJRX1RZUEVfKiBhcyBpdHMgZmxhZ3MgdmFsdWVzLCBub3QgR1BJ
T19BQ1RJVkVfKi4KPj4KPj4gVGhpcyBwYXRjaCB1c2VzIHRoZSByaWdodCB2YXJpYWJsZSB0eXBl
IHdoaWNoIHlpZWxkcyB0aGUgc2FtZSByZXN1bHQKPj4gd2hlbiBjb21waWxlZC4gTm90ZSB0aGF0
IHRoaXMgbWlnaHQgYmUgd3JvbmcgYW5kIGFjdHVhbGx5Cj4+IElSUV9UWVBFX0xFVkVMX0xPVyBp
cyBpbnRlbmRlZCBieSB0aGUgZHQgYXV0aG9yLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xl
aW5lLUvDtm5pZyA8dXdlQGtsZWluZS1rb2VuaWcub3JnPgo+PiAtLS0KPj4gSGVsbG8sCj4+Cj4+
IGNhbiBzb21lYm9keSB3aXRoIHRoZSBoYXJkd2FyZSBvciBpdCdzIGRvY3VtZW50YXRpb24gcGxl
YXNlIGNoZWNrIHdoaWNoCj4+IGZsYWcgaXMgdGhlIHJpZ2h0IG9uZT8KPgo+IEknbGwgd2FpdCBv
biB0aGlzIG9uZSB1bnRpbCB3ZSBoYXZlIHNvbWVib2R5IHRlc3QgaXQuCgpJJ2xsIGxvb2sgYXQg
aXQgdGhpcyB3ZWVrLgoKWWVnb3IKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
