From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Tue, 21 Jun 2016 04:32:16 -0700
Message-ID: <20160621113215.GP22406@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
 <20160615105552.GN29844@pali> <20160615110201.GY22406@atomide.com>
 <20160615114936.GO29844@pali> <20160615120556.GZ22406@atomide.com>
 <20160621112535.GN22406@atomide.com> <20160621112944.GV29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160621112944.GV29844@pali>
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
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+IFsxNjA2MjEgMDQ6MzJdOgo+IE9u
IFR1ZXNkYXkgMjEgSnVuZSAyMDE2IDA0OjI1OjM2IFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gPiAq
IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IFsxNjA2MTUgMDU6MDhdOgo+ID4gPiAq
IFBhbGkgUm9ow6FyIDxwYWxpLnJvaGFyQGdtYWlsLmNvbT4gWzE2MDYxNSAwNDo1Ml06Cj4gPiA+
ID4gT24gV2VkbmVzZGF5IDE1IEp1bmUgMjAxNiAwNDowMjowMiBUb255IExpbmRncmVuIHdyb3Rl
Ogo+ID4gPiA+ID4gSGksCj4gPiA+ID4gPiAKPiA+ID4gPiA+ICogUGFsaSBSb2jDoXIgPHBhbGku
cm9oYXJAZ21haWwuY29tPiBbMTYwNjE1IDAzOjU4XToKPiA+ID4gPiA+ID4gSGkhIEkganVzdCBx
dWlja2x5IGxvb2tlZCBhdCBOOTAwIHN0YXR1cyBtYXRyaXggaHR0cHM6Ly9lbGludXgub3JnL045
MDAKPiA+ID4gPiA+ID4gYW5kIHRoZXJlIGlzIHN0aWxsIG9uZSB0aGluZyBub3QgZmluaXNoZWQg
aW4gRFQ6IEl0IGlzIHNsb3QtbmFtZSBmb3IKPiA+ID4gPiA+ID4gb21hcF9oc21tYyBkcml2ZXIu
IFNvIHN3aXRjaCBmcm9tIGxlZ2FjeSBib2FyZCBjb2RlIHRvIERUIGlzIHJlZ3Jlc3Npb24uCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IFRoYXQncyBmaXhlZCB3aXRoIHRoZSBmb2xsb3dpbmcgaW4gdjQu
Ny1yYyBzZXJpZXM6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGRiODYzZDg5NjY4MSAoIm1tYzogb21h
cF9oc21tYzogQ2hlY2sgaWYgTU1DIHNsb3QgbmFtZSBpcyBwYXNzZWQgaW4gcGRhdGEiKQo+ID4g
PiA+ID4gMTBjMWY3ZDMyYmY0ICgiQVJNOiBPTUFQMis6IG45MDAgbmVlZHMgTU1DIHNsb3QgbmFt
ZXMgZm9yIGxlZ2FjeSB1c2VyIHNwYWNlIikKPiA+ID4gPiAKPiA+ID4gPiBHcmVhdCEgU29ycnks
IGJ1dCBub3cgd2lraSBpcyBub3QgZnVsbHkgdXBkYXRlZCB3aXRoIGxhc3QgY2hhbmdlcyBhbmQg
SQo+ID4gPiA+IGRvIG5vdCBoYXZlIGluIG15IG1pbmQgd2hhdCB3YXMgZmluaXNoZWQvbWVyZ2Vk
IGFuZCB3aGF0IG5vdC4gSXQgaXMKPiA+ID4gPiBnb2luZyBoYXJkIGZvciBtZSB0byB0cmFjayBl
dmVyeXRoaW5nLgo+ID4gPiAKPiA+ID4gT0sgd2VsbCBtYXliZSB0YWtlIG9uZSBtb3JlIGxvb2sg
YW5kIHRoZW4gYWNrIGlmIG5vIG1vcmUgaXNzdWVzLgo+ID4gCj4gPiBQYWxpLCBhbnkgbmV3cyBv
biB0aGlzPwo+IAo+IEkgaGF2ZSBub3QgbG9va2VkIGF0IHRoaXMgZGVlcGx5IHlldC4gUGxlYXNl
IGdpdmUgbWUgc29tZSBtb3JlIHRpbWUuCgpPSyBJJ2QgbGlrZSB0byBhcHBseSB0aGlzIHNlcmll
cyBieSBNb25kYXkgaWYgbm8gaXNzdWVzIHRvIGhhdmUKZW5vdWdoIHRpbWUgZm9yIGl0IGluIExp
bnV4IG5leHQuIERvZXMgdGhhdCBzb3VuZCBPSyB0byB5b3U/CgpSZWdhcmRzLAoKVG9ueQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
