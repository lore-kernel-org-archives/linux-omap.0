From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
Date: Wed, 15 Nov 2017 17:29:25 +0100
Message-ID: <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
 <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, letux-kernel@openphoenux.org, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

SGkgQW5kcmVhcywKCj4gQW0gMTUuMTEuMjAxNyB1bSAxNjo1MyBzY2hyaWViIEFuZHJlYXMgRsOk
cmJlciA8YWZhZXJiZXJAc3VzZS5kZT46Cj4gCj4gSGksCj4gCj4gQW0gMTUuMTEuMjAxNyB1bSAx
NjoxOSBzY2hyaWViIEguIE5pa29sYXVzIFNjaGFsbGVyOgo+PiBUaGlzIGFsbG93cyB0byBzZXQg
Q09ORklHX1cyU0cwMDA0X0RFQlVHIHdoaWNoIHdpbGwKPj4gbWFrZSB0aGUgZHJpdmVyIHJlcG9y
dCBtb3JlIGFjdGl2aXRpZXMgYW5kIGl0IHdpbGwgdHVybiBvbiB0aGUKPj4gR1BTIG1vZHVsZSBk
dXJpbmcgYm9vdCB3aGlsZSB0aGUgZHJpdmVyIGFzc3VtZXMgdGhhdCBpdAo+PiBpcyBvZmYuIFRo
aXMgY2FuIGJlIHVzZWQgdG8gZGVidWcgdGhlIGNvcnJlY3QgZnVuY3Rpb25pbmcgb2YKPj4gdGhl
IGhhcmR3YXJlLiBUaGVyZWZvcmUgd2UgYWRkIGl0IGFzIGFuIG9wdGlvbiB0byB0aGUgZHJpdmVy
Cj4+IGJlY2F1c2Ugd2UgdGhpbmsgaXQgaXMgb2YgZ2VuZXJhbCB1c2UgKGFuZCBhIGxpdHRsZSB0
cmlja3kgdG8KPj4gYWRkIGJ5IHN5c3RlbSB0ZXN0ZXJzKS4KPj4gCj4+IE5vcm1hbGx5IGl0IHNo
b3VsZCBiZSBvZmYuCj4+IC0tLQo+IAo+IElmIHlvdSB3YW50IHRvIG1lcmdlIHRoaXMsIGl0IGlz
IGxhY2tpbmcgYSBTb2IuCgpXaGF0cyBpcyBhICJTb2IiIGluIHRoaXMgY29udGV4dCAoaHR0cHM6
Ly9hY3Jvbnltcy50aGVmcmVlZGljdGlvbmFyeS5jb20vU09CKT8KCkJSIGFuZCB0aGFua3MsCk5p
a29sYXVzIFNjaGFsbGVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
