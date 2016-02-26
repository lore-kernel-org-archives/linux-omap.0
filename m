From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Fri, 26 Feb 2016 07:27:14 -0800
Message-ID: <20160226152714.GD3173@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu> <56D04D17.6030502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D04D17.6030502-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo@kern>
List-Id: linux-omap@vger.kernel.org

T24gRnJpLCAyMDE2LTAyLTI2IGF0IDE1OjAzOjE5ICswMjAwLCBHcnlnb3JpaSBTdHJhc2hrbyB3
cm90ZToKPiBPbiAwMi8wNS8yMDE2IDAxOjM5IEFNLCBTw7ZyZW4gQnJpbmttYW5uIHdyb3RlOgo+
ID4gT24gVGh1LCAyMDE2LTAyLTA0IGF0IDE1OjE0OjQ3IC0wODAwLCBNb3JpdHogRmlzY2hlciB3
cm90ZToKPiA+PiBIaSBTb2VyZW4sCj4gPj4KPiA+PiBPbiBUaHUsIEZlYiA0LCAyMDE2IGF0IDI6
NDEgUE0sIFPDtnJlbiBCcmlua21hbm4KPiA+PiA8c29yZW4uYnJpbmttYW5uQHhpbGlueC5jb20+
IHdyb3RlOgo+ID4+Cj4gPj4+IEJ1dCB3aXRoIHRoaXMgY2hhbmdlIHRoZSAnaWYgIUNQVV9GUkVR
JyBiZWNvbWVzIG9ic29sZXRlLgo+ID4+IEknbSBjb25mdXNlZCwgY291bGQgeW91IGV4cGxhaW4g
dGhhdCBzdGF0ZW1lbnQ/IFlvdSBkb24ndCB3YW50IHBlb3BsZQo+ID4+IGFjY2lkZW50YWxseSBy
dW5uaW5nIHdpdGggR1Qgd2hlbiBDUFVfRlJFUSBpcyBvbiwgcmlnaHQ/Cj4gPiAKPiA+IENvcnJl
Y3QuIEJ1dCB3aXRoIHRoaXMgS2NvbmZpZyByZXdvcmsgeW91IGNhbiBqdXN0IGRlc2VsZWN0IGl0
IGluCj4gPiBLY29uZmlnLiBUaGUgZ2VuZXJpYyBIQVZFX0dUIGNvdWxkIGFsd2F5cyBiZSBzZWxl
Y3RlZC4KPiA+IAo+IAo+IAo+IERvbid0IGtub3cgd2hvbSBzaG91bGQgaSBhc2sgLSBidXQgd2hh
dCB3aWxsIGJlIHRoZSBmaW5hbCBjb25jbHVzaW9uIGhlcmU/Cj4gQ2FuIGl0IGJlIG1lcmdlZD8K
CkkgdGhpbmsgd2UgZG9uJ3QgYnJlYWsgYW55dGhpbmcgZWl0aGVyIHdheS4gV291bGQganVzdCBi
ZSBzb21lCmFkZGl0aW9uYWwgY2xlYW4gdXAgdG8gZ2V0IHJpZCBvZiB0aGF0IG1lbnRpb25lZCBj
b25zdHJhaW50ICh3aGljaApkb2Vzbid0IHJlYWxseSB3b3JrIHdlbGwgYW55d2F5IGluIHRoZSBt
dWx0aS1hcmNoIGtlcm5lbCkuIFNvLCBubyByZWFsCm9iamVjdGlvbnMgdG8gbWVyZ2luZyBpdCBm
cm9tIG15IHNpZGUuCgoJVGhhbmtzLAoJU8O2cmVuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgt
cm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
