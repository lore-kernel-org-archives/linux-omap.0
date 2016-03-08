From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/i2c: tda998x: Choose between atomic or non atomic
 dpms helper
Date: Tue, 8 Mar 2016 11:16:54 +1000
Message-ID: <CAPM=9tzcxHKRbiHa4Hy+4Ksgpiy+tWhoUyhQT0g0UX7xb3xF0Q@mail.gmail.com>
References: <1452975474-17058-1-git-send-email-jsarha@ti.com>
 <56DDF6FA.2040501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <56DDF6FA.2040501@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gOCBNYXJjaCAyMDE2IGF0IDA3OjQ3LCBKeXJpIFNhcmhhIDxqc2FyaGFAdGkuY29tPiB3cm90
ZToKPiBIaSwKPiBCYXNlZCBvbiBkaXNjdXNzaW9uIGFyb3VuZCB0aGlzIHBhdGNoOgo+Cj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvYXJjaGl2ZXMvZHJpLWRldmVsLzIwMTYtRmVicnVh
cnkvMTAwNjg1Lmh0bWwKPgo+IEkgdGhpbmsgdGhlIHBhdGNoIGJlbG93IHNob3VsZCBnZXQgaW50
byBxdWV1ZWQgZm9yIHY0LjUgZml4ZXMgYXMgdGhlCj4gQmVhZ2xlYm9uZS1CbGFjayBkaXNwbGF5
IGlzIGN1cnJlbnRseSBicm9rZW4gaW4gbGludXgtbWFzdGVyIGFuZCBwcm9iYWJseQo+IEFybWFk
YSBpcyBicm9rZW4gdG9vLiBXaGF0IHNob3VsZCBJIGRvIHRvIGdldCBpdCB0aGVyZT8KCkkndmUg
cHVzaGVkIHRoaXMgdG8gZHJtLWZpeGVzLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
