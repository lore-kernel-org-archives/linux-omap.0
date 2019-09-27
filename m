From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Fri, 27 Sep 2019 09:21:59 +0300
Message-ID: <f6012b3a-7b96-6020-d09d-c458fa8742d8@ti.com>
References: <20190510194229.20628-1-aford173@gmail.com>
 <af325707-3e42-493d-e858-77878ef06138@ti.com>
 <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
 <7ada0752-6f65-2906-cb29-a47c9490fd57@ti.com>
 <CAHCN7xJexJvh71vyb31ETgo=n_y_CupHH-AZwVK9mZe3GzJfEQ@mail.gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com>
 <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
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
To: Adam Ford <aford173@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

T24gMjYvMDkvMjAxOSAxNzoxMiwgQWRhbSBGb3JkIHdyb3RlOgoKPj4gQW5kIHdoYXQgaXMgdGhl
IGhkbWk1X2NvbmZpZ3VyZSB0aGVyZT8gSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhlCj4+IGRy
aXZlciB0aGF0IHdvdWxkIHByaW50IGhkbWk1X2NvbmZpZ3VyZS4gQW5kLCBvZiBjb3Vyc2UsIHRo
ZXJlJ3Mgbm8KPj4gaGRtaTUgb24gdGhhdCBwbGF0Zm9ybS4gSG1tLCBvay4uLiBpdCdzIGZyb20g
Y29tcG9uZW50LmMsIHVzaW5nICIlcHMiLgo+PiBTb21laG93IHRoYXQgZ29lcyB3cm9uZy4gV2hp
Y2ggaXMgYSBiaXQgYWxhcm1pbmcsIGJ1dCBwZXJoYXBzIGEgdG90YWxseQo+PiBkaWZmZXJlbnQg
aXNzdWUuCj4gCj4gSSdsbCB0cnkgdG8gdGFrZSBhIGxvb2sgbGF0ZXIuICBGb3IgTG9naWMgUEQg
ZGlzdHJpYnV0aW9ucywgd2UgY3JlYXRlCj4gYSBjdXN0b20gZGVmY29uZmlnIHdpdGggYWxsIHRo
b3NlIGRyaXZlcnMgcmVtb3ZlZCwgc28gSSdtIG5vdCB3b3JrZWQKPiB1cCBhYm91dCBpdCwgYnV0
IGl0IHdvdWxkIGJlIG5pY2UgdG8gbm90IGNhbGwgZHJpdmVycyB0aGF0IGRvbid0Cj4gZXhpc3Qu
CgpTbyB5b3UgaGF2ZSBDT05GSUdfT01BUDVfRFNTX0hETUk9bj8gVGhlbiBpdCdzIGV2ZW4gbW9y
ZSBkaXN0dXJiaW5nLCBhcyAKdGhlcmUncyBubyB3YXkgdGhlIHN0cmluZyAiaGRtaTVfY29uZmln
dXJlIiBjYW4gYmUgaW4gdGhlIGtlcm5lbCBpbWFnZS4uLgoKTWF5YmUgaXQncyBub3RoaW5nLCBi
dXQuLi4gSXQncyBqdXN0IHNvIG9kZC4KCiAgVG9taQoKLS0gClRleGFzIEluc3RydW1lbnRzIEZp
bmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNp
bmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
