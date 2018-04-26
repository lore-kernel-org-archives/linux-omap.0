From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/3] video: omap: Improve a size determination in
 omapfb_do_probe()
Date: Thu, 26 Apr 2018 12:22:48 +0200
Message-ID: <6664625.Vrlhroeaex@amdc3058>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
 <CGME20171126174230epcas2p263bbe1e8888487b01b51550c24b5c0d4@epcas2p2.samsung.com>
 <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gU3VuZGF5LCBOb3ZlbWJlciAyNiwgMjAxNyAwNjo0MjoyMyBQTSBTRiBNYXJrdXMgRWxmcmlu
ZyB3cm90ZToKPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3Jn
ZS5uZXQ+Cj4gRGF0ZTogU3VuLCAyNiBOb3YgMjAxNyAxODoxNjoyMCArMDEwMAo+IAo+IFJlcGxh
Y2UgdGhlIHNwZWNpZmljYXRpb24gb2YgYSBkYXRhIHN0cnVjdHVyZSBieSBhIHBvaW50ZXIgZGVy
ZWZlcmVuY2UKPiBhcyB0aGUgcGFyYW1ldGVyIGZvciB0aGUgb3BlcmF0b3IgInNpemVvZiIgdG8g
bWFrZSB0aGUgY29ycmVzcG9uZGluZyBzaXplCj4gZGV0ZXJtaW5hdGlvbiBhIGJpdCBzYWZlciBh
Y2NvcmRpbmcgdG8gdGhlIExpbnV4IGNvZGluZyBzdHlsZSBjb252ZW50aW9uLgo+IAo+IFRoaXMg
aXNzdWUgd2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdl
Lm5ldD4KClBhdGNoIHF1ZXVlZCBmb3IgNC4xOCwgdGhhbmtzLgoKQmVzdCByZWdhcmRzLAotLQpC
YXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6ClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKU2Ft
c3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
