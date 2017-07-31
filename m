From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH RESEND] fbdev: omapfb: remove unused variable
Date: Mon, 31 Jul 2017 18:38:19 +0200
Message-ID: <2971705.ICzXV4uNZt@amdc3058>
References: <CGME20170726135825epcas4p3c5326b3893927c4be0db0fde076d0799@epcas4p3.samsung.com>
 <20170726135816.2216688-1-arnd@arndb.de> <10646277.hB6jvi1uWb@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <10646277.hB6jvi1uWb@amdc3058>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gV2VkbmVzZGF5LCBKdWx5IDI2LCAyMDE3IDA0OjI3OjMwIFBNIEJhcnRsb21pZWogWm9sbmll
cmtpZXdpY3ogd3JvdGU6Cj4gCj4gSGksCj4gCj4gT24gV2VkbmVzZGF5LCBKdWx5IDI2LCAyMDE3
IDAzOjU3OjU1IFBNIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gPiBSZW1vdmluZyB0aGUgZGVmYXVs
dCBkaXNwbGF5IG5hbWUgbGVmdCBhIGhhcm1sZXNzIHdhcm5pbmc6Cj4gPiAKPiA+IGZiZGV2L29t
YXAyL29tYXBmYi9kc3MvY29yZS5jOiBJbiBmdW5jdGlvbiAnb21hcF9kc3NfcHJvYmUnOgo+ID4g
ZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9jb3JlLmM6MTk2OjMwOiBlcnJvcjogdW51c2VkIHZhcmlh
YmxlICdwZGF0YScgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQo+ID4gCj4gPiBUaGlzIHJlbW92
ZXMgdGhlIG5vdy11bnVzZWQgdmFyaWFibGUgYXMgd2VsbC4KPiA+IAo+ID4gRml4ZXM6IDI3OGNi
YTdlYWY1NCAoImRybTogb21hcGRybTogUmVtb3ZlIHVudXNlZCBkZWZhdWx0IGRpc3BsYXkgbmFt
ZSBzdXBwb3J0IikKPiA+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+Cj4gPiBSZXZpZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBp
ZGVhc29uYm9hcmQuY29tPgo+ID4gLS0tCj4gPiBPcmlnaW5hbGx5IHN1Ym1pdHRlZCBvbiBKdW5l
IDksIG5vIHJlcGx5IG90aGVyIHRoYW4gdGhlIFJldmlld2VkLWJ5IHRhZy4KPiA+IFRoZSBwYXRj
aCBpcyBzdGlsbCBuZWVkZWQKPiAKPiBJdCBpcyBub3QgbG9zdCBhbmQgd2lsbCBiZSBxdWV1ZWQg
Zm9yIDQuMTMgZmJkZXYgZml4ZXMgcHVsbCByZXF1ZXN0Lgo+IAo+IFsgVGhlIGd1aWx0eSBjb21t
aXQgd2VudCB0aHJvdWdoIERSTSB0cmVlIGFuZCBwdWxsaW5nIGl0IGludG8gZmJkZXYKPiAgIHRy
ZWUganVzdCB0byBmaXggdGhlIHdhcm5pbmcgd2FzIG5vdCBmZWFzaWJsZS4uIF0KClBhdGNoIHF1
ZXVlZCBmb3IgNC4xMywgdGhhbmtzLiAKCkJlc3QgcmVnYXJkcywKLS0KQmFydGxvbWllaiBab2xu
aWVya2lld2ljegpTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kClNhbXN1bmcgRWxlY3Ryb25p
Y3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
