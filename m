From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: dsi: Fix PM for display blank with paired
 dss_pll calls
Date: Thu, 7 Feb 2019 11:07:12 +0200
Message-ID: <98cd1ac6-8a40-83af-eff8-59f9072cf724@ti.com>
References: <20190131033210.21449-1-tony@atomide.com>
 <4a054efc-3111-38cd-aa9b-935ea224abe4@ti.com>
 <20190204154208.GG5720@atomide.com>
 <45860ba9-93a6-199e-0db9-7d727b4bba76@ti.com>
 <20190205175846.GV5720@atomide.com>
 <7dcddb9a-0cea-bf69-4691-78868b7d5d9d@ti.com>
 <20190206160056.GY5720@atomide.com>
 <b5cdb1ba-6c2f-d626-4bfa-4c0ca287ea97@ti.com>
 <20190206162920.GZ5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190206162920.GZ5720@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gMDYvMDIvMjAxOSAxODoyOSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKCj4gT0suIExvb2tzIGdv
b2QgdG8gbWUgb3RoZXJ3aXNlLgo+IAo+IFNvIEkgZ3Vlc3Mgd2Ugc2hvdWxkIGZpeC4gRG8geW91
IHdhbnQgbWUgdG8gcG9zdCBpdCBhbGwKPiBhcyBhIHNpbmdsZSBwYXRjaCBhZnRlciBzb21lIHRl
c3Rpbmc/CgpZZXMgcGxlYXNlID0pCgogVG9taQoKLS0gClRleGFzIEluc3RydW1lbnRzIEZpbmxh
bmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVz
cyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
