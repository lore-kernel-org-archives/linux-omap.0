From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fbdev: omapfb: off by one in omapfb_register_client()
Date: Tue, 24 Jul 2018 18:48:52 +0200
Message-ID: <8615162.0D3GuDQfVx@amdc3058>
References: <CGME20180713145615epcas3p4e584128beb220b339552ad92fe2eb3b4@epcas3p4.samsung.com>
 <20180713145555.sprrr4rl6eqspirz@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <20180713145555.sprrr4rl6eqspirz@kili.mountain>
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
Cc: linux-fbdev@vger.kernel.org, Imre Deak <imre.deak@solidboot.com>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gRnJpZGF5LCBKdWx5IDEzLCAyMDE4IDA1OjU1OjU1IFBNIERhbiBDYXJwZW50ZXIgd3JvdGU6
Cj4gVGhlIG9tYXBmYl9yZWdpc3Rlcl9jbGllbnRbXSBhcnJheSBoYXMgT01BUEZCX1BMQU5FX05V
TSBlbGVtZW50cyBzbyB0aGUKPiA+IHNob3VsZCBiZSA+PSBvciB3ZSBhcmUgb25lIGVsZW1lbnQg
YmV5b25kIHRoZSBlbmQgb2YgdGhlIGFycmF5Lgo+IAo+IEZpeGVzOiA4YjA4Y2YyYjY0ZjUgKCJP
TUFQOiBhZGQgVEkgT01BUCBmcmFtZWJ1ZmZlciBkcml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IERh
biBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KClBhdGNoIHF1ZXVlZCBmb3Ig
NC4xOSwgdGhhbmtzLgoKQmVzdCByZWdhcmRzLAotLQpCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6
ClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
