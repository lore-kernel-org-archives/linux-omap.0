From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] drm/omap: Move DISPC runtime PM handling to omapdrm
Date: Mon, 5 Nov 2018 12:14:46 -0800
Message-ID: <20181105201446.GF56754@atomide.com>
References: <20181105151028.4091-1-laurent.pinchart@ideasonboard.com>
 <20181105192314.5565-1-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181105192314.5565-1-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

KiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+IFsx
ODExMDUgMTk6MjNdOgo+IFRoaXMgcGF0Y2ggYXBwbGllcyBvbiB0b3Agb2YgdGhlICJbUEFUQ0gg
djIgMC80XSBvbWFwZHJtOiBGaXggcnVudGltZSBQTQo+IGlzc3VlcyBhdCBtb2R1bGUgbG9hZCBh
bmQgdW5sb2FkIHRpbWUiIHNlcmllcy4gSXQgZGVtb25zdHJhdGVzIHdoYXQgSQo+IHRoaW5rIGlz
IHRoZSBwcm9wZXIgbG9uZyB0ZXJtIGZpeCBmb3IgdGhlIGlzc3VlIGFkZHJlc3NlZCBieSBwYXRj
aCA0LzQuCj4gRHVlIHRvIGl0cyBuYXR1cmUsIEkgZG9uJ3QgdGhpbmsgdGhpcyBwYXRjaCBzaG91
bGQgYmUgYXBwbGllZCBmb3IgdjQuMjAKPiBhcyBpdCBxdWFsaWZpZXMgZm9yIHZlcnkgY2FyZWZ1
bCB0ZXN0aW5nLCBoZW5jZSBteSBwcm9wb3NhbCB0byBmaXggdGhlCj4gcnVudGltZSBQTSBwcm9i
bGVtIHdpdGggNC80IGFuZCB0byBxdWV1ZSB0aGlzIHBhdGNoIGZvciB2NC4yMS4KClRvIG1lIHRo
aXMgc2VlbXMgbGlrZSBhIGxlc3Mgcmlza3kgZml4IGNvbXBhcmVkIHRvIGNvbmRpdGlvbmFsCnJ1
bnRpbWUgUE0gY2FsbHMgaW4gcGF0Y2ggNC4gQ29uZGl0aW9uYWwgY2FsbHMgd2l0aCB1c2Vjb3Vu
dHMgc2VlbQp0byBhbHdheXMgYnJlYWsgb25lIHdheSBvciBhbm90aGVyLi4gU28gd291bGQgYmUg
bmljZSB0byBnbyB3aXRoCnRoaXMgb25lIGlmIHBvc3NpYmxlLgoKUmVnYXJkcywKClRvbnkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
