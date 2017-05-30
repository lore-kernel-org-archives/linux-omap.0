From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3b 0/5] ARM: OMAP2+: preparation for clk/clkctrl support
Date: Tue, 30 May 2017 17:47:44 +0300
Message-ID: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

SGksCgpUaGlzIGlzIGFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGFnYWluc3QgdjMgWzFdIG9mIHRo
aXMgc2VyaWVzLgoKWzFdwqBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVs
L21zZzU4MTk2NS5odG1sCgpUaGlzIHNlcmllcyBpcyBkaWZmZXJlbnQgaW4gdGhhdCBpdCBwYXJz
ZXMgdGhlIGh3bW9kIGRhdGEgaW4gdGhlIGZseQphbmQgc3dhcHMgdGhlIG1haW5fY2xrIGluZm8g
d2l0aCBjbGtjdHJsIGltcGxlbWVudGF0aW9ucyBpZiB0aG9zZQphcmUgcHJlc2VudC4gUGF0Y2gg
IzEgLyAjMiBhcmUgb2xkIGZyb20gdjMgb2YgdGhlIHNlcmllcywgcmVzdCBhcmUKbmV3LiBQYXRj
aGVzICMzIC8gIzQgYWRkIHNvbWUgaW5mcmFzdHJ1Y3R1cmUgc3VwcG9ydCBmb3IgcGFyc2luZwp0
aGUgY2xvY2sgZGF0YSwgYW5kIHBhdGNoICM1IGRvZXMgdGhlIGNsb2NrIHN3YXBwaW5nLgoKV2l0
aCB0aGlzIHNlcmllcywgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBwb3B1bGF0ZSBjbGtjdHJsIGNs
b2NrCmVudHJpZXMgdG8gRFQgYXQgYWxsLCB0aHVzIHRoZSB0cmFuc2l0aW9uIHNob3VsZCBiZSBz
bW9vdGhlci4KCkludGVncmF0ZWQgdGVzdCBicmFuY2ggZm9yIG9tYXA0IHB1c2hlZCBoZXJlIChj
b250YWlucyAzIGV4dHJhIERUCnBhdGNoZXMgb24gdG9wLikKClRyZWU6IGh0dHBzOi8vZ2l0aHVi
LmNvbS90LWtyaXN0by9saW51eC1wbS5naXQKQnJhbmNoOiA0LjEyLXJjMS1jbGtjdHJsLWludGVn
LXYzYgoKLVRlcm8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
