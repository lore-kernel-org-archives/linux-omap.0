From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH-v3 1:2] [MTD][NAND]omap: Adding support for nand
	prefetch-read and post-write, in MPU mode.
Date: Tue, 11 Aug 2009 09:21:24 +0300
Message-ID: <4A810DE4.7030202@gmail.com>
References: <61339.192.168.10.89.1247226725.squirrel@dbdmail.itg.ti.com>
	<48097.192.168.10.89.1247232736.squirrel@dbdmail.itg.ti.com>
	<60361.192.168.10.89.1247482584.squirrel@dbdmail.itg.ti.com>
	<20090810162734.GH1938@atomide.com>
	<ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: vimal singh <vimalsingh@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, david-b@pacbell.net, dedekind@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDgvMTEvMjAwOSAwODo0NSBBTSwgdmltYWwgc2luZ2ggd3JvdGU6Cj4gT24gTW9uLCBBdWcg
MTAsIDIwMDkgYXQgOTo1NyBQTSwgVG9ueSBMaW5kZ3Jlbjx0b255QGF0b21pZGUuY29tPiAgd3Jv
dGU6Cj4+ICogdmltYWwgc2luZ2g8dmltYWxzaW5naEB0aS5jb20+ICBbMDkwNzEzIDEzOjU2XToK
Pj4+IFBhdGNoIHVwZGF0ZWQgZm9yICcgaW9yZWFkWCAvIGlvd3JpdGVYIGFuZCBpb3JlYWRYX3Jl
cCAvIGlvd3JpdGVYX3JlcCcgYXMgcGVyCj4+PiBEYXZpZCBCcm93bmVsbCdzIGNvbW1lbnQuIEkg
dXBkYXRlZCAnb21hcF8ocmVhZC93cml0ZSlfYnVmMTYnIGZ1Y250aW9ucyBhbHNvCj4+PiBmb3Ig
dGhpcy4KPj4+Cj4+PiAtdmltYWwKPj4+Cj4+PiBUaGlzIHBhdGNoIGFkZHMgcHJlZmV0Y2ggc3Vw
cG9ydCB0byBhY2Nlc3MgbmFuZCBmbGFzaCBpbiBtcHUgbW9kZS4KPj4+IFRoaXMgcGF0Y2ggYWxz
byBhZGRzIDgtYml0IG5hbmQgc3VwcG9ydCAob21hcF9yZWFkL3dyaXRlX2J1ZjgpLgo+Pj4gUHJl
ZmV0Y2ggY2FuIGJlIHVzZWQgZm9yIGJvdGggOC0gYW5kIDE2LWJpdCBkZXZpY2VzLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IFZpbWFsIFNpbmdoPHZpbWFsc2luZ2hAdGkuY29tPgo+PiBTb3JyeSBm
b3IgdGhlIGRlbGF5LiBJJ3ZlIGxvb2tlZCBhdCB0aGUgR1BNQyBwYXJ0LCBhbmQgdGhhdCBub3cg
bG9va3MgT0sKPj4gdG8gbWUuIFNvIEknbSBPSyBmb3IgdGhpcyB0byBnZXQgaW50ZWdyYXRlZCB2
aWEgdGhlIE1URCBsaXN0Lgo+Pgo+PiBBY2tlZC1ieTogVG9ueSBMaW5kZ3Jlbjx0b255QGF0b21p
ZGUuY29tPgo+Pgo+Cj4gQ2FuIHlvdSBnaXZlIHlvdXIgYWNrIHRvIGJlbG93IHBhdGNoIHRvbz8K
Pgo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tdGQvMjAwOS1K
dWx5LzAyNjM3My5odG1sCgpJJ3ZlIHBpY2tlZCB1cCBib3RoIG9mIHlvdXIgcGF0Y2hlcywgcGxl
YXNlLCBjaGVjazoKaHR0cDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2RlZGVraW5kL2wyLW10
ZC0yLjYuZ2l0L2NvbW1pdC8zM2Y0OGY1OTczMTU4NDJmMzk0MjdlZTQyNjFjYmY4MmE5YWZlYWYz
Cmh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9kZWRla2luZC9sMi1tdGQtMi42LmdpdC9j
b21taXQvYjY3ZDUyYzkxYjI2ZTk3Zjk4MWYyYzI5MjYxOWQzMTY2N2Q1YjI3MgoKLS0gCkJlc3Qg
UmVnYXJkcywKQXJ0ZW0gQml0eXV0c2tpeSAo0JDRgNGC0ZHQvCDQkdC40YLRjtGG0LrQuNC5KQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K
