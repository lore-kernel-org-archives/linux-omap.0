From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH] arm: omap2: vc: fix 'or' always true warning
Date: Fri, 28 Aug 2015 12:10:32 +0200
Message-ID: <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
References: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Frans Klaver <fransklaver@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, David Binderman <dcb314@hotmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

RnJvbTogRnJhbnMgS2xhdmVyIDxmcmFuc2tsYXZlckBnbWFpbC5jb20+CgpGaXggdGhlIHdhcm5p
bmc6CmFyY2gvYXJtL21hY2gtb21hcDIvdmMuYzozMDI6NDc6IHdhcm5pbmc6IGxvZ2ljYWwg4oCY
b3LigJkgb2YgY29sbGVjdGl2ZWx5IGV4aGF1c3RpdmUgdGVzdHMgaXMgYWx3YXlzIHRydWUgWy1X
bG9naWNhbC1vcF0KCkFzIHdlJ3JlIHRvZ2dsaW5nIGJvdGggQ0xLUkVRIGFuZCBPRkZNT0RFLCB3
ZSBzaG91bGQgYWxzbyBiZSBjaGVja2luZwpPRkZNT0RFLgoKU2lnbmVkLW9mZi1ieTogRnJhbnMg
S2xhdmVyIDxmcmFuc2tsYXZlckBnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi92
Yy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi92Yy5jIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi92Yy5jCmluZGV4IDA3NmZkMjBkN2U1YS4uODA3YmM3OWUzZTNkIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3ZjLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi92Yy5jCkBA
IC0zMDAsNyArMzAwLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXAzX3ZjX2luaXRfcG1pY19z
aWduYWxpbmcoc3RydWN0IHZvbHRhZ2Vkb21haW4gKnZvbHRkbSkKIAogCXZhbCA9IHZvbHRkbS0+
cmVhZChPTUFQM19QUk1fUE9MQ1RSTF9PRkZTRVQpOwogCWlmICghKHZhbCAmIE9NQVAzNDMwX1BS
TV9QT0xDVFJMX0NMS1JFUV9QT0wpIHx8Ci0JICAgICh2YWwgJiBPTUFQMzQzMF9QUk1fUE9MQ1RS
TF9DTEtSRVFfUE9MKSkgeworCSAgICAodmFsICYgT01BUDM0MzBfUFJNX1BPTENUUkxfT0ZGTU9E
RV9QT0wpKSB7CiAJCXZhbCB8PSBPTUFQMzQzMF9QUk1fUE9MQ1RSTF9DTEtSRVFfUE9MOwogCQl2
YWwgJj0gfk9NQVAzNDMwX1BSTV9QT0xDVFJMX09GRk1PREVfUE9MOwogCQlwcl9kZWJ1ZygiUE06
IGZpeGluZyBzeXNfY2xrcmVxIGFuZCBzeXNfb2ZmX21vZGUgcG9sYXJpdHkgdG8gMHgleFxuIiwK
LS0gCjIuMy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
