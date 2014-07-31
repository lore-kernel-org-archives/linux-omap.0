From: Jeremy Vial <jvial@adeneo-embedded.com>
Subject: [PATCH 1/2] ARM: OMAP3: Fix choice of omap3_restore_es function in
 OMAP34XX rev3.1.2 case.
Date: Thu, 31 Jul 2014 15:10:33 +0200
Message-ID: <1406812234-23163-2-git-send-email-jvial@adeneo-embedded.com>
References: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

QWNjb3JkaW5nIHRvIHRoZSBjb21tZW50IOKAnHJlc3RvcmVfZXMzOiBhcHBsaWVzIHRvIDM0eHgg
Pj0gRVMzLjAiIGluCiJhcmNoL2FybS9tYWNoLW9tYXAyL3NsZWVwMzR4eC5T4oCdLCBvbWFwM19y
ZXN0b3JlX2VzMyBzaG91bGQgYmUgdXNlZAppZiB0aGUgcmV2aXNpb24gb2YgYW4gT01BUDM0eHgg
aXMgRVMzLjEuMi4KClNpZ25lZC1vZmYtYnk6IEplcmVteSBWaWFsIDxqdmlhbEBhZGVuZW8tZW1i
ZWRkZWQuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvY29udHJvbC5jIHwgICAgMyArKy0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2NvbnRyb2wuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
Y29udHJvbC5jCmluZGV4IDc1MWYzNTQuLmFjYWRhYzAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvY29udHJvbC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvY29udHJvbC5jCkBA
IC0zMTQsNyArMzE0LDggQEAgdm9pZCBvbWFwM19zYXZlX3NjcmF0Y2hwYWRfY29udGVudHModm9p
ZCkKIAkJc2NyYXRjaHBhZF9jb250ZW50cy5wdWJsaWNfcmVzdG9yZV9wdHIgPQogCQkJdmlydF90
b19waHlzKG9tYXAzX3Jlc3RvcmVfMzYzMCk7CiAJZWxzZSBpZiAob21hcF9yZXYoKSAhPSBPTUFQ
MzQzMF9SRVZfRVMzXzAgJiYKLQkJCQkJb21hcF9yZXYoKSAhPSBPTUFQMzQzMF9SRVZfRVMzXzEp
CisJCQkJCW9tYXBfcmV2KCkgIT0gT01BUDM0MzBfUkVWX0VTM18xICYmCisJCQkJCW9tYXBfcmV2
KCkgIT0gT01BUDM0MzBfUkVWX0VTM18xXzIpCiAJCXNjcmF0Y2hwYWRfY29udGVudHMucHVibGlj
X3Jlc3RvcmVfcHRyID0KIAkJCXZpcnRfdG9fcGh5cyhvbWFwM19yZXN0b3JlKTsKIAllbHNlCi0t
IAoxLjcuOS41CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
