From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] OMAPFB: prevent buffer underflow in
 omapfb_parse_vram_param()
Date: Fri, 17 Nov 2017 17:21:14 +0100
Message-ID: <2414894.T1ou5hczcE@amdc3058>
References: <CGME20171114061251epcas2p3eea18fd03e87cefd3d7b30750a0f1833@epcas2p3.samsung.com>
 <20171114061228.iv5irewl6ougl4zm@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <20171114061228.iv5irewl6ougl4zm@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gVHVlc2RheSwgTm92ZW1iZXIgMTQsIDIwMTcgMDk6MTI6MjggQU0gRGFuIENhcnBlbnRlciB3
cm90ZToKPiBXZSBjYXAgdGhlIHVwcGVyIGJvdW5kIG9mICJmYm51bSIgYnV0IHdlIGFsc28gbmVl
ZCB0byBjaGVjayBmb3IKPiBuZWdhdGl2ZXMgb3IgbWFrZSB0aGUgdHlwZSB1bnNpZ25lZC4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+
CgpQYXRjaCBxdWV1ZWQgZm9yIDQuMTUsIHRoYW5rcy4KCkJlc3QgcmVnYXJkcywKLS0KQmFydGxv
bWllaiBab2xuaWVya2lld2ljegpTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kClNhbXN1bmcg
RWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
