From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFCv1 33/42] drm/omap: dsi: use atomic helper for dirtyfb
Date: Tue, 19 Nov 2019 16:53:47 +0200
Message-ID: <edff7dfa-8b95-48ac-59e0-14553f3c8d39@ti.com>
References: <20191117024028.2233-1-sebastian.reichel@collabora.com>
 <20191117024028.2233-34-sebastian.reichel@collabora.com>
 <20191118230535.GG35479@atomide.com>
 <e91c7fc9-18e0-cc22-4617-127fe9be2c1b@ti.com>
 <20191119143243.GH35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191119143243.GH35479@atomide.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel@collabora.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMTkvMTEvMjAxOSAxNjozMiwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKCj4+IFdlIGhhdmVuJ3Qg
aGFkIG9tYXBfZ2VtX29wX2ZpbmlzaCgpIGluIHRoZSBrZXJuZWwgZm9yIHNvbWUgeWVhcnMgbm93
Li4uCj4+Cj4+IFNob3VsZG4ndCBhIG5vcm1hbCBwYWdlIGZsaXAsIG9yIGlmIGRvaW5nIHNpbmds
ZS1idWZmZXJpbmcsIHVzaW5nIHRoZQo+PiBkaXJ0eWZiIGlvY3RsLCBkbyB0aGUgam9iPwo+IAo+
IEl0IGRvZXMgbm90IHNlZW0gdG8gaGFwcGVuIHdpdGggdGhlIG9sZCBwdnItb21hcDQgcmVsYXRl
ZCBwYXRjaGVzCj4gYW5kIHdoYXRldmVyIGdsZXMgcmVsYXRlZCB0ZXN0cyBhdCBsZWFzdC4gSWYg
eW91IGhhdmUgc29tZSBpZGVhCj4gd2hlcmUgaXQgc2hvdWxkIGdldCBjYWxsZWQgSSBjYW4gdGFr
ZSBhIGxvb2sgYXQgc29tZSBwb2ludC4KClRoZSB1c2Vyc3BhY2UgYXBwcyBuZWVkIHRvIGRvIHRo
aXMuIElmIHRoZXkncmUgdXNpbmcgc2luZ2xlLWJ1ZmZlcmluZywgCnRoZW4gdXNpbmcgdGhlIGRp
cnR5ZmIgaW9jdGwgc2hvdWxkIGRvIHRoZSB0cmljaywgYWZ0ZXIgdGhlIFNHWCBoYXMgCmZpbmlz
aGVkIGRyYXdpbmcuCgpJdCdzIHByb2JhYmx5IHNvbWV3aGF0IGRpZmZpY3VsdCBpZiBFR0wgaXMg
Y29udHJvbGxpbmcgdGhlIGRpc3BsYXksIGFzLCAKYWZhaWssIFNHWCBFR0wgaXMgY2xvc2VkIHNv
dXJjZSwgYW5kIHRoYXQncyBwcm9iYWJseSB3aGVyZSBpdCBzaG91bGQgYmUgCmRvbmUuCgpCdXQg
YWRkaW5nIGJhY2sgdGhlIGhhY2t5IG9tYXAgZ2VtIHN5bmMgc3R1ZmYsIGFuZCB0aGVuIHNvbWVo
b3cgZ3Vlc3NpbmcgCmZyb20gdGhlIHN5bmMgZmluaXNoIHRoYXQgc29tZSBkaXNwbGF5IG5lZWRz
IHRvIGJlIHVwZGF0ZWQuLi4gSXQganVzdCAKZG9lcyBub3Qgc291bmQgcmlnaHQgdG8gbWUuCgog
IFRvbWkKCi0tIApUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIy
LCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBh
aWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
