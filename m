From: =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>
Subject: [PATCH] nand: omap2: Missing arg to gpmc_prefetch_reset()
Date: Fri, 24 Sep 2010 23:45:02 +0200
Message-ID: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>, Sukumar Ghorai <s-ghorai@ti.com>
List-Id: linux-omap@vger.kernel.org

Rml4IG1pc3NpbmcgY3MgYXJnIHRvIGdwbWNfcHJlZmV0Y2hfcmVzZXQoKSB3aGVuCkNPTkZJR19N
VERfTkFORF9PTUFQX1BSRUZFVENIX0RNQT15IHdoaWNoIGNhdXNlZCBhIGJ1aWxkIGZhaWx1cmUg
c2luY2UKOTQ4ZDM4ZTc5OWYwYWI4N2NmOGVkOTExM2ZjZGFhZWU2MWFjZjMyMToKZHJpdmVycy9t
dGQvbmFuZC9vbWFwMi5jOiBJbiBmdW5jdGlvbiAnb21hcF9uYW5kX2RtYV90cmFuc2Zlcic6CmRy
aXZlcnMvbXRkL25hbmQvb21hcDIuYzo0MTY6IGVycm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBm
dW5jdGlvbiAnZ3BtY19wcmVmZXRjaF9yZXNldCcKClNpZ25lZC1vZmYtYnk6IExvw69jIE1pbmll
ciA8bG9pYy5taW5pZXJAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL210ZC9uYW5kL29tYXAyLmMg
fCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMgYi9kcml2ZXJzL210ZC9u
YW5kL29tYXAyLmMKaW5kZXggMTMzZDUxNS4uNTEzZTBhNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
dGQvbmFuZC9vbWFwMi5jCisrKyBiL2RyaXZlcnMvbXRkL25hbmQvb21hcDIuYwpAQCAtNDEzLDcg
KzQxMyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG9tYXBfbmFuZF9kbWFfdHJhbnNmZXIoc3RydWN0
IG10ZF9pbmZvICptdGQsIHZvaWQgKmFkZHIsCiAJCXByZWZldGNoX3N0YXR1cyA9IGdwbWNfcmVh
ZF9zdGF0dXMoR1BNQ19QUkVGRVRDSF9DT1VOVCk7CiAJfSB3aGlsZSAocHJlZmV0Y2hfc3RhdHVz
KTsKIAkvKiBkaXNhYmxlIGFuZCBzdG9wIHRoZSBQRlBXIGVuZ2luZSAqLwotCWdwbWNfcHJlZmV0
Y2hfcmVzZXQoKTsKKwlncG1jX3ByZWZldGNoX3Jlc2V0KGluZm8tPmdwbWNfY3MpOwogCiAJZG1h
X3VubWFwX3NpbmdsZSgmaW5mby0+cGRldi0+ZGV2LCBkbWFfYWRkciwgbGVuLCBkaXIpOwogCXJl
dHVybiAwOwotLSAKMS43LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0Cmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLwo=
