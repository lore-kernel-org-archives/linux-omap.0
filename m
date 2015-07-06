From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/5] arm: boot: convert ATAG_REVISION to DT "/revision" entry
Date: Mon,  6 Jul 2015 22:26:10 +0200
Message-ID: <1436214373-12969-3-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

V2hlbiB1bmNvbXByZXNzaW5nIGtlcm5lbCBpbWFnZSB0aGlzIHBhdGNoIGNvbnZlcnQgQVRBR19S
RVZJU0lPTiBzdHJ1Y3R1cmUKaW50byBEVCAiL3JldmlzaW9uIiBlbnRyeS4gRm9yIGxlZ2FjeSBi
b290bG9hZGVycyB3aGljaCBkbyBub3Qgc3VwcG9ydCBEVApib290aW5nIHRoZXJlIGlzIG5vIG90
aGVyIG9wdGlvbiBob3cgdG8gcGFzcyBBVEFHX1JFVklTSU9OIGludG8ga2VybmVsLgoKU2lnbmVk
LW9mZi1ieTogUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPgotLS0KIGFyY2gvYXJt
L2Jvb3QvY29tcHJlc3NlZC9hdGFnc190b19mZHQuYyB8ICAgIDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2NvbXByZXNzZWQv
YXRhZ3NfdG9fZmR0LmMgYi9hcmNoL2FybS9ib290L2NvbXByZXNzZWQvYXRhZ3NfdG9fZmR0LmMK
aW5kZXggOTQ0OGFhMC4uZTdlMWNjOSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9jb21wcmVz
c2VkL2F0YWdzX3RvX2ZkdC5jCisrKyBiL2FyY2gvYXJtL2Jvb3QvY29tcHJlc3NlZC9hdGFnc190
b19mZHQuYwpAQCAtMTcxLDYgKzE3MSw4IEBAIGludCBhdGFnc190b19mZHQodm9pZCAqYXRhZ19s
aXN0LCB2b2lkICpmZHQsIGludCB0b3RhbF9zcGFjZSkKIAkJCQkJY3B1X3RvX2ZkdDMyKGF0YWct
PnUubWVtLnNpemUpOwogCQkJfQogCisJCX0gZWxzZSBpZiAoYXRhZy0+aGRyLnRhZyA9PSBBVEFH
X1JFVklTSU9OKSB7CisJCQlzZXRwcm9wX2NlbGwoZmR0LCAiLyIsICJyZXZpc2lvbiIsIGF0YWct
PnUucmV2aXNpb24ucmV2KTsKIAkJfSBlbHNlIGlmIChhdGFnLT5oZHIudGFnID09IEFUQUdfSU5J
VFJEMikgewogCQkJdWludDMyX3QgaW5pdHJkX3N0YXJ0LCBpbml0cmRfc2l6ZTsKIAkJCWluaXRy
ZF9zdGFydCA9IGF0YWctPnUuaW5pdHJkLnN0YXJ0OwotLSAKMS43LjkuNQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
