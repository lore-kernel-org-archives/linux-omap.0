From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 11:50:14 +0100
Message-ID: <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171128102327.GA30267@lenoch>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-omap@vger.kernel.org

Pj4gSG93IHdpbGwgdGhpcyBhc3BlY3QgZXZvbHZlIGZ1cnRoZXI/Cj4gCj4gSSBkbyBub3QgZm9s
bG93LgoKSW50ZXJlc3Rpbmcg4oCmCgoKPiBUaGlzIGlzIE9NQVAgZnJhbWVidWZmZXIgZHJpdmVy
LCBzbyBpbiB0aGlzIGNhc2UsIHRoZXJlIGlzIHplcm8gdmFyaWF0aW9uLgoKSG93IG11Y2ggYXJl
IHlvdSBpbnRlcmVzdGVkIHRvIGNvbXBhcmUgZGlmZmVyZW5jZXMgaW4gYnVpbGQgcmVzdWx0cwph
bHNvIGZvciB0aGlzIHNvZnR3YXJlIG1vZHVsZSBiZWNhdXNlIG9mIHZhcnlpbmcgcGFyYW1ldGVy
cz8KCldoaWNoIHBhcmFtZXRlcnMgd2VyZSBhcHBsaWVkIGZvciB5b3VyIHNpemUgY29tcGFyaXNv
bnMgc28gZmFyPwoKCj4gQ291bGQgeW91LCBwbGVhc2UsIHJldmlldyBmb2xsb3dpbmcgcGF0Y2gK
CkkgYXNzdW1lIHRoYXQgb3RoZXIgT01BUCBkZXZlbG9wZXJzIGFyZSBpbiBhIGJldHRlciBwb3Np
dGlvbiB0byBkZWNpZGUKYWJvdXQgdGhlIGRlbGV0aW9uIG9mIGV4dHJhIG1lbW9yeSBhbGxvY2F0
aW9ucyAoaW5zdGVhZCBvZiBrZWVwaW5nCnF1ZXN0aW9uYWJsZSBlcnJvciBtZXNzYWdlcykuCgoK
PiBhbmQgdmVyaWZ5IGlzIGl0IHNhdGlzZmllcyB5b3VyIGF1dG9tYXRlZCBzdGF0aWMgY29kZSBh
bmFseXNpcyB0ZXN0PwoKSSBhbSBub3QgZ29pbmcgdG8g4oCcdmVyaWZ54oCdIHlvdXIgdXBkYXRl
IHN1Z2dlc3Rpb24gYnkgbXkgZXZvbHZpbmcgYXBwcm9hY2hlcwphcm91bmQgdGhlIHNlbWFudGlj
IHBhdGNoIGxhbmd1YWdlIChDb2NjaW5lbGxlIHNvZnR3YXJlKSBhdCB0aGUgbW9tZW50LgoKQnV0
IEkgdGhhbmsgeW91IGZvciB0aGlzIGNvbnRyaWJ1dGlvbi4KSG93IHdpbGwgZnVydGhlciBmZWVk
YmFjayBldm9sdmUgZm9yIHN1Y2ggYW4gaWRlYT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
