From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] fbdev: omapfb: remove unused variable
Date: Wed, 26 Jul 2017 16:31:38 +0200
Message-ID: <CAK8P3a3CrnkRW61eX03tWnd4gt6uA+fq2Oe+VHf=00W5AHyNXA@mail.gmail.com>
References: <CGME20170726135825epcas4p3c5326b3893927c4be0db0fde076d0799@epcas4p3.samsung.com>
 <20170726135816.2216688-1-arnd@arndb.de> <10646277.hB6jvi1uWb@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <10646277.hB6jvi1uWb@amdc3058>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gV2VkLCBKdWwgMjYsIDIwMTcgYXQgNDoyNyBQTSwgQmFydGxvbWllaiBab2xuaWVya2lld2lj
ego8Yi56b2xuaWVya2llQHNhbXN1bmcuY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gT24gV2VkbmVz
ZGF5LCBKdWx5IDI2LCAyMDE3IDAzOjU3OjU1IFBNIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+IFJl
bW92aW5nIHRoZSBkZWZhdWx0IGRpc3BsYXkgbmFtZSBsZWZ0IGEgaGFybWxlc3Mgd2FybmluZzoK
Pj4KPj4gZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9jb3JlLmM6IEluIGZ1bmN0aW9uICdvbWFwX2Rz
c19wcm9iZSc6Cj4+IGZiZGV2L29tYXAyL29tYXBmYi9kc3MvY29yZS5jOjE5NjozMDogZXJyb3I6
IHVudXNlZCB2YXJpYWJsZSAncGRhdGEnIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KPj4KPj4g
VGhpcyByZW1vdmVzIHRoZSBub3ctdW51c2VkIHZhcmlhYmxlIGFzIHdlbGwuCj4+Cj4+IEZpeGVz
OiAyNzhjYmE3ZWFmNTQgKCJkcm06IG9tYXBkcm06IFJlbW92ZSB1bnVzZWQgZGVmYXVsdCBkaXNw
bGF5IG5hbWUgc3VwcG9ydCIpCj4+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Cj4+IFJldmlld2VkLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNo
YXJ0QGlkZWFzb25ib2FyZC5jb20+Cj4+IC0tLQo+PiBPcmlnaW5hbGx5IHN1Ym1pdHRlZCBvbiBK
dW5lIDksIG5vIHJlcGx5IG90aGVyIHRoYW4gdGhlIFJldmlld2VkLWJ5IHRhZy4KPj4gVGhlIHBh
dGNoIGlzIHN0aWxsIG5lZWRlZAo+Cj4gSXQgaXMgbm90IGxvc3QgYW5kIHdpbGwgYmUgcXVldWVk
IGZvciA0LjEzIGZiZGV2IGZpeGVzIHB1bGwgcmVxdWVzdC4KCk9rLCB0aGFua3MgYSBsb3QhCgo+
IFsgVGhlIGd1aWx0eSBjb21taXQgd2VudCB0aHJvdWdoIERSTSB0cmVlIGFuZCBwdWxsaW5nIGl0
IGludG8gZmJkZXYKPiAgIHRyZWUganVzdCB0byBmaXggdGhlIHdhcm5pbmcgd2FzIG5vdCBmZWFz
aWJsZS4uIF0KClllcywgSSB3YXMgb3JpZ2luYWxseSBob3BpbmcgdGhlIGZpeCBjb3VsZCBiZSBt
ZXJnZWQgYWxvbmcgd2l0aCB0aGUKcGF0Y2ggdGhhdCBpbnRyb2R1Y2VkIHRoZSBidWcuIEkgbWF5
IGhhdmUgbWVzc2VkIHVwIHRoZSBDYyBsaXN0IGZvciB0aGF0CnRob3VnaC4KCiAgICAgICBBcm5k
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
