From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v5] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Tue, 10 Jan 2017 09:27:23 -0800
Message-ID: <CAJ_EiSQT7wJStObghibssvm0ShsDjTX87PCjs4PT4px5H=cN7w@mail.gmail.com>
References: <20170105015918.21621-1-matt@ranostay.consulting>
 <1372efd2-5319-e6c4-629e-6ed5f2e2fe29@ti.com>
 <20170109192123.GN2630@atomide.com>
 <CAJ_EiSRiSSUxDoza0a5gHuP8mvOteZ=9Mi=G91r++QUbgaXpXA@mail.gmail.com>
 <20170109215624.GQ2630@atomide.com>
 <CAJ_EiSRCBQWZfMOE-jpXVsSok3nSPwNN-+LzhBa1pcgu36UEfw@mail.gmail.com>
 <20170109235628.GR2630@atomide.com>
 <CAJ_EiSR3aZQztVKhQsnmVQUAgdDo0mtBZZ1=9LrHGOimGr-qaA@mail.gmail.com>
 <7ca677ec-e79d-2418-5435-3cbecb1da3e0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <7ca677ec-e79d-2418-5435-3cbecb1da3e0@ti.com>
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

T24gTW9uLCBKYW4gOSwgMjAxNyBhdCAxMTozOCBQTSwgUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVq
ZmFsdXNpQHRpLmNvbT4gd3JvdGU6Cj4gT24gMDEvMTAvMjAxNyAwNToyMyBBTSwgTWF0dCBSYW5v
c3RheSB3cm90ZToKPj4gWWVhaCBJIGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlIHlvdSBhcmUgbWVu
dGlvbmluZy4gQW55b25lIGhhdmUgYQo+PiBzdWdnZXN0aW9uIGhvdyBvbiB0byByZXNvbHZlPyBH
dWVzc2luZyB0aGUgUW9TIGZ1bmN0aW9uIGNhbGxzIG5lZWQgdG8KPj4gYmUgaW4gYW4gYXRvbWlj
IGNvbnRleHQgYW5kIHRoZSBvbWFwX21jYnNwXyogZnVuY3Rpb25zIGNhbiBzbGVlcAo+Cj4gSSB0
aGluayBpdCBpcyB0aGUgb3RoZXIgd2F5IGFyb3VuZDogd2UgY2FsbCBhIHNsZWVwaW5nIGZ1bmN0
aW9uIGZyb20KPiBhdG9taWMgY29udGV4dC4gcGNtX3RyaWdnZXIgaXMgYXRvbWljLgo+Cj4gTW9z
dCBwcm9iYWJseSB3ZSBzaG91bGQgYWRkIHRoZSAucHJlcGFyZSBjYWxsYmFjayB0byBtY2JzcF9k
YWlfb3BzIGFuZAo+IGRvIHRoZSBRb1MgdXBkYXRlIHdoaWNoIGlzIGRvbmUgaW4gb21hcF9tY2Jz
cF9zdGFydCgpIHRoZXJlLiBUaGUgdGhpbmdzCj4gd2UgZG8gaW4gb21hcF9tY2JzcF9zdG9wKCkg
dGhlbiBjYW4gYmUgbW92ZWQgdG8gb21hcF9tY2JzcF9kYWlfc2h1dGRvd24oKS4KClNlZW1zIHJl
YXNvbmFibGUuIFdpbGwgcmV3b3JrIHBhdGNoc2V0IGFuZCByZXRlc3QuCgpUaGFua3MsCgpNYXR0
Cgo+Cj4gSSB0aGluayB0aGUgY29kZSB3b3VsZCBoYW5kbGUgY2FzZXMgd2hlbiB1c2VyIHNwYWNl
IHN0b3BzIHRoZSBzdHJlYW0sCj4gcmUtY29uZmlndXJlcyBpdCBhbmQgc3RhcnRzIGl0IHdpdGgg
ZGlmZmVyZW50IHBhcmFtZXRlcnMgdy9vIGNsb3NpbmcgaXQuCj4KPiAtLQo+IFDDqXRlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
