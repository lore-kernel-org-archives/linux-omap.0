From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 10:11:48 +0100
Message-ID: <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511856244.19952.14.camel@perches.com>
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
To: Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-omap@vger.kernel.org

PiBIb3cgbWFueSB0aW1lcyBoYXZlIEkgdG9sZCB5b3UgdG8gaW5jbHVkZSB0aGUgcmVhc29uIGZv
cgo+IHlvdXIgcGF0Y2hlcyBpbiB5b3VyIHByb3Bvc2VkIGNvbW1pdCBtZXNzYWdlPwoKSXQgbWln
aHQgYmUgdXNlZnVsIHRvIGxvb2sgYWdhaW4uCgoKPiBUb28gb2Z0ZW4uCgpJIGFuc3dlcmVkIHRo
aXMgZmVlZGJhY2sgdG8gc29tZSBkZWdyZWUuCgoKPiBNYW55IHBlb3BsZSBkbyBub3Qga25vdyB0
aGF0IGEgZ2VuZXJpYyBrbWFsbG9jIGRvZXMgYQo+IGR1bXBfc3RhY2soKSBvbiBPT00uCgpUaGlz
IGlzIGFub3RoZXIgaW50ZXJlc3RpbmcgaW5mb3JtYXRpb24sIGlzbid0IGl0PwoKSXQgaXMgZXhw
ZWN0ZWQgdGhhdCB0aGUgZnVuY3Rpb24g4oCcZGV2bV9remFsbG9j4oCdIGhhcyBnb3QgYSBzaW1p
bGFyIHByb3BlcnR5LgoKCj4gVGhhdCBpbmZvcm1hdGlvbiBzaG91bGQgYmUgcGFydCBvZiB0aGUg
Y29tbWl0IG1lc3NhZ2UuCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHByb3ZpZGUgaXQgYWxz
byBpbiBhbnkgcmVmZXJlbmNlIGRvY3VtZW50YXRpb24KaW4gYSBjbGVhcmVyIHdheT8KCkkgd291
bGQgYmUgbW9yZSBjb25maWRlbnQgdGhlbiB0byBjb3B5IGl0IGludG8gbXkgbWVzc2FnZXMuCkRv
IHlvdSB3YW50IHRoYXQgSSB0YWtlIHlvdXIgY3VycmVudCBhbnN3ZXIgYXMgYW4gb2ZmaWNpYWwg
bm90ZQpmb3IgbXkgd29yayAoaW5zdGVhZCBvZiB3YWl0aW5nIGZvciBhZGp1c3RtZW50cyBvZiBv
dGhlciBhcmVhcyk/CgoKPiBBbHNvIHJlbW92aW5nIHRoZSBwcmludGsgY29kZSByZWR1Y2VzIG92
ZXJhbGwgY29kZSBzaXplLgoKU3VjaCBhbiBlZmZlY3QgY2FuIGJlIG5pY2UgaWYgdGhlIGludm9s
dmVkIGNvbnRyaWJ1dG9ycyBjYW4gYWdyZWUgb24KdGhlIGRlbGV0aW9uIG9mIHF1ZXN0aW9uYWJs
ZSBlcnJvciBtZXNzYWdlcyBhdCBhbGwuCgoKPiBUaGUgYWN0dWFsIHNpemUgcmVkdWN0aW9uIHNo
b3VsZCBiZSBkZXNjcmliZWQgaW4gdGhlCj4gY29tbWl0IG1lc3NhZ2UgdG9vLgoKRm9yIHdoaWNo
IGhhcmR3YXJlIGFuZCBzb2Z0d2FyZSBjb21iaW5hdGlvbnMgd291bGQgeW91IGxpa2UgdG8gc2Vl
CmZhY3RzIHRoZXJlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
