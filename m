From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/23] drm: omapdrm: wait for pending operations before
 updating plane
Date: Sat, 26 Mar 2016 11:20 +0200
Message-ID: <2247354.2fBg1ifxEX@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-7-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1457455195-1938-7-git-send-email-sre@kernel.org>
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

SGkgU2FiYXN0aWFuLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgpPbiBUdWVzZGF5IDA4IE1h
ciAyMDE2IDE3OjM5OjM4IFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOgo+IFVwZGF0aW5nIHRoZSBw
bGFuZSBtYXkgaW50ZXJydXB0IG9uZ29pbmcgZGlzcGxheQo+IHVwZGF0ZXMsIHNvIHdhaXQgZm9y
IGFueSBwZW5kaW5nIG9wZXJhdGlvbnMuCgpUaGVyZSdzIGFscmVhZHkgYW4gb21hcF9hdG9taWNf
d2FpdF9mb3JfY29tcGxldGlvbigpIGNhbGwgYSBjb3VwbGUgb2YgbGluZXMgCmJlbG93LCBkbyB3
ZSBuZWVkIHR3byBvZiB0aGVtID8gV2h5IGNhbiBkaXNwbGF5IHVwZGF0ZSBiZSBvbmdvaW5nIHRo
ZXJlLCBnaXZlbiAKdGhhdCB0aGUgcHJldmlvdXMgb21hcF9hdG9taWNfY29tcGxldGUoKSBjYWxs
IGRpZCB3YWl0IGZvciBjb21wbGV0aW9uIGJlZm9yZSAKcmV0dXJuaW5nID8KCj4gU2lnbmVkLW9m
Zi1CeTogU2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJuZWwub3JnPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vb21hcGRybS9vbWFwX2Rydi5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0v
b21hcF9kcnYuYwo+IGIvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9kcnYuYyBpbmRleCBh
M2ZmMzVmNWY2Y2QuLmUxNDJhNDI0NTc2Ngo+IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9vbWFwZHJtL29tYXBfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vb21hcGRybS9vbWFw
X2Rydi5jCj4gQEAgLTk1LDYgKzk1LDEwIEBAIHN0YXRpYyB2b2lkIG9tYXBfYXRvbWljX2NvbXBs
ZXRlKHN0cnVjdAo+IG9tYXBfYXRvbWljX3N0YXRlX2NvbW1pdCAqY29tbWl0KSAvKiBBcHBseSB0
aGUgYXRvbWljIHVwZGF0ZS4gKi8KPiAgCWRpc3BjX3J1bnRpbWVfZ2V0KCk7Cj4gCj4gKwlkZXZf
ZGJnKGRldi0+ZGV2LCAib21hcF9hdG9taWNfY29tcGxldGUiKTsKPiArCj4gKwlvbWFwX2F0b21p
Y193YWl0X2Zvcl9jb21wbGV0aW9uKGRldiwgb2xkX3N0YXRlKTsKPiArCj4gIAlkcm1fYXRvbWlj
X2hlbHBlcl9jb21taXRfbW9kZXNldF9kaXNhYmxlcyhkZXYsIG9sZF9zdGF0ZSk7Cj4gIAlkcm1f
YXRvbWljX2hlbHBlcl9jb21taXRfcGxhbmVzKGRldiwgb2xkX3N0YXRlLCBmYWxzZSk7Cj4gIAlk
cm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFibGVzKGRldiwgb2xkX3N0YXRlKTsK
Ci0tIApSZWdhcmRzLAoKTGF1cmVudCBQaW5jaGFydAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
