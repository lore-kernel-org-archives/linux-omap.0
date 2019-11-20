From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFCv1 33/42] drm/omap: dsi: use atomic helper for dirtyfb
Date: Tue, 19 Nov 2019 19:48:20 -0800
Message-ID: <20191120034820.GR35479@atomide.com>
References: <20191117024028.2233-1-sebastian.reichel@collabora.com>
 <20191117024028.2233-34-sebastian.reichel@collabora.com>
 <20191118230535.GG35479@atomide.com>
 <e91c7fc9-18e0-cc22-4617-127fe9be2c1b@ti.com>
 <20191119143243.GH35479@atomide.com>
 <edff7dfa-8b95-48ac-59e0-14553f3c8d39@ti.com>
 <20191119150643.GI35479@atomide.com>
 <46aba805-1d3a-2efc-23f6-d957bf6a44c3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <46aba805-1d3a-2efc-23f6-d957bf6a44c3@ti.com>
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
Cc: kernel@collabora.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkxMTE5IDE1OjU2XToK
PiBBZmFpaywgV2VzdG9uIGFuZCBYIGJvdGggaGFuZGxlIHBhZ2UgZmxpcHMgYW5kL29yIGRpcnR5
aW5nIHRoZSBmYiwgc28gdGhleQo+IHNob3VsZCB3b3JrLiBBcmUgdGhlcmUgYXBwbGljYXRpb25z
IHRoYXQgZG8gbm90IHdvcmssIGFuZCBjYW5ub3QgYmUgbWFkZSB0bwo+IHdvcmssIGV4Y2VwdCB0
aGUgZmV3IFNHWCB0ZXN0IGFwcHM/CgpJJ20gbm90IHN1cmUgc3VyZSB5ZXQgd2hhdCBhbGwgaXQg
YWZmZWN0cywgSSdsbCBkbyBzb21lIG1vcmUgdGVzdHMgb24gaXQuCgpSZWdhcmRzLAoKVG9ueQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
