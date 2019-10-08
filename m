From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 7/7] drm/omap: hdmi4: fix use of uninitialized var
Date: Tue, 8 Oct 2019 17:16:30 +0300
Message-ID: <ffb498fb-5041-d3e9-2702-879f3d389adf@ti.com>
References: <20190930103840.18970-1-tomi.valkeinen@ti.com>
 <20190930103840.18970-8-tomi.valkeinen@ti.com>
 <20191008141335.GB5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191008141335.GB5610@atomide.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

T24gMDgvMTAvMjAxOSAxNzoxMywgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiAqIFRvbWkgVmFsa2Vp
bmVuIDx0b21pLnZhbGtlaW5lbkB0aS5jb20+IFsxOTA5MzAgMTA6MzhdOgo+PiBJZiB1c2VfbWNs
ayBpcyBmYWxzZSwgbWNsa19tb2RlIGlzIHdyaXR0ZW4gdG8gYSByZWdpc3RlciB3aXRob3V0Cj4+
IGluaXRpYWxpemF0aW9uLiBUaGlzIGRvZXNuJ3QgY2F1c2UgYW55IGlsbCBlZmZlY3RzIGFzIHRo
ZSB3cml0dGVuIHZhbHVlCj4+IGlzIG5vdCB1c2VkIHdoZW4gdXNlX21jbGsgaXMgZmFsc2UuCj4+
Cj4+IFRvIGZpeCB0aGlzLCB3cml0ZSB1c2VfbWNsayBvbmx5IHdoZW4gdXNlX21jbGsgaXMgdHJ1
ZS4KPiAKPiBIZXkgbmljZSBjYXRjaC4gQmFzZWQgb24gYSBxdWljayB0ZXN0IGxvb2tzIGxpa2Ug
dGhpcyBmaXhlcyBhbgo+IGlzc3VlIHdoZXJlIHBvd2VyIGNvbnN1bXB0aW9uIHN0YXlzIGhpZ2hl
ciBhZnRlciB1c2luZyBIRE1JLgo+IAo+IFdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBtZXJnZWQgaW4g
dGhlIHY1LjQtcmMgc2VyaWVzOgo+IAo+IFRlc3RlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBh
dG9taWRlLmNvbT4KClJlYWxseT8gT2ssIHdlbGwsIHRoZW4gaXQgd2FzIGEgZ29vZCByYW5kb20g
ZmluZCA9KS4KCkkgZGlkIGFscmVhZHkgcHVzaCB0aGlzIHRvIGRybS1taXNjLW5leHQsIGFzIEkg
dGhvdWdodCBpdCBkb2VzIG5vdCBoYXZlIAphbnkgcmVhbCBlZmZlY3QuIEknbGwgY2hlY2sgaWYg
aXQncyBvayB0byBwdXNoIHRvIGRybS1taXNjLWZpeGVzIHRvbywgCndpdGggQ2Mgc3RhYmxlLgoK
ICBUb21pCgotLSAKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAy
MiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlw
YWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbA==
