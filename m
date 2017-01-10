From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Tue, 10 Jan 2017 09:38:18 +0200
Message-ID: <7ca677ec-e79d-2418-5435-3cbecb1da3e0@ti.com>
References: <20170105015918.21621-1-matt@ranostay.consulting>
 <1372efd2-5319-e6c4-629e-6ed5f2e2fe29@ti.com>
 <20170109192123.GN2630@atomide.com>
 <CAJ_EiSRiSSUxDoza0a5gHuP8mvOteZ=9Mi=G91r++QUbgaXpXA@mail.gmail.com>
 <20170109215624.GQ2630@atomide.com>
 <CAJ_EiSRCBQWZfMOE-jpXVsSok3nSPwNN-+LzhBa1pcgu36UEfw@mail.gmail.com>
 <20170109235628.GR2630@atomide.com>
 <CAJ_EiSR3aZQztVKhQsnmVQUAgdDo0mtBZZ1=9LrHGOimGr-qaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAJ_EiSR3aZQztVKhQsnmVQUAgdDo0mtBZZ1=9LrHGOimGr-qaA@mail.gmail.com>
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

T24gMDEvMTAvMjAxNyAwNToyMyBBTSwgTWF0dCBSYW5vc3RheSB3cm90ZToKPiBZZWFoIEkgY2Fu
IHJlcHJvZHVjZSB0aGUgaXNzdWUgeW91IGFyZSBtZW50aW9uaW5nLiBBbnlvbmUgaGF2ZSBhCj4g
c3VnZ2VzdGlvbiBob3cgb24gdG8gcmVzb2x2ZT8gR3Vlc3NpbmcgdGhlIFFvUyBmdW5jdGlvbiBj
YWxscyBuZWVkIHRvCj4gYmUgaW4gYW4gYXRvbWljIGNvbnRleHQgYW5kIHRoZSBvbWFwX21jYnNw
XyogZnVuY3Rpb25zIGNhbiBzbGVlcAoKSSB0aGluayBpdCBpcyB0aGUgb3RoZXIgd2F5IGFyb3Vu
ZDogd2UgY2FsbCBhIHNsZWVwaW5nIGZ1bmN0aW9uIGZyb20KYXRvbWljIGNvbnRleHQuIHBjbV90
cmlnZ2VyIGlzIGF0b21pYy4KCk1vc3QgcHJvYmFibHkgd2Ugc2hvdWxkIGFkZCB0aGUgLnByZXBh
cmUgY2FsbGJhY2sgdG8gbWNic3BfZGFpX29wcyBhbmQKZG8gdGhlIFFvUyB1cGRhdGUgd2hpY2gg
aXMgZG9uZSBpbiBvbWFwX21jYnNwX3N0YXJ0KCkgdGhlcmUuIFRoZSB0aGluZ3MKd2UgZG8gaW4g
b21hcF9tY2JzcF9zdG9wKCkgdGhlbiBjYW4gYmUgbW92ZWQgdG8gb21hcF9tY2JzcF9kYWlfc2h1
dGRvd24oKS4KCkkgdGhpbmsgdGhlIGNvZGUgd291bGQgaGFuZGxlIGNhc2VzIHdoZW4gdXNlciBz
cGFjZSBzdG9wcyB0aGUgc3RyZWFtLApyZS1jb25maWd1cmVzIGl0IGFuZCBzdGFydHMgaXQgd2l0
aCBkaWZmZXJlbnQgcGFyYW1ldGVycyB3L28gY2xvc2luZyBpdC4KCi0tIApQw6l0ZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
