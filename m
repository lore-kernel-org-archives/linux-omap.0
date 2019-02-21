From: Christophe Aeschlimann <c.aeschlimann@acn-group.ch>
Subject: Re: da850 dt cpufreq support
Date: Thu, 21 Feb 2019 08:50:57 +0100
Message-ID: <18bf329c-b5e3-2d9f-8a7a-065720d187eb@acn-group.ch>
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
 <20190220154658.GP15711@atomide.com>
 <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

TGUgMjAuMDIuMjAxOSDDoCAxNjo1OCwgQWRhbSBGb3JkIGEgw6ljcml0wqA6Cj4gT24gV2VkLCBG
ZWIgMjAsIDIwMTkgYXQgOTo0NyBBTSBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPiB3
cm90ZToKPj4KPj4gSGksCj4+Cj4+IEFkZGluZyBCYXJ0b3N6LCBEYXZpZCBhbmQgU2VraGFyIHRv
IENjLgo+Pgo+PiAqIENocmlzdG9waGUgQWVzY2hsaW1hbm4gPGMuYWVzY2hsaW1hbm5AYWNuLWdy
b3VwLmNoPiBbMTkwMjIwIDE1OjM0XToKPj4+IEhpLAo+Pj4KPj4+IEkgdW5kZXJzdGFuZCB0aGF0
IHRvZGF5IHRoZSBkYTg1MC1ldm0gaXMgc3VwcG9ydGVkIGluIHR3byB3YXlzIGluIHRoZQo+Pj4g
S2VybmVsLCB1c2luZyBib2FyZCBmaWxlLCBha2EgImxlZ2FjeSIgYW5kIGRldmljZS10cmVlLgo+
Pj4KPj4+IEFtIEkgcmlnaHQgdG8gc2F5IHRoYXQgd2hlbiB1c2luZyB0aGUgZGV2aWNlLXRyZWUg
dGhlcmUgaXMgbm8gc3VwcG9ydCBmb3IKPj4+IGNwdWZyZXEgYXZhaWxhYmxlID8KPj4+Cj4+PiBU
aGUgInRpLWNwdWZyZXEiIGRyaXZlciBkb2Vzbid0IHRhcmdldCB0aGUgZGE4NTAgU29DIGFuZCB0
aGUKPj4+ICJkYXZpbmNpLWNwdWZyZXEiIGRyaXZlciBkb2Vzbid0IG1ha2UgdXNlIG9mIHRoZSBk
ZXZpY2UtdHJlZSBiaW5kaW5ncy4KPj4+Cj4+PiBDb3VsZCB0aGUgZ2VuZXJpYyAiY3B1ZnJlcS1k
dCIgZHJpdmVyIGJlIHVzZWQgPwo+IAo+IEEgd2hpbGUgYWdvLCBEYXZpZCBMIHBvc3RlZCBhIG1l
c3NhZ2Ugb24gdGhlIG1haWxpbmcgbGlzdCBwb2ludGluZyB0bwo+IGEgZ2l0IHJlcG8gdGhhdCBo
YXQgc29tZSBwYXRjaGVzIHRoYXQgd2VyZW4ndCBtYWlubGluZWQuCj4gCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2RsZWNoL2xpbnV4L3RyZWUvZGE4NTAtZHQtY3B1ZnJlcQo+IAo+IEkgd2FzIGdvaW5n
IHRvIHRyeSBhbmQgdGVzdCB0aGVtLCBidXQgSSBuZXZlciBnb3QgYXJvdW5kIHRvIGl0IGR1ZSB0
bwo+IG90aGVyIHdvcmsgcHJvamVjdHMuCgpUaGFua3MgZm9yIHRoZSBwb2ludGVyLgoKQ2hyaXN0
b3BoZQoKPiAKPiBhZGFtCj4+Pgo+Pj4gQmVzdCByZWdhcmRzLAo+Pj4KPj4+IENocmlzdG9waGUK
Pj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPiAKCgotLSAKQ2hyaXN0b3BoZSBBZXNjaGxpbWFubgoK
RW1iZWRkZWQgU29mdHdhcmUgRW5naW5lZXIgJiBJVCBNYW5hZ2VyCkFDTiBBZHZhbmNlZCBDb21t
dW5pY2F0aW9ucyBOZXR3b3JrcyBTLkEuCjIwMDAgLSBOZXVjaMOidGVsLCBTd2l0emVybGFuZApU
ZWwuICs0MSAzMiA3MjQgNzQgMzEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
