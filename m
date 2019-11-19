From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFCv1 32/42] drm/omap: dsi: convert to drm_panel
Date: Tue, 19 Nov 2019 10:42:55 +0100
Message-ID: <469800BA-25F8-4E0A-8194-50C197BC4BF5@goldelico.com>
References: <20191117024028.2233-1-sebastian.reichel@collabora.com>
 <20191117024028.2233-33-sebastian.reichel@collabora.com>
 <D109D867-1C8E-44F6-9C91-AF55BCB3FDD3@goldelico.com>
 <20191118144558.abix5y555jk63szb@earth.universe>
 <9681B365-9174-43CE-BCAE-ED986F182935@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <9681B365-9174-43CE-BCAE-ED986F182935@goldelico.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, Tony Lindgren <tony@atomide.com>, Merlijn Wajer <merlijn@wizzup.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SGkgU2ViYXN0aWFuLAoKPiBBbSAxOC4xMS4yMDE5IHVtIDE1OjUxIHNjaHJpZWIgSC4gTmlrb2xh
dXMgU2NoYWxsZXIgPGhuc0Bnb2xkZWxpY28uY29tPjoKPiAKPj4gT2ssIEkgdHJpZWQgbm90IHRv
IGJyZWFrIHZpZGVvIG1vZGUgc3VwcG9ydCwgYnV0IEkgZG8gbm90IGhhdmUgYW55Cj4+IGhhcmR3
YXJlLiBNYWtlIHN1cmUgdG8gc2V0IHRoZSBNSVBJX0RTSV9NT0RFX1ZJREVPIGZsYWcgaW4gdGhl
IHBhbmVsCj4+IGRyaXZlci4KPiAKPiBJbmRlZWQsIHRoaXMgbWF5IGJlIG1pc3NpbmcgKGNhbid0
IGxvb2sgaW50byB0aGUgY29kZSBhdCB0aGUgbW9tZW50KS4uLgo+IE9yIEkgZGlkIHNvbWV0aGlu
ZyB3cm9uZyB3aGVuIHJlZmFjdG9yaW5nIHRoZSBkcml2ZXIuCj4gV2Ugd2lsbCBmaW5kIG91dC4K
ClllcywgTUlQSV9EU0lfTU9ERV9WSURFTyB3YXMgaW5kZWVkIG1pc3Npbmcvd3JvbmdseSBhcHBs
aWVkIGFuZCBzb21lCm1vcmUgYnVncy4gQnV0IEkgc3RpbGwgd2Fzbid0IGFibGUgdG8gbWFrZSBp
dCB3b3JrLgoKSSBhbHNvIHRyaWVkIHRvIGZha2UgdGhlIHBhbmVsLW9yaXNldGVjaC1vdG04MDA5
YS5jIERTSSBkcml2ZXIgaW50bwpteSBzZXR1cC4gSXQgc2hvdWxkIG5vdCBwcm9wZXJseSBwcm9n
cmFtIHRoZSBwYW5lbCBieSBEQ1MgY29tbWFuZApidXQgaXQgc2hvdWxkIHRyeSB0by4KClJlc3Vs
dCBpcyB0aGUgc2FtZTogSSBjYW4gc2VlIGl0IGJlaW5nIHByb2JlZCBhbmQgY2FsbGluZyBnZXRf
bW9kZXMKYnV0IHRoZW46CgpbZHJtXSBDYW5ub3QgZmluZCBhbnkgY3J0YyBvciBzaXplcwoKQW5k
IEkgZG9uJ3Qgc2VlIGNhbGxzIHRvIC5lbmFibGUgb3IgLnByZXBhcmUgd2hlcmUgRENTIGNvbW1h
bmRzIHdvdWxkCmJlIHNlbnQuCgpCUiBhbmQgdGhhbmtzLApOaWtvbGF1cwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
