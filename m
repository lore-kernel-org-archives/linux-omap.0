From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 8 Jan 2016 09:04:46 -0800
Message-ID: <20160108170445.GV12777@atomide.com>
References: <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com> <20160108075636.GM11364@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160108075636.GM11364@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

KiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+IFsxNjAxMDcgMjM6NTddOgo+IE9u
IFRodXJzZGF5IDA3IEphbnVhcnkgMjAxNiAxODoyNjoyMCBUb255IExpbmRncmVuIHdyb3RlOgo+
ID4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGJldHdlZW4gTk9MTyBhbmQga2VybmVsIHRoZXJlIGlz
IHUtYm9vdC4gQW5kIGV2ZW4gaWYgSQo+ID4gPiBhbSBhbG1vc3Qgc3VyZSBpdCBkb2Vzbid0IHRv
dWNoIG9uZW5hbmQgY29uZmlncywgSSBjYW4ndCBiZSBhYnNvbHV0ZWx5IHN1cmUuCj4gPiA+IFNv
IHRob3NlIHRpbWluZ3MgYXJlIG5vdCAxMDAlIHJlbGlhYmxlIElNTywgdGhvdWdoIGNsb3NlIHRv
IHRoYXQuCj4gPiAKPiA+IEhtbSB5ZXMgSSdtIG9ubHkgYm9vdGluZyB3aXRoIHUtYm9vdCBoZXJl
IGFzIG15IGRldmljZSBzaXRzIGluIG15IHJhY2suCj4gCj4gVS1ib290IHRyeSB0byBjb25maWd1
cmUgTjkwMCBkZXZpY2Ugc2ltaWxhciBsaWtlIChzb21lIG9sZGVyIHZlcnNpb24gb2YpCj4gbGlu
dXgga2VybmVsLiBTbyB0ZXN0aW5nIHRoZXNlIGJ1Z3Mgc2hvdWxkIGJlIGRvbmUgYWxzbyBkaXJl
Y3RseSBmcm9tCj4gTk9MTyB3aXRob3V0IFUtYm9vdC4KCk9LCgo+IEJ0dywgaWYgeW91IGhhdmUg
dXNiIGNvbm5lY3Rpb24gdG8geW91ciBkZXZpY2UgaW4geW91ciByYWNrLCB5b3UgY2FuIHVzZQo+
IDB4RkZGRiB0b29sIChvcGVuIHNvdXJjZSkgd2hpY2ggY2FuIHNlbmQga2VybmVsIGltYWdlIHRv
IE5PTE8gd2hpY2ggd2lsbAo+IGJvb3QgaXQgd2l0aG91dCBmbGFzaGluZyBOQU5ELgo+IAo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9wYWxpLzB4RkZGRgo+IAo+IE9yaWdpbmFsIE5va2lhIGZsYXNoZXIt
My41IGNvdWxkIHN1cHBvcnQgYWxzbyBzZXJpYWwgY29ubmVjdGlvbiAobm90Cj4gb25seSB1c2Ip
LCBidXQgZG8gbm90IGtub3cuIEkgaGF2ZSBuZXZlciB1c2VkIHNlcmlhbCBjb25uZWN0b3Igb24g
bXkKPiBOOTAwLCBzbyBJIGRvIG5vdCBrbm93IGFuZCB0aGlzIGlzIHJlYXNvbiB3aHkgYWxzbyAw
eEZGRkYgaGFzIG5vIHNlcmlhbAo+IHN1cHBvcnQuLi4KCll1cCBJJ20gdXNpbmcgMHhGRkZGIGZv
ciBsb2FkaW5nIGltYWdlcyBvbiA3NzAgYW5kIG44MDAgaGVyZS4gV2VsbCBvbmNlCkkgZ2V0IG15
IHJhY2sgcHV0IHRvZ2V0aGVyIGFnYWluIG92ZXIgbmV4dCBmZXcgZGF5cy4uCgpSZWdhcmRzLAoK
VE9ueQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
