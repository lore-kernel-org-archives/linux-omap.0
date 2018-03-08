From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Date: Thu, 8 Mar 2018 15:33:58 +0200
Message-ID: <36c7b85a-dadb-6e05-6c19-58c6ff6ae728@gmail.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd> <20180308132139.apabmgw4magrp3d7@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180308132139.apabmgw4magrp3d7@pali>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: abcloriens@gmail.com, aaro.koskinen@iki.fi, tony@atomide.com, Catalin Marinas <catalin.marinas@arm.com>, khilman@kernel.org, Will Deacon <will.deacon@arm.com>, sre@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, clayton@craftyguy.net, sakari.ailus@linux.intel.com, Marc Zyngier <marc.zyngier@arm.com>, Alex Shi <alex.shi@linaro.org>, linux-omap@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel@lists.infradead.org, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

SGksCgpPbiAgOC4wMy4yMDE4IDE1OjIxLCBQYWxpIFJvaMOhciB3cm90ZToKPiBPbiBUaHVyc2Rh
eSAwOCBNYXJjaCAyMDE4IDEzOjI3OjE1IFBhdmVsIE1hY2hlayB3cm90ZToKPj4gSGkhCj4+Cj4+
PiBSZXNlbnQgd2l0aG91dCBub24tdXBzdHJlYW0gcGF0Y2hlcy4KPj4+Cj4+PiBUaGlzIGJhY2tw
b3J0IHBhdGNoc2V0IGZpeGVkIHRoZSBzcGVjdHJlIGlzc3VlLCBpdCdzIG9yaWdpbmFsIGJyYW5j
aDoKPj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Fy
bTY0L2xpbnV4LmdpdC9sb2cvP2g9a3B0aQo+Pj4gQSBmZXcgZGVwZW5kZW5jeSBvciBmaXhpbmdw
YXRjaGVzIGFyZSBhbHNvIHBpY2tlZCB1cCwgaWYgdGhleSBhcmUgbmVjZXNzYXJ5Cj4+PiAgIGFu
ZCBubyBmdW5jdGlvbmFsIGNoYW5nZXMuCj4+Pgo+Pj4gTm8gYnVnIGZvdW5kIGZyb20ga2VybmVs
Y2kub3JnIGFuZCBsa2Z0IHRlc3RpbmcuIEl0IGFsc28gY291bGQgYmUgZ290dGVuIGZyb206Cj4+
Pgo+Pj4gZ2l0Oi8vZ2l0LmxpbmFyby5vcmcva2VybmVsL2xpbnV4LWxpbmFyby1zdGFibGUuZ2l0
IHY0Ljktc3BlY3RyZS11cHN0cmVhbS1vbmx5Cj4+Pgo+Pj4gQ29tbWVudHMgYXJlIGFwcHJlY2lh
dGVkIQo+Pgo+PiBOb3QgZW50aXJlbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoZWQsIGJ1dC4uLiBJ
IGhhdmUgZmV3IG9sZGVyIEFSTQo+PiBib2FyZHMgaGVyZSwgYW5kIE5va2lhIE45MDAwIEkgcmVh
bGx5IGNhcmUgYWJvdXQuCj4+Cj4+IEFGQUlDVCBNZWx0ZG93biBpcyBhcm02NCBvbmx5Pwo+IAo+
IElJUkMgQVJNdjcgaXMgbm90IGFmZmVjdGVkIGJ5IG1lbHRkb3duLgo+IAo+PiBTcGVjdHJlIGFm
ZmVjdHMgdGhlIG9sZGVyIGJvYXJkcywgdG9vLCByaWdodD8gV2FzIHRoZXJlIGFueSB3b3JrIGRv
bmUKPj4gb24gdGhhdD8gY3B1aW5mbyBzYXlzICJBUk12NyIgZm9yIE45MDAuCj4gCj4gSSByZW1l
bWJlciB0aGF0IEkgc2F3IHNvbWUgc3BlY3RyZSBwYXRjaGVzIGZvciBBUk12NyBvbiBMS01MLgo+
IAo+IEluIGdlbmVyYWwgZm9yIEFSTXY3IGl0IGlzIHByb2JsZW1hdGljIGFzIG1pdGlnYXRpb24g
bmVlZHMgdG8gY2hhbmdlIElCRQo+IGJpdCB3aGljaCBpcyBub3QgcG9zc2libGUgb24gT01BUCBI
UyBkZXZpY2VzLiBCdXQgZm9yIE5va2lhIE45MDAgdGhlcmUKPiBpcyBzcGVjaWFsIGNvZGUgd2hp
Y2ggZG8gaXQgdmlhIHNtYyBpbnN0cnVjdGlvbiAoZnVuY3Rpb24KPiByeDUxX3NlY3VyZV91cGRh
dGVfYXV4X2NyKCksIHNlZSBhbHNvIG5va2lhX245MDBfbGVnYWN5X2luaXQoKSkuCj4gCgpJICp0
aGluayogTjkwMCBzaG91bGQgYmUgc2FmZSBmcm9tIHNwZWN0cmUgYXR0YWNrIGFzIGEgc2lkZSBl
ZmZlY3Qgb2YgCnRodW1iMiBlcnJhdGEgKDQzMDk3Mykgd29ya2Fyb3VuZCAoQlRCIGlzIGZsdXNo
ZWQgb24gZXZlcnkgY29udGV4dCAKc3dpdGNoKSwgYnV0IGRvbid0IHF1b3RlIG1lIG9uIHRoYXQg
b25lLCBsZXRzIG1vcmUga25vd2xlZGdlYWJsZSB0aGFuIG1lIAp0byBjb25maXJtIGZpcnN0LgoK
SXZvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
