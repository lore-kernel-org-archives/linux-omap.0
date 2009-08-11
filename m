From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v3 1:2] [MTD][NAND]omap: Adding support for nand
	prefetch-read and post-write, in MPU mode.
Date: Tue, 11 Aug 2009 11:59:15 +0530
Message-ID: <ce9ab5790908102329k73f66b5bgcdd8ac52d6631116@mail.gmail.com>
References: <61339.192.168.10.89.1247226725.squirrel@dbdmail.itg.ti.com>
	<48097.192.168.10.89.1247232736.squirrel@dbdmail.itg.ti.com>
	<60361.192.168.10.89.1247482584.squirrel@dbdmail.itg.ti.com>
	<20090810162734.GH1938@atomide.com>
	<ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com>
	<4A810DE4.7030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <4A810DE4.7030202@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: vimal singh <vimalsingh@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, david-b@pacbell.net, dedekind@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBBdWcgMTEsIDIwMDkgYXQgMTE6NTEgQU0sIEFydGVtIEJpdHl1dHNraXk8ZGVkZWtp
bmQxQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gMDgvMTEvMjAwOSAwODo0NSBBTSwgdmltYWwgc2lu
Z2ggd3JvdGU6Cj4+Cj4+IE9uIE1vbiwgQXVnIDEwLCAyMDA5IGF0IDk6NTcgUE0sIFRvbnkgTGlu
ZGdyZW48dG9ueUBhdG9taWRlLmNvbT4gwqB3cm90ZToKPj4+Cj4+PiAqIHZpbWFsIHNpbmdoPHZp
bWFsc2luZ2hAdGkuY29tPiDCoFswOTA3MTMgMTM6NTZdOgo+Pj4+Cj4+Pj4gUGF0Y2ggdXBkYXRl
ZCBmb3IgJyBpb3JlYWRYIC8gaW93cml0ZVggYW5kIGlvcmVhZFhfcmVwIC8gaW93cml0ZVhfcmVw
Jwo+Pj4+IGFzIHBlcgo+Pj4+IERhdmlkIEJyb3duZWxsJ3MgY29tbWVudC4gSSB1cGRhdGVkICdv
bWFwXyhyZWFkL3dyaXRlKV9idWYxNicgZnVjbnRpb25zCj4+Pj4gYWxzbwo+Pj4+IGZvciB0aGlz
Lgo+Pj4+Cj4+Pj4gLXZpbWFsCj4+Pj4KPj4+PiBUaGlzIHBhdGNoIGFkZHMgcHJlZmV0Y2ggc3Vw
cG9ydCB0byBhY2Nlc3MgbmFuZCBmbGFzaCBpbiBtcHUgbW9kZS4KPj4+PiBUaGlzIHBhdGNoIGFs
c28gYWRkcyA4LWJpdCBuYW5kIHN1cHBvcnQgKG9tYXBfcmVhZC93cml0ZV9idWY4KS4KPj4+PiBQ
cmVmZXRjaCBjYW4gYmUgdXNlZCBmb3IgYm90aCA4LSBhbmQgMTYtYml0IGRldmljZXMuCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWaW1hbCBTaW5naDx2aW1hbHNpbmdoQHRpLmNvbT4KPj4+Cj4+
PiBTb3JyeSBmb3IgdGhlIGRlbGF5LiBJJ3ZlIGxvb2tlZCBhdCB0aGUgR1BNQyBwYXJ0LCBhbmQg
dGhhdCBub3cgbG9va3MgT0sKPj4+IHRvIG1lLiBTbyBJJ20gT0sgZm9yIHRoaXMgdG8gZ2V0IGlu
dGVncmF0ZWQgdmlhIHRoZSBNVEQgbGlzdC4KPj4+Cj4+PiBBY2tlZC1ieTogVG9ueSBMaW5kZ3Jl
bjx0b255QGF0b21pZGUuY29tPgo+Pj4KPj4KPj4gQ2FuIHlvdSBnaXZlIHlvdXIgYWNrIHRvIGJl
bG93IHBhdGNoIHRvbz8KPj4KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWls
L2xpbnV4LW10ZC8yMDA5LUp1bHkvMDI2MzczLmh0bWwKPgo+IEkndmUgcGlja2VkIHVwIGJvdGgg
b2YgeW91ciBwYXRjaGVzLCBwbGVhc2UsIGNoZWNrOgo+IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9y
Zy91c2Vycy9kZWRla2luZC9sMi1tdGQtMi42LmdpdC9jb21taXQvMzNmNDhmNTk3MzE1ODQyZjM5
NDI3ZWU0MjYxY2JmODJhOWFmZWFmMwo+IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9k
ZWRla2luZC9sMi1tdGQtMi42LmdpdC9jb21taXQvYjY3ZDUyYzkxYjI2ZTk3Zjk4MWYyYzI5MjYx
OWQzMTY2N2Q1YjI3Mgo+CgpUaGFua3MgQXJ0ZW0uCgo+IC0tCj4gQmVzdCBSZWdhcmRzLAo+IEFy
dGVtIEJpdHl1dHNraXkgKNCQ0YDRgtGR0Lwg0JHQuNGC0Y7RhtC60LjQuSkKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBk
aXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW10ZC8K
