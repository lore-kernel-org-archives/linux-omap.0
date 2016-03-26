From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 13/23] drm: omapdrm: crtc: update plane fifos on lcd
 config change
Date: Sat, 26 Mar 2016 19:00:53 +0200
Message-ID: <3716864.g0dovaDAJW@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-14-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1457455195-1938-14-git-send-email-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SGkgU2ViYXN0aWFuLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgpPbiBUdWVzZGF5IDA4IE1h
ciAyMDE2IDE3OjM5OjQ1IFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+IER1ZSB0byBhIGhhcmR3
YXJlIGJ1ZywgRklGT3MgdGhyZXNob2xkcyBtdXN0IGJlCj4gY29uZmlndXJlZCB2ZXJ5IGNhcmVm
dWxseSBmb3IgbWFudWFsbHkgdXBkYXRlZAo+IGRpc3BsYXlzLgoKQ291bGQgeW91IHBsZWFzZSBw
cm92aWRlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGJ1ZyBhbmQgaG93IHRoZSBjb2RlIApo
YW5kbGVzIGl0ID8KCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJu
ZWwub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vb21hcGRybS9vbWFwX2NydGMuYyB8IDQg
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29tYXBfY3J0Yy5jCj4gYi9kcml2ZXJzL2dwdS9kcm0v
b21hcGRybS9vbWFwX2NydGMuYyBpbmRleCA4OTY3MDEzYzFmYjUuLjA5NGU4OWEyZmE5NAo+IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29tYXBfY3J0Yy5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9jcnRjLmMKPiBAQCAtMjUzLDYgKzI1MywxMCBA
QCBzdGF0aWMgdm9pZCBvbWFwX2NydGNfZHNzX3NldF9sY2RfY29uZmlnKHN0cnVjdAo+IG9tYXBf
b3ZlcmxheV9tYW5hZ2VyICptZ3IsIG9tYXBfY3J0Yy0+bWFudWFsbHlfdXBkYXRlZCA9Cj4gZHNz
X2xjZF9tZ3JfY29uZmlnX2dldF9zdGFsbG1vZGUoY29uZmlnKTsKPiAKPiAgCWRpc3BjX21ncl9z
ZXRfbGNkX2NvbmZpZyhvbWFwX2NydGMtPmNoYW5uZWwsIGNvbmZpZyk7Cj4gKwo+ICsJZHJtX2Zv
cl9lYWNoX3BsYW5lKHBsYW5lLCBkZXYpIHsKPiArCQlvbWFwX3BsYW5lX3VwZGF0ZV9maWZvKHBs
YW5lKTsKPiArCX0KClRoaXMgc2VlbXMgZmlzaHkgOi0vIFRvIHN0YXJ0IHdpdGggeW91IHNob3Vs
ZG4ndCB0b3VjaCBwbGFuZXMgdGhhdCBkb24ndCAKYmVsb25nIHRvIHRoaXMgQ1JUQy4gVGhlbiwg
dXBkYXRpbmcgdGhlIEZJRk8gdGhyZXNob2xkcyBoZXJlIGluIGFkZGl0aW9uIHRvIApvbWFwX3Bs
YW5lX2F0b21pY191cGRhdGUoKSBtYWtlcyBtZSB3b25kZXIgaWYgYm90aCBhcmUgbmVlZGVkLCBh
bmQgaWYgc28sIHdoeS4KCj4gIH0KPiAKPiAgc3RhdGljIGludCBvbWFwX2NydGNfZHNzX3JlZ2lz
dGVyX2ZyYW1lZG9uZSgKCi0tIApSZWdhcmRzLAoKTGF1cmVudCBQaW5jaGFydAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
