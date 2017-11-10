From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: Convert timers to use timer_setup()
Date: Fri, 10 Nov 2017 16:33:38 +0100
Message-ID: <1971713.1U12EbtSlg@amdc3058>
References: <CGME20171024152032epcas3p4976e268e33d58750b7c09380e857bba0@epcas3p4.samsung.com>
 <15752127.NCT7iFVURk@amdc3058>
 <CAGXu5jJHWHunEVKi-YUybMH+CnfOsaCgYoyO3zODG+GCKwB02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <CAGXu5jJHWHunEVKi-YUybMH+CnfOsaCgYoyO3zODG+GCKwB02A@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, "Gustavo A. R.
 Silva" <gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-omap@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
List-Id: linux-omap@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDA5LCAyMDE3IDEwOjQwOjEzIEFNIEtlZXMgQ29vayB3cm90
ZToKPiBPbiBUaHUsIE5vdiA5LCAyMDE3IGF0IDk6MDggQU0sIEJhcnRsb21pZWogWm9sbmllcmtp
ZXdpY3oKClsuLi5dCgo+ID4gWyBQbGVhc2UgY29tcGlsZSB0aGVzZSB0aW1lciBjaGFuZ2VzIHdp
dGggUFhBM1hYX0dDVV9ERUJVRyBhbmQKPiA+ICAgUFhBM1hYX0dDVV9ERUJVR19USU1FUiBkZWZp
bmVkLiBdCj4gCj4gSG0sIHRoZXNlIGFwcGVhciB0byBiZSBtYW51YWwga25vYnM/IFdoYXQgZG8g
eW91IHRoaW5rIGFib3V0IHdpcmluZwo+IHRoZXNlIHVwIHRvIGEgS2NvbmZpZyBzbyBidWlsZCB0
ZXN0cyBmb3IgdGhpbmdzIGxpa2UgIm1ha2UKPiBhbGxtb2Rjb25maWciIHdvdWxkIGVuYWJsZSBp
dD8gVGhpcyB3b3VsZCBhbGxvdyBmb3IgbXVjaCBncmVhdGVyIGJ1aWxkCj4gY292ZXJhZ2UuCgpU
aGlzIGlzIGEgZ29vZCBpZGVhLCBjYXJlIHRvIHNlbmQgYSBwYXRjaD8KCkJlc3QgcmVnYXJkcywK
LS0KQmFydGxvbWllaiBab2xuaWVya2lld2ljegpTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5k
ClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
