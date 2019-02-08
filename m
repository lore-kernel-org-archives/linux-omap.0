From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] drm/omap: dsi: Fix PM for display blank with paired
 dss_pll calls
Date: Fri, 8 Feb 2019 07:23:49 -0800
Message-ID: <20190208152349.GH5720@atomide.com>
References: <20190207154516.57549-1-tony@atomide.com>
 <d22d93aa-fd90-57e9-adfd-3ece2f3a2db7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <d22d93aa-fd90-57e9-adfd-3ece2f3a2db7@ti.com>
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

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkwMjA4IDA5OjExXToK
PiBMb29rcyBmaW5lIHRvIG1lIGFuZCB3b3JrcyBvbiBwYW5kYS4gSSdsbCBxdWV1ZSB0aGlzIHRv
IHRoZSBuZXh0IG1lcmdlCj4gd2luZG93IChJIHByZXN1bWUgbm8gcnVzaCB0byBnZXQgdGhpcyBp
bnRvIHRoZSBjdXJyZW50IC1yY3MsIGl0J3MgYSBiaXQKPiBsYXRlKS4KCk9LIGdvb2QgdG8gaGVh
ciBwYW5kYSB3b3JrcyB0b28sIG15IHBhbmRhIGlzIGluIG15IHJhY2suLgpUaGlzIG9uZSBoYXMg
YmVlbiBicm9rZW4gZm9yIGEgbG9uZyB0aW1lIGFuZCBub2JvZHkgbm90aWNlZCwKc28gbmV4dCBp
cyBqdXN0IGZpbmUgd2l0aCBtZS4KClJlZ2FyZHMsCgpUb255Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
