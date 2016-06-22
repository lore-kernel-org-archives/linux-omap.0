From: Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/5] Thermal: Support for hardware-tracked trip points
Date: Wed, 22 Jun 2016 19:19:24 +0800
Message-ID: <576A743C.7080401@gmail.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
 <57689B82.3000902@gmail.com> <1466565939.2379.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466565939.2379.5.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Durgadoss R <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Andy Champ <andycham-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, javi.merino-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ni Wade <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter-p08lbbvQ7EI@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ck9uIDIwMTblubQwNuaciDIy5pelIDExOjI1LCBaaGFuZyBSdWkgd3JvdGU6Cj4gT24g5LqMLCAy
MDE2LTA2LTIxIGF0IDA5OjQyICswODAwLCBDYWVzYXIgV2FuZyB3cm90ZToKPj4gRG8geW91IGhh
dmUgb3RoZXIgaWRlYXMgZm9yIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcz8gOi0pCj4+IEV2ZW4gaWYg
b25seSB0b29rIHR3byB3ZWVrcyBmZWVsIGFmdGVyIGEgbG9uZyB0aW1lLgo+Pgo+PiA5MTU3OTE5
IE5ldyAgICAgICAgICBbdjUsMS81XSB0aGVybWFsOiBBZGQgc3VwcG9ydCBmb3IgaGFyZHdhcmUt
Cj4+IHRyYWNrZWQgdHJpcCBwb2ludHMKPj4gOTE1NzkxNyBOZXcgICAgICAgICAgW3Y1LDIvNV0g
dGhlcm1hbDogb2Y6IGltcGxlbWVudCAuc2V0X3RyaXBzIGZvcgo+PiBkZXZpY2UgdHJlZSB0aGVy
bWFsIHpvbmVzCj4+IDkxNjExMjkgTmV3ICAgICAgICAgIFt2NS4xLDMvNV0gdGhlcm1hbDogc3Ry
ZWFtbGluZSBnZXRfdHJlbmQKPj4gY2FsbGJhY2tzCj4+IDkxNTc5MjkgTmV3ICAgICAgICAgIFt2
NSw0LzVdIHRoZXJtYWw6IGJhbmctYmFuZyBnb3Zlcm5vcjogYWN0IG9uCj4+IGxvd2VyIHRyaXAg
Ym91bmRhcnkKPj4gOTE1NzkyNSBOZXcgICAgICAgICAgW3Y1LDUvNV0gdGhlcm1hbDogcm9ja2No
aXA6IGFkZCB0aGUgc2V0X3RyaXBzCj4+IGZ1bmN0aW9uCj4+IC0tLQo+Pgo+IEkgaGF2ZSBubyBv
YmplY3Rpb25zIHRvIHRoaXMgcGF0Y2ggc2V0LCBleGNlcHQgb25lIGNoYW5nZSBpbiBwYXRjaCAx
LzUuCj4gQnV0IGFzIHRoaXMgYWxzbyB0b3VjaGVzIG9mX3RoZXJtYWwgYW5kIHJvY2tjaGlwIHRo
ZXJtYWwgZHJpdmVyLiBJJ2QKPiBsZWF2ZSB0aGlzIHBhdGNoIHNldCBmb3IgRWR1YXJkbyB0byBy
ZXZpZXcgYW5kIHRha2UuCj4gQlRXLCBFZHVhcmRvIGlzIHRyYXZlbGluZyByZWNlbnRseSwgc28g
eW91IG1heSBzdGlsbCBuZWVkIHRvIHdhaXQgc29tZQo+IHRpbWUuCgpPa2F5LCB0aGFua3MgZm9y
IHlvdXIgcmVtaW5kZXIuIGFuZCBzb3JyeSBmb3IgdGhlIG5vaXNlLjotKQoKLQpDYWVzYXIKCj4K
PiBUaGFua3MsCj4gcnVpCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKPiBMaW51eC1yb2NrY2hpcEBs
aXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1yb2NrY2hpcAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlzdApMaW51eC1yb2NrY2hp
cEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcm9ja2NoaXAK
