From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: Fix potential NULL pointer dereference in kmalloc
Date: Mon, 1 Apr 2019 15:01:46 +0200
Message-ID: <d9416512-1daf-252d-409c-5826445510b0@samsung.com>
References: <CGME20190302204019epcas2p39a9b9bc29383567d5442fcb3a7efaeed@epcas2p3.samsung.com>
 <20190302204006.9953-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190302204006.9953-1-pakki001@umn.edu>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Aditya Pakki <pakki001@umn.edu>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Ck9uIDAzLzAyLzIwMTkgMDk6NDAgUE0sIEFkaXR5YSBQYWtraSB3cm90ZToKPiBNZW1vcnkgYWxs
b2NhdGVkLCB1c2luZyBrbWFsbG9jLCBmb3IgbmV3X2NvbXBhdCBtYXkgZmFpbC4gVGhpcyBwYXRj
aAo+IGNoZWNrcyBmb3Igc3VjaCBhbiBlcnJvciBhbmQgcHJldmVudHMgcG90ZW50aWFsIE5VTEwg
cG9pbnRlcgo+IGRlcmVmZXJlbmNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBQYWtraSA8
cGFra2kwMDFAdW1uLmVkdT4KClBhdGNoIHF1ZXVlZCBmb3IgdjUuMiwgdGhhbmtzLgoKQmVzdCBy
ZWdhcmRzLAotLQpCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6ClNhbXN1bmcgUiZEIEluc3RpdHV0
ZSBQb2xhbmQKU2Ftc3VuZyBFbGVjdHJvbmljcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWw=
