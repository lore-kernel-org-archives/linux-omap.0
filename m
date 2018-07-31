From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] media: omap2: omapfb: fix boolreturn.cocci warnings
Date: Tue, 31 Jul 2018 13:03:57 +0200
Message-ID: <1621309.sZUdEDiQYq@amdc3058>
References: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
 <CGME20180725175735epcas4p1bd4f49c171946156d847d643a6ea22c0@epcas4p1.samsung.com>
 <20180725175700.GA82131@lkp-sb05.lkp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <20180725175700.GA82131@lkp-sb05.lkp.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kbuild-all@01.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gVGh1cnNkYXksIEp1bHkgMjYsIDIwMTggMDE6NTc6MDAgQU0ga2J1aWxkIHRlc3Qgcm9ib3Qg
d3JvdGU6Cj4gRnJvbToga2J1aWxkIHRlc3Qgcm9ib3QgPGZlbmdndWFuZy53dUBpbnRlbC5jb20+
Cj4gCj4gZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvb21hcGZiLW1haW4uYzoyOTA6
OS0xMDogV0FSTklORzogcmV0dXJuIG9mIDAvMSBpbiBmdW5jdGlvbiAnY21wX3Zhcl90b19jb2xv
cm1vZGUnIHdpdGggcmV0dXJuIHR5cGUgYm9vbAo+IAo+ICBSZXR1cm4gc3RhdGVtZW50cyBpbiBm
dW5jdGlvbnMgcmV0dXJuaW5nIGJvb2wgc2hvdWxkIHVzZQo+ICB0cnVlL2ZhbHNlIGluc3RlYWQg
b2YgMS8wLgo+IEdlbmVyYXRlZCBieTogc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvYm9vbHJldHVy
bi5jb2NjaQo+IAo+IEZpeGVzOiA3Mzc4ZjExNDk4ODQgKCJtZWRpYTogb21hcDI6IG9tYXBmYjog
YWxsb3cgYnVpbGRpbmcgaXQgd2l0aCBDT01QSUxFX1RFU1QiKQo+IFNpZ25lZC1vZmYtYnk6IGti
dWlsZCB0ZXN0IHJvYm90IDxmZW5nZ3Vhbmcud3VAaW50ZWwuY29tPgoKUGF0Y2ggcXVldWVkIGZv
ciA0LjE5ICh3LyAibWVkaWEiLT4iZmJkZXYiIGZpeHVwIGluIHRoZSBwYXRjaCB0aXRsZSksIHRo
YW5rcy4KCkJlc3QgcmVnYXJkcywKLS0KQmFydGxvbWllaiBab2xuaWVya2lld2ljegpTYW1zdW5n
IFImRCBJbnN0aXR1dGUgUG9sYW5kClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
