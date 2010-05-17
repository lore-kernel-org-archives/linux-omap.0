From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 14:36:26 -0700
Message-ID: <AANLkTinShi40jCbEWAB6itcPMoeNMUqZCgpqw8tVpvxg@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<87ljbi1anb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ljbi1anb.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBNYXkgMTcsIDIwMTAgYXQgMjoyNyBQTSwgS2V2aW4gSGlsbWFuCjxraGlsbWFuQGRl
ZXByb290c3lzdGVtcy5jb20+IHdyb3RlOgo+Cj4gVGhpcyBraW5kIG9mIHJvZ3VlIGFwcCB3aWxs
IGFsc28ga2lsbCBteSBDUFUgcGVyZm9ybWFuY2UuIMKgRm9yIHJvZ3VlCj4gQ1BVLWhvZyBhcHBz
LCB3ZSB1c2UgX3Rvb2xzXyB0byBmaW5kIGFuZCBmaXggdGhpcyBraW5kIG9mIHByb2JsZW06Cj4g
dG9wLCByZW5pY2UsIGtpbGwsIGV0Yy4gdGhhdCB1c2UgZmVhdHVyZXMgb2YgdGhlIHNjaGVkdWxl
ciB0byBmaW5kCj4gYW5kL29yIHNvbHZlIHRoZSBwcm9ibGVtLgo+Cj4gRm9yIHJvZ3VlIGFwcHMg
dGhhdCBhZmZlY3QgUE0sIHdoYXQgaXMgYmVpbmcgcHJvcG9zZWQgaXMgdG8gYnlwYXNzIHRoZQo+
IHJvb3QgY2F1c2VzICh0aW1lcnMsIHNjaGVkdWxlciwgYWN0aXZpdHksIGV0Yy4pIGFuZCBqdXN0
IGZyZWV6ZSB0aGUKPiBhcHBzLgo+Cj4gUm9ndWUgQ1BVLWhvZyBhcHBzIGFyZSBnZW5lcmFsbHkg
bm90IHRvbGVyYXRlZC4gwqBUaGUgcHJvYmxlbXMgYXJlCj4gZm91bmQgdXNpbmcgdG9vbHMgYW5k
IGZpeGVkIChvciByZW1vdmVkLikgwqBXaHkgc2hvdWxkIHdlIGRvIGFueQo+IGRpZmZlcmVudCBm
b3Igcm9ndWUgcG93ZXItaG9nIGFwcHM/Cj4KPiBNYXliZSB0aGUgdG9vbHMgYXJlbid0IGFzIGdv
b2QgZm9yIGZpbmRpbmcgcG93ZXItc3Vja2luZyBhcHBzLgo+IFRoZW4gd2Ugc2hvdWxkIGJlIGZv
Y3VzaW5nIG9uIHRoZSBfdG9vbHNfIGluc3RlYWQgb2YgbWFza2luZyB0aGUKPiBwcm9ibGVtLgoK
TWFzcyBtYXJrZXQgY29uc3VtZXIgZGV2aWNlcyB0aGF0IGFsbG93IGFyYml0cmFyeSBhcHAgaW5z
dGFsbGF0aW9uIGFyZQphIGZ1biBjaGFsbGVuZ2UgYmVjYXVzZSBtYW55IChtb3N0PykgdXNlcnMg
YXJlIG5vdCBhd2FyZSBvZiB0aGUgbG93CmxldmVsIGRldGFpbHMgaGVyZSBvciB3aHkgb25lIGFw
cCBpcyBiYWQgYW5kIGFub3RoZXIgaXMgZ29vZC4gIFRoZXkKb2Z0ZW4gZG9uJ3QgZXZlbiBrbm93
IHdoaWNoIGFwcCBvZiBOIHRoZXkgaW5zdGFsbGVkIGlzIGNhdXNpbmcgdGhlaXIKcHJvYmxlbXMu
ICBXZSdyZSBwcm92aWRpbmcgdGhpcyBpbmZvcm1hdGlvbiBhcyB3ZSBjYW4gdG8gaGVscCB1c2Vy
cwp1bmRlcnN0YW5kIHdoaWNoIGFwcHMgYXJlIHVzaW5nIGNwdSBvciBwcmV2ZW50aW5nIHN1c3Bl
bmQsIHZpYSB0aGUKYmF0dGVyeSB1c2FnZSBVSS4gIFdlIHRyeSB0byBwcm92aWRlIGV2ZW4gbW9y
ZSBkZXRhaWxlZCBpbmZvcm1hdGlvbiB0bwpkZXZlbG9wZXJzIHNvIHRoZXkgY2FuIHRlc3QgYW5k
IGFkanVzdCBmb3IgcG9vciBjcHUvcG93ZXIgdXNhZ2UuCgpXZSBhcmUgYWxzbyBkb2luZyBvdXIg
YmVzdCB0byBiZWhhdmUgd2VsbCBldmVuIGluIHRoZSBmYWNlIG9mIHBvb3JseQp3cml0dGVuIGFw
cHMuCgpJIHRoaW5rIHlvdSBuZWVkIHRvIGRvIGJvdGggLS0gcHJvdmlkZSB0b29scyBhbmQgZWR1
Y2F0aW9uLCBidXQgYWxzbwptYWtlIHRoZSBiZXN0IG9mIHRoaW5ncy4gIElmIEkgY2FuIG1ha2Ug
YSBkZXZpY2Ugd2l0aCBhIHBvb3JseSB3cml0dGVuCmFwcCBtYWtlIGl0IG92ZXIgYSBkYXkgb2Yg
c3RhbmRieSBpbnN0ZWFkIG9mIDQtOCBob3VycyBvZiBzdGFuZGJ5LAp0aGF0IGhhcyBpbW1lZGlh
dGUgYmVuZWZpdCB0byB0aGUgdXNlciwgZm9yIGV4YW1wbGUuCgpCcmlhbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QK
bGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
