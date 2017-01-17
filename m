From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v7] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Tue, 17 Jan 2017 15:04:22 -0800
Message-ID: <CAJ_EiSTCo7ZYTfwFomXfyauEP65REp3Vd7jCCGf-OsT8N0rU7A@mail.gmail.com>
References: <20170113035432.6723-1-matt@ranostay.consulting>
 <20170113152049.GD5696@atomide.com>
 <CAJ_EiSR-R=5qUKOfHWTTrjj+ZD6Q6BBf1yPj3atf84Q6K03NZg@mail.gmail.com>
 <20170116171743.GB7403@atomide.com>
 <CAJ_EiSTStr1TfGE2zVspFF0DkkXLOCDmiqD_jZkzue-GfsTm+Q@mail.gmail.com>
 <d35dbc1b-da5b-a482-3688-f7b20278d5fb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d35dbc1b-da5b-a482-3688-f7b20278d5fb@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBKYW4gMTcsIDIwMTcgYXQgNDozNCBBTSwgUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVq
ZmFsdXNpQHRpLmNvbT4gd3JvdGU6Cj4gT24gMDEvMTYvMjAxNyAwOTozMCBQTSwgTWF0dCBSYW5v
c3RheSB3cm90ZToKPj4gWWVwIEkgd2FzIHRlc3Rpbmcgd2l0aCB0aGF0IGVuYWJsZWQuIE5vdCBz
dXJlIHdoeSBJJ20gbm90IGdldHRpbmcgaXQKPj4gYWxsLi4uIG1heWJlIGRpZmZlcmVudCBzaWRl
IGVmZmVjdHMgbGlrZSBzYW1wbGUgcmF0ZSBvZiB0aGUgYXVkaW8KPj4gYmVpbmcgcGxheWVkPwo+
Pgo+PiBQZXRlciwgaXMgdGhlcmUgY2hhbmNlIHRoYXQgdGhlcmUgaXMgcmFjZSBjb25kaXRpb24g
aXMgcG9zc2libGUKPj4gYmV0d2VlbiBwbV9xb3NfcmVtb3ZlX3JlcXVlc3QgYW5kIG9tYXBfbWNi
c3BfZGFpX3NodXRkb3duPwo+Cj4gTm90IHdpdGggbXkga25vd2xlZGdlLgo+IEhvd2V2ZXIgb25l
IHRoaW5nIG1pZ2h0IGhhcHBlbiB3aGljaCBpcyBub3QgaGFuZGxlZDoKPiBhcHBsaWNhdGlvbiBv
cGVucyB1cCB0aGUgYXVkaW8gY2FyZCwgZG9lcyBzb21lIGh3X3BhcmFtIHNldHVwLCB0aGVuIGl0
Cj4gZGVjaWRlcyB0byBjbG9zZSB0aGUgY2FyZC4gSW4gdGhpcyBjYXNlIHRoZSBwbV9xb3MgaXMg
bm90IHBsYWNlZCwgYnV0IGluCj4gZGFpX3NodXRkb3duIHdlIHRyeSB0byByZW1vdmUgaXQgLT4g
V0FSTigpLgo+Cj4gSSB0aGluayB3ZSBuZWVkIHRvIGNoZWNrIGVpdGhlciBpZiB0aGUgcG1fcW9z
IGlzIGFjdGl2ZSBhbmQgb25seSB0aGVuCj4gYm90aGVyIHdpdGggdGhlIHJlbW92YWwvdXBkYXRl
ZCBvciB3ZSBjYW4gY2hlY2sgaWYgdGhlCj4gbWNic3AtPmxhdGVuY3lbc3RyZWFtMV0gaXMgbm90
IDAsIHdoaWNoIHNob3VsZCBiZSB0aGUgc2FtZSBhcyBjaGVja2luZwo+IGZvciB0aGUgcG1fcW9z
IGFjdGl2ZQoKT2sgbWFrZXMgc2Vuc2UuIFdlaXJkIEknbSBub3Qgc2VlaW5nIGl0IGJ1dCBJIHdh
bnRlZCB0byBiZSBzdXJlIGFkZGluZwpjaGVja3Mgd2Fzbid0IGp1c3QgaGlkaW5nIGEgaXNzdWUu
CldpbGwgc3VibWl0IHY4Li4uICBhbmQgaG9wZWZ1bGx5IHRoYXQgaXMgdGhlIGZpbmFsIG9uZSEg
KmZpbmdlcnMgY3Jvc3NlZCoKCj4KPiAtLQo+IFDDqXRlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
