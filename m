From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Fri, 26 Feb 2016 15:03:19 +0200
Message-ID: <56D04D17.6030502@ti.com>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160204233950.GH4215@xsjsorenbubuntu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

T24gMDIvMDUvMjAxNiAwMTozOSBBTSwgU8O2cmVuIEJyaW5rbWFubiB3cm90ZToKPiBPbiBUaHUs
IDIwMTYtMDItMDQgYXQgMTU6MTQ6NDcgLTA4MDAsIE1vcml0eiBGaXNjaGVyIHdyb3RlOgo+PiBI
aSBTb2VyZW4sCj4+Cj4+IE9uIFRodSwgRmViIDQsIDIwMTYgYXQgMjo0MSBQTSwgU8O2cmVuIEJy
aW5rbWFubgo+PiA8c29yZW4uYnJpbmttYW5uQHhpbGlueC5jb20+IHdyb3RlOgo+Pgo+Pj4gQnV0
IHdpdGggdGhpcyBjaGFuZ2UgdGhlICdpZiAhQ1BVX0ZSRVEnIGJlY29tZXMgb2Jzb2xldGUuCj4+
IEknbSBjb25mdXNlZCwgY291bGQgeW91IGV4cGxhaW4gdGhhdCBzdGF0ZW1lbnQ/IFlvdSBkb24n
dCB3YW50IHBlb3BsZQo+PiBhY2NpZGVudGFsbHkgcnVubmluZyB3aXRoIEdUIHdoZW4gQ1BVX0ZS
RVEgaXMgb24sIHJpZ2h0Pwo+IAo+IENvcnJlY3QuIEJ1dCB3aXRoIHRoaXMgS2NvbmZpZyByZXdv
cmsgeW91IGNhbiBqdXN0IGRlc2VsZWN0IGl0IGluCj4gS2NvbmZpZy4gVGhlIGdlbmVyaWMgSEFW
RV9HVCBjb3VsZCBhbHdheXMgYmUgc2VsZWN0ZWQuCj4gCgoKRG9uJ3Qga25vdyB3aG9tIHNob3Vs
ZCBpIGFzayAtIGJ1dCB3aGF0IHdpbGwgYmUgdGhlIGZpbmFsIGNvbmNsdXNpb24gaGVyZT8KQ2Fu
IGl0IGJlIG1lcmdlZD8KCi0tIApyZWdhcmRzLAotZ3J5Z29yaWkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlz
dApMaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK
