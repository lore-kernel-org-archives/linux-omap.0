From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 19/27] OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
Date: Wed, 14 Oct 2009 14:58:02 -0700
Message-ID: <1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

RnJvbTogS2FsbGUgSm9raW5pZW1pIDxrYWxsZS5qb2tpbmllbWlAZGlnaWEuY29tPgoKVGhlIENN
X0NMS0VOX1BMTCByZWdpc3RlciBzYXZlZCBpbiBzY3JhdGNocGFkIG1lbW9yeQp3YXMgd3Jvbmds
eSB1c2luZyBvZmZzZXQgb2YgMHgwMDA0IGluc3RlYWQgb2YgMHgwMDAwLgoKVGhlIGVmZmVjdCBv
ZiB0aGlzIHdhcyB0aGF0IGJvb3QgUk9NIGNvZGUgd291bGQKcmVzdG9yZSB0aGUgd3JvbmcgdmFs
dWUgd2hlbiB3YWtpbmcgdXAgZnJvbSBvZmYgbW9kZS4KVGhpcyB3cm9uZyB2YWx1ZSwgaG93ZXZl
ciwgd2lsbCBiZSBvdmVyd3JpdHRlbiBieQpwcmNtIGNvbnRleHQgcmVzdG9yZS4gU3RpbGwsIGEg
c2hvcnQgcGVyaW9kIG9mIHdyb25nCmNsb2NrIHNldHRpbmdzIGluIENNX0NMS0VOX1BMTCByZW1h
aW5lZCBiZXR3ZWVuIFJPTQpjb2RlIGFuZCBwcmNtIGNvbnRleHQgcmVzdG9yZS4gVGhpcyBpcyBm
aXhlZCBieSB0aGUKcGF0Y2guCgpQcm9ibGVtIHJlcG9ydGVkIGJ5OiBKb3VuaSBIw7ZnYW5kZXIg
PGpvdW5pLmhvZ2FuZGVyQG5va2lhLmNvbT4KClNpZ25lZC1vZmYtYnk6IEthbGxlIEpva2luaWVt
aSA8a2FsbGUuam9raW5pZW1pQGRpZ2lhLmNvbT4KU2lnbmVkLW9mZi1ieTogS2V2aW4gSGlsbWFu
IDxraGlsbWFuQGRlZXByb290c3lzdGVtcy5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9j
b250cm9sLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2NvbnRyb2wuYyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvY29udHJvbC5jCmluZGV4IDZjNDYyYzcuLjUwYjNhZmMgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvY29udHJvbC5jCisrKyBiL2FyY2gvYXJtL21h
Y2gtb21hcDIvY29udHJvbC5jCkBAIC0yMjgsNyArMjI4LDcgQEAgdm9pZCBvbWFwM19zYXZlX3Nj
cmF0Y2hwYWRfY29udGVudHModm9pZCkKIAlwcmNtX2Jsb2NrX2NvbnRlbnRzLmNtX2Nsa3NlbF93
a3VwID0KIAkJCWNtX3JlYWRfbW9kX3JlZyhXS1VQX01PRCwgQ01fQ0xLU0VMKTsKIAlwcmNtX2Js
b2NrX2NvbnRlbnRzLmNtX2Nsa2VuX3BsbCA9Ci0JCQljbV9yZWFkX21vZF9yZWcoUExMX01PRCwg
T01BUDM0MzBfQ01fQ0xLRU5fUExMKTsKKwkJCWNtX3JlYWRfbW9kX3JlZyhQTExfTU9ELCBDTV9D
TEtFTik7CiAJcHJjbV9ibG9ja19jb250ZW50cy5jbV9hdXRvaWRsZV9wbGwgPQogCQkJY21fcmVh
ZF9tb2RfcmVnKFBMTF9NT0QsIE9NQVAzNDMwX0NNX0FVVE9JRExFX1BMTCk7CiAJcHJjbV9ibG9j
a19jb250ZW50cy5jbV9jbGtzZWwxX3BsbCA9Ci0tIAoxLjYuNC4zCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
