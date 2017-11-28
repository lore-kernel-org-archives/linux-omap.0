From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 19:09:11 +0100
Message-ID: <c0f850bc-0c4d-09d4-bdf4-049b3e00fc75@users.sourceforge.net>
References: <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
 <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
 <20171128114130.GA1615@lenoch>
 <bdf052ef-4f32-af1e-4b1b-6fb75e5e0af9@users.sourceforge.net>
 <20171128175016.GA3501@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171128175016.GA3501@lenoch>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-omap@vger.kernel.org

Pj4gQWRkaXRpb25hbCBpbXByb3ZlbWVudCBwb3NzaWJpbGl0aWVzIGNhbiBiZSB0YWtlbiBpbnRv
IGFjY291bnQKPj4gYWZ0ZXIgY29ycmVzcG9uZGluZyBzb2Z0d2FyZSBkZXZlbG9wbWVudCBkaXNj
dXNzaW9ucywgY2FuJ3QgdGhleT8KPiAKPiBTdXJlLCBidXQgdGhhdCBpcyBpbiBjb250cmFyeSB0
byBhbGwgeW91IHJlcGxpZXMuCgpXaGVyZSBkbyB5b3Ugc2VlIGEgY29udHJhZGljdGlvbiBpbiB0
aGlzIGNhc2U/CgoKPiBJIGd1ZXNzIHlvdSBhcmUgZmFtaWxpYXIgd2l0aCBEb2N1bWVudGF0aW9u
L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCBjaGFwdGVyIDguCgpJIGhvcGUgc28gaW4g
cHJpbmNpcGxlLgoKCj4gTm8gbWF0dGVyIHRoYXQgcGF0Y2ggd2FzIGdlbmVyYXRlZCBvciBzdWdn
ZXN0ZWQgYnkgYSB0b29sLCB5b3Ugc2VudAo+IGl0IGFuZCBub3JtYWwgcmV2aWV3IHByb2NlZHVy
ZSBmb2xsb3dzLgoKVGhpcyBpcyBnZW5lcmFsbHkgZmluZS4KCgo+IEFuZCBoZXJlIHlvdSBpZ25v
cmVkIF9hbGxfIHN1Z2dlc3Rpb25zCgpJIGRpZCBub3QgaW50ZWdyYXRlIGEgZmV3IG9mIHRoZW0g
Zm9yIG15IGNvbW1pdCBtZXNzYWdlIHNvIGZhcgpiZWNhdXNlIGl0IHNlZW1zIHRoYXQgdGhlcmUg
YXJlIG9wZW4gaXNzdWVzIGZvciBmdXJ0aGVyIGNsYXJpZmljYXRpb24uCgpEbyB5b3Ugd2FudCB0
aGF0IEkgc2VuZCBhIHNlY29uZCBhcHByb2FjaCBmb3IgdGhpcyBzb2Z0d2FyZSBtb2R1bGUKYmVm
b3JlIHlvdXIgb3duIGV2b2x2aW5nIHVwZGF0ZSBzdWdnZXN0aW9uPwoKCj4gYW5kIGNvbmNlbnRy
YXRlIHNvbGVseSBvbiBpbXByb3ZpbmcgQ29jY2luZWxsZSBzY3JpcHRzLgoKSSBob3BlIG5vdC4K
Cgo+IE9uIGtlcm5lbCByZWxhdGVkIGxpc3RzIHN1Z2dlc3Rpb25zIHRvIHBhdGNoIGl0c2VsZiBh
cmUgZGlzY3Vzc2VkLgoKVGhpcyBpcyB1c3VhbC4KCgo+IFdoZW5ldmVyIHlvdSB0YWtlIHRoZW0g
aW50byBhY2NvdW50IHdoaWxlIGRldmVsb3BpbmcgQ29jY2luZWxsZQo+IGlzIHVwIHRvIHlvdSAo
b24gdGhlIENvY2NpIGxpc3QpLgoKVGhpcyBpcyBhbHNvIGhhcHBlbmluZywgaXNuJ3QgaXQ/CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
