From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 13:02:29 -0700
Message-ID: <AANLkTilpYbuZ7PWe3TcNGeZrIGkBiXrEocCfOfXerxpF@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<1274125840.25625.21.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274125840.25625.21.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, J acob Pan <jacob.jun.pan@linux.intel.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBNYXkgMTcsIDIwMTAgYXQgMTI6NTAgUE0sIERhbmllbCBXYWxrZXIgPGR3YWxrZXJA
Y29kZWF1cm9yYS5vcmc+IHdyb3RlOgo+IE9uIE1vbiwgMjAxMC0wNS0xNyBhdCAyMDozNCArMDEw
MCwgTWF0dGhldyBHYXJyZXR0IHdyb3RlOgo+Cj4+IGludCBtYWluKCkgewo+PiDCoCDCoCDCoCBp
bnQgaTsKPj4gwqAgwqAgwqAgd2hpbGUgKDEpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGkrKzsK
Pj4gwqAgwqAgwqAgcmV0dXJuIDA7Cj4+IH0KPj4KPgo+IFdlIGFscmVhZHkga25vdyBpdCdzIHJl
YWxseSByYXJlIG9uIGFuIGVtYmVkZGVkIHN5c3RlbSB5b3Ugd291bGQgZ2V0Cj4gdGhpcyBiYWQg
b2YgYW4gYXBwLiBIb3dldmVyLCBpZiB5b3UgYXNzdW1lIHRoYXQgeW91IG1pZ2h0IGhhdmUgdGhp
cyAxIGluCj4gYSBtaWxsaW9uIGFwcCwgY291bGRuJ3Qgd2UganVzdCBoYXZlIGEgd2F0Y2ggZG9n
IHRoYXQgaWRlbnRpZmllcyBhbmQKPiBraWxscyBpdC4gSXQgd291bGQgYWxzbyBsZXQgdGhlIHVz
ZXIga25vdyB3aGF0IGhhcHBlbmVkIG9mIGNvdXJzZS4KPiBLaWxsaW5nIHRoZSBhcHAgc2VlbXMg
cHJldHR5IHJlYXNvbmFibGUgdG8gbWUuCgpIb3dldmVyLCBpdCBpcyBub3QgdW5jb21tb24gdG8g
cnVuIGludG8gYXBwcyB0aGF0IHBvbGwgb25jZSAob3IKc2V2ZXJhbCB0aW1lcykgYSBzZWNvbmQg
Zm9yIElPLCBvciBoYXZlIG90aGVyIGJlaGF2aW9yIHRoYXQncyBub3QKKnF1aXRlKiBhcyBiYWQg
YXMgY29uc3RhbnRseSBydW5uaW5nIGJ1dCBzdGlsbCBlbmRzIHVwIGhhdmluZyBhCnNpZ25pZmlj
YW50IGltcGFjdCBvbiBiYXR0ZXJ5IGxpZmUuICBQb2xsaW5nIGV2ZW4gb24gInJlYXNvbmFibGUi
CmludGVydmFscyBjYW4gbWFrZSBhIGh1Z2UgZGlmZmVyZW5jZSBpbiBvdmVyYWxsIGJhdHRlcnkg
bGlmZSB3aGlsZSBub3QKaGF2aW5nIGEgdmVyeSB2aXNpYmxlIGltcGFjdCBvbiBkZXZpY2UgcGVy
Zm9ybWFuY2Ugd2hlbiB0aGUgZGV2aWNlIGlzCmJlaW5nIHVzZWQgaW50ZXJhY3RpdmVseS4gIG9w
cG9ydHVuaXN0aWMgc3VzcGVuZCBoZWxwcyBhIGxvdCBoZXJlLgoKV2Ugc2VlIHRoaXMgaW4gdGhl
IGZpZWxkIHdpdGggcmVhbCBhcHBzIG9uIHJlYWwgZGV2aWNlcyAtLSB0aGVyZSdzIGEKbG90IG9m
IG5vdCBzbyBncmVhdCBjb2RlIG91dCB0aGVyZS4KClNvbWV0aW1lcyB0aG9zZSBhcHBzIGFyZSBh
cHBzIHRoYXQsIGRlc3BpdGUgYmVpbmcgYmFkbHkgd3JpdHRlbiwgZG8KdGhpbmdzIHVzZXJzIHdh
bnQuICBUaHVzIGJvdGggcmVkdWNpbmcgdGhlIGltcGFjdCBvZiB0aGVzZSBiYWQgYXBwcwphbmQg
ZWR1Y2F0aW5nIHVzZXJzIGFuZCBkZXZlbG9wZXJzIGFib3V0IHRoZSBhcHBzIGJlaW5nIGJhZCBm
b3IgdGhlaXIKYmF0dGVyeSBsaWZlIGlzIHdvcnRod2hpbGUuCgpCcmlhbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QK
bGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
