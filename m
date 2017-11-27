From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 19:56:12 +0100
Message-ID: <CAMuHMdWqrTw80_t8Jr_ejzcLevXdxr-gnYgOQhk1-Mhn+v=A=w@mail.gmail.com>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
 <20171127174454.GA18851@lenoch>
 <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
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
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

SGkgTWFya3VzLAoKT24gTW9uLCBOb3YgMjcsIDIwMTcgYXQgNzoxMiBQTSwgU0YgTWFya3VzIEVs
ZnJpbmcKPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToKPj4+IENhbiBhIGRl
ZmF1bHQgYWxsb2NhdGlvbiBmYWlsdXJlIHJlcG9ydCBwcm92aWRlIHRoZSBpbmZvcm1hdGlvbgo+
Pj4gd2hpY2ggeW91IG1pZ2h0IGV4cGVjdCBzbyBmYXI/Cj4+Cj4+IFlvdSBzaG91bGQgYmUgYWJs
ZSB0byBhbnN3ZXIgdGhhdCBxdWVzdGlvbiB5b3Vyc2VsZi4KPgo+IEkgY2FuIG5vdCBhbnN3ZXIg
dGhpcyBkZXRhaWwgY29tcGxldGVseSBteXNlbGYgYmVjYXVzZSBteSBrbm93bGVkZ2UKPiBpcyBp
bmNvbXBsZXRlIGFib3V0IHlvdXIgY29uY3JldGUgZXhwZWN0YXRpb25zIGZvciB0aGUgZXhjZXB0
aW9uIGhhbmRsaW5nCj4gd2hpY2ggY2FuIGxlYWQgdG8gZGlmZmVyZW50IHZpZXdzIGZvciB0aGUg
bmVlZCBvZiBhZGRpdGlvbmFsIGVycm9yIG1lc3NhZ2VzLgoKSXQgbWF5IGJlIGEgZ29vZCBpZGVh
IHRvIHRyeSB0byB0cmlnZ2VyIGFuIG91dC1vZi1tZW1vcnkgY29uZGl0aW9uIHlvdXJzZWxmLAph
bmQgc2VlIHdoYXQgaGFwcGVucz8KCj4+IEFuZCBpZiB5b3UgYXJlIHVuYWJsZSB0byBkbyBzbywg
anVzdCBkbyBub3Qgc2VudCBjaGFuZ2VzIHBvaW50ZWQKPj4gYnkgYW55IGNvZGUgYW5hbHlzaXMg
dG9vbHMuCj4KPiBUaGV5IGNhbiBwb2ludCBhc3BlY3RzIG91dCBmb3IgZnVydGhlciBzb2Z0d2Fy
ZSBkZXZlbG9wbWVudCBjb25zaWRlcmF0aW9ucywKPiBjYW4ndCB0aGV5PwoKU3VyZS4gQnV0IEkg
dGhpbmsgaXQgaXMgYSBnb29kIGV4cGVyaWVuY2UgdG8gd2l0bmVzcyB3aGF0IGNhbiBoYXBwZW4g
aWYgeW91CiJ2aW9sYXRlIiB0aGVzZSAiY29kaW5nIHN0YW5kYXJkcyB3cml0dGVuIGJ5IG90aGVy
IHBlb3BsZSIsIGFuZCBsZWFybiB0bwp1bmRlcnN0YW5kIHdoeSB0aGV5IHdlcmUgd3JpdHRlbiwg
aW5jcmVhc2luZyB5b3VyIG93biBrbm93bGVkZ2UuCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNh
eSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
