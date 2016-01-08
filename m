From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 8 Jan 2016 08:56:36 +0100
Message-ID: <20160108075636.GM11364@pali>
References: <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
 <20160106174039.GA14271@earth> <20160106174713.GL12777@atomide.com>
 <568D5669.4040801@gmail.com> <20160106182650.GM12777@atomide.com>
 <568D5F54.7040900@gmail.com> <20160107180700.GN12777@atomide.com>
 <568EDC8D.7070205@gmail.com> <20160108022619.GS12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160108022619.GS12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

T24gVGh1cnNkYXkgMDcgSmFudWFyeSAyMDE2IDE4OjI2OjIwIFRvbnkgTGluZGdyZW4gd3JvdGU6
Cj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGJldHdlZW4gTk9MTyBhbmQga2VybmVsIHRoZXJlIGlz
IHUtYm9vdC4gQW5kIGV2ZW4gaWYgSQo+ID4gYW0gYWxtb3N0IHN1cmUgaXQgZG9lc24ndCB0b3Vj
aCBvbmVuYW5kIGNvbmZpZ3MsIEkgY2FuJ3QgYmUgYWJzb2x1dGVseSBzdXJlLgo+ID4gU28gdGhv
c2UgdGltaW5ncyBhcmUgbm90IDEwMCUgcmVsaWFibGUgSU1PLCB0aG91Z2ggY2xvc2UgdG8gdGhh
dC4KPiAKPiBIbW0geWVzIEknbSBvbmx5IGJvb3Rpbmcgd2l0aCB1LWJvb3QgaGVyZSBhcyBteSBk
ZXZpY2Ugc2l0cyBpbiBteSByYWNrLgoKVS1ib290IHRyeSB0byBjb25maWd1cmUgTjkwMCBkZXZp
Y2Ugc2ltaWxhciBsaWtlIChzb21lIG9sZGVyIHZlcnNpb24gb2YpCmxpbnV4IGtlcm5lbC4gU28g
dGVzdGluZyB0aGVzZSBidWdzIHNob3VsZCBiZSBkb25lIGFsc28gZGlyZWN0bHkgZnJvbQpOT0xP
IHdpdGhvdXQgVS1ib290LgoKQnR3LCBpZiB5b3UgaGF2ZSB1c2IgY29ubmVjdGlvbiB0byB5b3Vy
IGRldmljZSBpbiB5b3VyIHJhY2ssIHlvdSBjYW4gdXNlCjB4RkZGRiB0b29sIChvcGVuIHNvdXJj
ZSkgd2hpY2ggY2FuIHNlbmQga2VybmVsIGltYWdlIHRvIE5PTE8gd2hpY2ggd2lsbApib290IGl0
IHdpdGhvdXQgZmxhc2hpbmcgTkFORC4KCmh0dHBzOi8vZ2l0aHViLmNvbS9wYWxpLzB4RkZGRgoK
T3JpZ2luYWwgTm9raWEgZmxhc2hlci0zLjUgY291bGQgc3VwcG9ydCBhbHNvIHNlcmlhbCBjb25u
ZWN0aW9uIChub3QKb25seSB1c2IpLCBidXQgZG8gbm90IGtub3cuIEkgaGF2ZSBuZXZlciB1c2Vk
IHNlcmlhbCBjb25uZWN0b3Igb24gbXkKTjkwMCwgc28gSSBkbyBub3Qga25vdyBhbmQgdGhpcyBp
cyByZWFzb24gd2h5IGFsc28gMHhGRkZGIGhhcyBubyBzZXJpYWwKc3VwcG9ydC4uLgoKLS0gClBh
bGkgUm9ow6FyCnBhbGkucm9oYXJAZ21haWwuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
