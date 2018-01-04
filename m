From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: omap2: Use PTR_ERR_OR_ZERO()
Date: Thu, 04 Jan 2018 14:58:15 +0100
Message-ID: <9921994.QtZC9fnTIs@amdc3058>
References: <CGME20171129162304epcas5p4874d26ebbc84f3e2a9804548b6deb762@epcas5p4.samsung.com>
 <1511972570-30240-1-git-send-email-gomonovych@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <1511972570-30240-1-git-send-email-gomonovych@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gV2VkbmVzZGF5LCBOb3ZlbWJlciAyOSwgMjAxNyAwNToyMjo0OCBQTSBWYXN5bCBHb21vbm92
eWNoIHdyb3RlOgo+IEZpeCBwdHJfcmV0LmNvY2NpIHdhcm5pbmdzOgo+IGRyaXZlcnMvdmlkZW8v
ZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9oZG1pNC5jOjY3NjoxLTM6IFdBUk5JTkc6IFBUUl9FUlJf
T1JfWkVSTyBjYW4gYmUgdXNlZAo+IAo+IFVzZSBQVFJfRVJSX09SX1pFUk8gcmF0aGVyIHRoYW4g
aWYoSVNfRVJSKC4uLikpICsgUFRSX0VSUgo+IAo+IEdlbmVyYXRlZCBieTogc2NyaXB0cy9jb2Nj
aW5lbGxlL2FwaS9wdHJfcmV0LmNvY2NpCj4gCj4gU2lnbmVkLW9mZi1ieTogVmFzeWwgR29tb25v
dnljaCA8Z29tb25vdnljaEBnbWFpbC5jb20+CgpQYXRjaCBxdWV1ZWQgZm9yIDQuMTYsIHRoYW5r
cy4KCkJlc3QgcmVnYXJkcywKLS0KQmFydGxvbWllaiBab2xuaWVya2lld2ljegpTYW1zdW5nIFIm
RCBJbnN0aXR1dGUgUG9sYW5kClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
