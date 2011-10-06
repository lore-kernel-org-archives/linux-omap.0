From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: dmtimer: convert printk to pr_err / WARN
Date: Thu, 6 Oct 2011 13:18:27 -0700
Message-ID: <20111006201827.GT6324@atomide.com>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
	<1317922204-12512-1-git-send-email-vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1317922204-12512-1-git-send-email-vjaquez@igalia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?Q?V=C3=ADctor_Manuel_J=C3=A1quez?= Leal <vjaquez@igalia.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-omap@vger.kernel.org

KiBWw61jdG9yIE1hbnVlbCBKw6FxdWV6IExlYWwgPHZqYXF1ZXpAaWdhbGlhLmNvbT4gWzExMTAw
NiAwOTo1Nl06Cj4gQ29udmVydCBhIHByaW50ayhLRVJOX0VSUikgbWVzc2FnZSBpbiB0aGUgZHJp
dmVyIHRvIHByX2VycigpLCBhbmQKPiB1c2UgV0FSTigpIGluc3RlYWQgb2YgYSBjdXN0b20gbG9n
IG1lc3NhZ2Ugd2l0aCBhIHN0YWNrIGR1bXAuCj4gCj4gU2lnbmVkLW9mZi1ieTogVsOtY3RvciBN
YW51ZWwgSsOhcXVleiBMZWFsIDx2amFxdWV6QGlnYWxpYS5jb20+CgpMb29rcyBsaWtlIHRoaXMg
d29uJ3QgYXBwbHkgd2l0aCB0aGUgY2hhbmdlcyB3ZSBoYXZlIHF1ZXVlZCB1cCwKY2FyZSB0byBy
ZWZyZXNoIHRoaXMgYWdhaW5zdCBsaW51eC1vbWFwIG1hc3RlciBicmFuY2ggKG9yIGRtdGltZXIK
YnJhbmNoKT8KClJlZ2FyZHMsCgpUb255Cgo+IC0tLQo+ICBhcmNoL2FybS9wbGF0LW9tYXAvZG10
aW1lci5jIHwgICAgNiArKy0tLS0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9kbXRp
bWVyLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCj4gaW5kZXggZWU5ZjZlYi4uZGVh
ZDBmMyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCj4gKysrIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYwo+IEBAIC0zMjIsNyArMzIyLDcgQEAgc3RhdGlj
IHZvaWQgb21hcF9kbV90aW1lcl93YWl0X2Zvcl9yZXNldChzdHJ1Y3Qgb21hcF9kbV90aW1lciAq
dGltZXIpCj4gIAl3aGlsZSAoIShvbWFwX2RtX3RpbWVyX3JlYWRfcmVnKHRpbWVyLCBPTUFQX1RJ
TUVSX1NZU19TVEFUX1JFRykgJiAxKSkgewo+ICAJCWMrKzsKPiAgCQlpZiAoYyA+IDEwMDAwMCkg
ewo+IC0JCQlwcmludGsoS0VSTl9FUlIgIlRpbWVyIGZhaWxlZCB0byByZXNldFxuIik7Cj4gKwkJ
CXByX2VycigiVGltZXIgZmFpbGVkIHRvIHJlc2V0XG4iKTsKPiAgCQkJcmV0dXJuOwo+ICAJCX0K
PiAgCX0KPiBAQCAtMzk3LDkgKzM5Nyw3IEBAIHN0cnVjdCBvbWFwX2RtX3RpbWVyICpvbWFwX2Rt
X3RpbWVyX3JlcXVlc3Rfc3BlY2lmaWMoaW50IGlkKQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmRt
X3RpbWVyX2xvY2ssIGZsYWdzKTsKPiAgCWlmIChpZCA8PSAwIHx8IGlkID4gZG1fdGltZXJfY291
bnQgfHwgZG1fdGltZXJzW2lkLTFdLnJlc2VydmVkKSB7Cj4gIAkJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZG1fdGltZXJfbG9jaywgZmxhZ3MpOwo+IC0JCXByaW50aygiQlVHOiB3YXJuaW5nIGF0
ICVzOiVkLyVzKCk6IHVuYWJsZSB0byBnZXQgdGltZXIgJWRcbiIsCj4gLQkJICAgICAgIF9fRklM
RV9fLCBfX0xJTkVfXywgX19mdW5jX18sIGlkKTsKPiAtCQlkdW1wX3N0YWNrKCk7Cj4gKwkJV0FS
TigxLCAidW5hYmxlIHRvIGdldCB0aW1lciAlZFxuIiwgaWQpOwo+ICAJCXJldHVybiBOVUxMOwo+
ICAJfQo+ICAKPiAtLSAKPiAxLjcuNi4zCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
