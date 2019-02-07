From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix PM for display blank with paired
 dss_pll calls
Date: Thu, 7 Feb 2019 07:46:15 -0800
Message-ID: <20190207154615.GB5720@atomide.com>
References: <20190131033210.21449-1-tony@atomide.com>
 <4a054efc-3111-38cd-aa9b-935ea224abe4@ti.com>
 <20190204154208.GG5720@atomide.com>
 <45860ba9-93a6-199e-0db9-7d727b4bba76@ti.com>
 <20190205175846.GV5720@atomide.com>
 <7dcddb9a-0cea-bf69-4691-78868b7d5d9d@ti.com>
 <20190206160056.GY5720@atomide.com>
 <b5cdb1ba-6c2f-d626-4bfa-4c0ca287ea97@ti.com>
 <20190206162920.GZ5720@atomide.com>
 <98cd1ac6-8a40-83af-eff8-59f9072cf724@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <98cd1ac6-8a40-83af-eff8-59f9072cf724@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkwMjA3IDA5OjA3XToK
PiBPbiAwNi8wMi8yMDE5IDE4OjI5LCBUb255IExpbmRncmVuIHdyb3RlOgo+IAo+ID4gT0suIExv
b2tzIGdvb2QgdG8gbWUgb3RoZXJ3aXNlLgo+ID4gCj4gPiBTbyBJIGd1ZXNzIHdlIHNob3VsZCBm
aXguIERvIHlvdSB3YW50IG1lIHRvIHBvc3QgaXQgYWxsCj4gPiBhcyBhIHNpbmdsZSBwYXRjaCBh
ZnRlciBzb21lIHRlc3Rpbmc/Cj4gCj4gWWVzIHBsZWFzZSA9KQoKT0sgdjIgcGF0Y2ggc2VudC4K
ClJlZ2FyZHMsCgpUb255Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
