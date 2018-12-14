From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
Date: Fri, 14 Dec 2018 15:06:27 +0200
Message-ID: <0c53704e-2edd-8fe8-6fb4-f5865d62770b@ti.com>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213151703.GN6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213151703.GN6707@atomide.com>
Content-Language: en-US
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux@armlinux.org.uk, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

CgpPbiAxMy8xMi8yMDE4IDE3LjE3LCBUb255IExpbmRncmVuIHdyb3RlOgo+ICogUGV0ZXIgVWpm
YWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4gWzE4MTIxMyAxMzo1N106Cj4+IEFmdGVyIHNv
bWUgZGVidWdnaW5nIEkgaGF2ZSBtYW5hZ2VkIHRvIGdldCB0aGUgZXRoZXJuZXQgd29ya2luZyB3
aXRoCj4+IG1haW5saW5lIHUtYm9vdCB3aGlsZSBub3QgYnJlYWtpbmcgdGhlIG5ldHdvcmtpbmcg
d2l0aCB0aGUgY2FzZSB3aGVuIHdlCj4+IGJvb3Qgd2l0aCB0aGUgbXlzdGVyaW91cyBiaW5hcnkg
dS1ib290Lgo+IAo+IEknbSBwcmV0dHkgc3VyZSB0aGlzIGlzIHRoZSBtb3N0IHJlY2VudCB2ZXJz
aW9uIG9mCj4gV0lQIHUtYm9vdCBTUEkgc3VwcG9ydCBmcm9tIE5pc2hhbnRoOgo+IAo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9ubWVub24vdS1ib290L3RyZWUvdjIwMTQuMDQtbW9kL3NkcDQ0MzAtZXRo
ZXJuZXQKCkNvb2wsIHRoYW5rcyEKCkl0IGZhaWxzIHRvIGNvbXBpbGUgc28gZmFyIHdpdGggYW55
IG9mIHRoZSB0b29sY2hhaW5zIEkgaGF2ZSB0cmllZCBzbyBmYXIgOigKCj4gRnJvbSB3aGF0IEkg
cmVjYWxsLCB0aGF0IGRpZCBub3Qgd29yayBmb3IgQmxhemUgdGhvdWdoCj4gZm9yIGVuYWJsaW5n
IEV0aGVybmV0IGZvciB0ZnRwIGJvb3RpbmcgYnV0IHdvcmtlZCBvbgo+IDQ0MzAtc2RwLiBNYXli
ZSBiZWNhdXNlIG9mIHRoZSBzYW1lIGlzc3VlcyBhcyB0aGVzZQo+IGtlcm5lbCBwYXRjaGVzIHRo
b3VnaC4KCk15IEJsYXplIGlzIHRoZSAnYmlnIHBob25lIHcvIHR3byBkaXNwbGF5JyBhbmQgbm90
IHRoZSB0YWJsZXQuIEFmYWlrIGl0CmlzIGEgc2hyaW5rIGRvd24gdmVyc2lvbiBvZiBzZHAuCgpB
bmQgdGhlIHUtYm9vdCBjb2RlIHN0aWxsIGxlYXZlcyBvcGVuIHRoZSBxdWVzdGlvbnMgcmVnYXJk
aW5nIHRvIHBpbm1peAphbmQgZ3Bpb18xMzguCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMg
RmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1
c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
