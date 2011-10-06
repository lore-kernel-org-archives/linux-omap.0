From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] omap: dmtimer: convert printk to pr_*
Date: Thu, 06 Oct 2011 08:19:39 -0700
Message-ID: <1317914379.10495.5.camel@Joe-Laptop>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?ISO-8859-1?Q?V=EDctor?= Manuel =?ISO-8859-1?Q?J=E1quez?= Leal <vjaquez@igalia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCAyMDExLTEwLTA2IGF0IDEyOjQ4ICswMjAwLCBWw61jdG9yIE1hbnVlbCBKw6FxdWV6
IExlYWwgd3JvdGU6Cj4gQ29udmVydCBhbGwgdGhlIHByaW50ayg8bGV2ZWw+KSBtZXNzYWdlcyBp
biB0aGUgZHJpdmVyIHRvIHByXzxsZXZlbD4oKS4KW10KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
cGxhdC1vbWFwL2RtdGltZXIuYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9kbXRpbWVyLmMKW10KPiBA
QCAtMzk3LDggKzM5Nyw3IEBAIHN0cnVjdCBvbWFwX2RtX3RpbWVyICpvbWFwX2RtX3RpbWVyX3Jl
cXVlc3Rfc3BlY2lmaWMoaW50IGlkKQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmRtX3RpbWVyX2xv
Y2ssIGZsYWdzKTsKPiAgCWlmIChpZCA8PSAwIHx8IGlkID4gZG1fdGltZXJfY291bnQgfHwgZG1f
dGltZXJzW2lkLTFdLnJlc2VydmVkKSB7Cj4gIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZG1f
dGltZXJfbG9jaywgZmxhZ3MpOwo+IC0JCXByaW50aygiQlVHOiB3YXJuaW5nIGF0ICVzOiVkLyVz
KCk6IHVuYWJsZSB0byBnZXQgdGltZXIgJWRcbiIsCj4gLQkJICAgICAgIF9fRklMRV9fLCBfX0xJ
TkVfXywgX19mdW5jX18sIGlkKTsKPiArCQlwcl93YXJuaW5nKCJ1bmFibGUgdG8gZ2V0IHRpbWVy
ICVkXG4iLCBpZCk7CgpGb3IgbmV3IGNvbnZlcnNpb25zLCBwbGVhc2UgdXNlIHByX3dhcm4gbm90
IHByX3dhcm5pbmcuCkl0J3Mgc2hvcnRlciBhbmQgc2ltaWxhciB0byBvdGhlciBkZXZfd2Fybi9u
ZXRkZXZfd2Fybgp1c2VzLgoKPiAgCQlkdW1wX3N0YWNrKCk7CgpUbyBlbWl0IGEgbWVzc2FnZSB0
aGVuIGR1bXAgc3RhY2ssIHBsZWFzZSB1c2UKCVdBUk4oMSwgZm10LCAuLi4pCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
