From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 08:28:46 -0800
Message-ID: <20190109162846.GP5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>, Vincent Guittot <vincent.guittot@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

KiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IFsxOTAxMDkgMDk6NDRdOgo+
IE9uIFdlZCwgSmFuIDksIDIwMTkgYXQgMjo1MSBBTSBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPiB3cm90ZToKPiA+Cj4gPiAqIFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90
QGxpbmFyby5vcmc+IFsxOTAxMDkgMDE6NDJdOgo+ID4gPiBMZSBUdWVzZGF5IDA4IEphbiAyMDE5
IMOgIDEzOjM3OjQzICgtMDgwMCksIFRvbnkgTGluZGdyZW4gYSDDqWNyaXQgOgo+ID4gPiA+IExv
d2VyaW5nIHRoZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3
b3JrIGFnYWluLgo+ID4gPiA+IEFueXRoaW5nIGhpZ2hlciB0aGFuIDIyMDAgbXMgc2VlbXMgdG8g
c29tZWhvdyB0aW1lIG91dCBpbW1lZGlhdGVseQo+ID4gPiA+IG5vdyA6KQo+ID4gPgo+ID4gPiBU
aGlzIGlzIHF1aXRlIGNsb3NlIHRvIHRoZSBtYXggbnMgb2YgYW4gaW50IG9uIGFybSAzMmJpdHMK
PiA+ID4KPiA+ID4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+ID4KPiA+IFl1cCBn
cmVhdCB0aGFua3MsIHRoYXQncyBpdDoKPiA+Cj4gPiBUZXN0ZWQtYnk6IFRvbnkgTGluZGdyZW4g
PHRvbnlAYXRvbWlkZS5jb20+Cj4gCj4gQ29vbC4gIFRoYW5rcyBmb3IgZ2V0dGluZyB0byB0aGUg
Ym90dG9tIG9mIHRoaXMhCgpObyBwcm9ibGVtLgoKT25lIG1vcmUgdGhpbmcgSSBub3RpY2VkOiBU
aGUgMjUlIHNsYWNrIGNhbiBnZXQgbm90aWNlYWJsZQpmb3IgbGFyZ2VyIHZhbHVlcy4gRm9yIHRo
aW5ncyBsaWtlIGEgMyBzZWNvbmQgdWFydCBjb25zb2xlCnRpbWVvdXQgc2xhY2sgb2YgNzUwIG1z
IGlzIHF1aXRlIGxhcmdlIHZhcmlhdGlvbi4KClNob3VsZCB3ZSBoYXZlIGEgbGltaXQgb2YgbWF4
IDEwMCBtcyBmb3IgdGhlIHNsYWNrPwoKUmVnYXJkcywKClRvbnkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
