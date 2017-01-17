From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v7] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Tue, 17 Jan 2017 14:34:36 +0200
Message-ID: <d35dbc1b-da5b-a482-3688-f7b20278d5fb@ti.com>
References: <20170113035432.6723-1-matt@ranostay.consulting>
 <20170113152049.GD5696@atomide.com>
 <CAJ_EiSR-R=5qUKOfHWTTrjj+ZD6Q6BBf1yPj3atf84Q6K03NZg@mail.gmail.com>
 <20170116171743.GB7403@atomide.com>
 <CAJ_EiSTStr1TfGE2zVspFF0DkkXLOCDmiqD_jZkzue-GfsTm+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAJ_EiSTStr1TfGE2zVspFF0DkkXLOCDmiqD_jZkzue-GfsTm+Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gMDEvMTYvMjAxNyAwOTozMCBQTSwgTWF0dCBSYW5vc3RheSB3cm90ZToKPiBZZXAgSSB3YXMg
dGVzdGluZyB3aXRoIHRoYXQgZW5hYmxlZC4gTm90IHN1cmUgd2h5IEknbSBub3QgZ2V0dGluZyBp
dAo+IGFsbC4uLiBtYXliZSBkaWZmZXJlbnQgc2lkZSBlZmZlY3RzIGxpa2Ugc2FtcGxlIHJhdGUg
b2YgdGhlIGF1ZGlvCj4gYmVpbmcgcGxheWVkPwo+IAo+IFBldGVyLCBpcyB0aGVyZSBjaGFuY2Ug
dGhhdCB0aGVyZSBpcyByYWNlIGNvbmRpdGlvbiBpcyBwb3NzaWJsZQo+IGJldHdlZW4gcG1fcW9z
X3JlbW92ZV9yZXF1ZXN0IGFuZCBvbWFwX21jYnNwX2RhaV9zaHV0ZG93bj8KCk5vdCB3aXRoIG15
IGtub3dsZWRnZS4KSG93ZXZlciBvbmUgdGhpbmcgbWlnaHQgaGFwcGVuIHdoaWNoIGlzIG5vdCBo
YW5kbGVkOgphcHBsaWNhdGlvbiBvcGVucyB1cCB0aGUgYXVkaW8gY2FyZCwgZG9lcyBzb21lIGh3
X3BhcmFtIHNldHVwLCB0aGVuIGl0CmRlY2lkZXMgdG8gY2xvc2UgdGhlIGNhcmQuIEluIHRoaXMg
Y2FzZSB0aGUgcG1fcW9zIGlzIG5vdCBwbGFjZWQsIGJ1dCBpbgpkYWlfc2h1dGRvd24gd2UgdHJ5
IHRvIHJlbW92ZSBpdCAtPiBXQVJOKCkuCgpJIHRoaW5rIHdlIG5lZWQgdG8gY2hlY2sgZWl0aGVy
IGlmIHRoZSBwbV9xb3MgaXMgYWN0aXZlIGFuZCBvbmx5IHRoZW4KYm90aGVyIHdpdGggdGhlIHJl
bW92YWwvdXBkYXRlZCBvciB3ZSBjYW4gY2hlY2sgaWYgdGhlCm1jYnNwLT5sYXRlbmN5W3N0cmVh
bTFdIGlzIG5vdCAwLCB3aGljaCBzaG91bGQgYmUgdGhlIHNhbWUgYXMgY2hlY2tpbmcKZm9yIHRo
ZSBwbV9xb3MgYWN0aXZlLgoKLS0gClDDqXRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
