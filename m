From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 7/7] drm/omap: hdmi4: fix use of uninitialized var
Date: Tue, 8 Oct 2019 07:13:35 -0700
Message-ID: <20191008141335.GB5610@atomide.com>
References: <20190930103840.18970-1-tomi.valkeinen@ti.com>
 <20190930103840.18970-8-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190930103840.18970-8-tomi.valkeinen@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

KiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AdGkuY29tPiBbMTkwOTMwIDEwOjM4XToK
PiBJZiB1c2VfbWNsayBpcyBmYWxzZSwgbWNsa19tb2RlIGlzIHdyaXR0ZW4gdG8gYSByZWdpc3Rl
ciB3aXRob3V0Cj4gaW5pdGlhbGl6YXRpb24uIFRoaXMgZG9lc24ndCBjYXVzZSBhbnkgaWxsIGVm
ZmVjdHMgYXMgdGhlIHdyaXR0ZW4gdmFsdWUKPiBpcyBub3QgdXNlZCB3aGVuIHVzZV9tY2xrIGlz
IGZhbHNlLgo+IAo+IFRvIGZpeCB0aGlzLCB3cml0ZSB1c2VfbWNsayBvbmx5IHdoZW4gdXNlX21j
bGsgaXMgdHJ1ZS4KCkhleSBuaWNlIGNhdGNoLiBCYXNlZCBvbiBhIHF1aWNrIHRlc3QgbG9va3Mg
bGlrZSB0aGlzIGZpeGVzIGFuCmlzc3VlIHdoZXJlIHBvd2VyIGNvbnN1bXB0aW9uIHN0YXlzIGhp
Z2hlciBhZnRlciB1c2luZyBIRE1JLgoKV291bGQgYmUgbmljZSB0byBoYXZlIG1lcmdlZCBpbiB0
aGUgdjUuNC1yYyBzZXJpZXM6CgpUZXN0ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlk
ZS5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
