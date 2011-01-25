From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 21:34:15 +0530
Message-ID: <68b4be46e93b4017650bc4bf230afef6@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125103231.GD11507@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6>
	<20110125133752.GI13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5a8605ea19c049aaddef1
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110125133752.GI13300@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>
List-Id: linux-omap@vger.kernel.org

--001636c5a8605ea19c049aaddef1
Content-Type: text/plain; charset=ISO-8859-1

Russell, Thomas
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 7:08 PM
> To: Thomas Gleixner
> Cc: Colin Cross; Santosh Shilimkar; catalin.marinas@arm.com;
> linus.ml.walleij@gmail.com; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
[...]
>
> I can't say because these patches only add the hooks, there's no
> implementation yet which uses the hooks.
>
> Given the description about _why_ those hooks are necessary, it
> seems
> that something is required.  Either we start adding custom hacks to
> each clockevent driver as is done with this patch, or we get some
> generic help in place.
>
> I'm not thrilled by the custom hack approach - and I thought the
> clockevent stuff was created to stop this kind of thing happening.
>
> I suggest we defer this until there's a visible use case available.
Got some time to debug this issue. OMAP idle code already has the
broad-cast notifiers working for sometime. So I removed the existing
save restore twd code and just used the below patch which Russell
posted on this thread.
And things just work and I guess we are done with this issue !!
Timer framework is doing all right things with notifiers.

Am going to use this patch for my further work and drop the
save/restore patch. Will update you if there is any other
issue on this. I should have validated this patch on my own
earlier :(

Thanks for the discussion.

-----------------
>From 9084dd3e68a8528172d97fb49c42437ae873af43 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Tue, 25 Jan 2011 14:26:41 +0530
Subject: [PATCH] ARM: smp_twd: Always program the loadvalue when switching
to periodic mode.

Always program the load value when switching to periodic mode so that
we don't need to save restore twd load register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp_twd.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fd91566..60636f4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode mode,
 		/* timer load already set up */
 		ctrl = TWD_TIMER_CONTROL_ENABLE |
TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
+		__raw_writel(twd_timer_rate / HZ, twd_base +
TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* period set, and timer enabled in 'next_event' hook */
@@ -81,7 +82,7 @@ int twd_timer_ack(void)

 static void __cpuinit twd_calibrate_rate(void)
 {
-	unsigned long load, count;
+	unsigned long count;
 	u64 waitjiffies;

 	/*
@@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 1000000) % 100);
 	}
-
-	load = twd_timer_rate / HZ;
-
-	__raw_writel(load, twd_base + TWD_TIMER_LOAD);
 }

 /*
-- 
1.6.0.4

--001636c5a8605ea19c049aaddef1
Content-Type: application/octet-stream;
	name="0001-ARM-smp_twd-Always-program-the-loadvalue-when-swit.patch"
Content-Disposition: attachment;
	filename="0001-ARM-smp_twd-Always-program-the-loadvalue-when-swit.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: c33e3ae155501f20_0.1

RnJvbSA5MDg0ZGQzZTY4YTg1MjgxNzJkOTdmYjQ5YzQyNDM3YWU4NzNhZjQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtLmxpbnV4Lm9y
Zy51az4KRGF0ZTogVHVlLCAyNSBKYW4gMjAxMSAxNDoyNjo0MSArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEFSTTogc21wX3R3ZDogQWx3YXlzIHByb2dyYW0gdGhlIGxvYWR2YWx1ZSB3aGVuIHN3aXRj
aGluZyB0byBwZXJpb2RpYyBtb2RlLgoKQWx3YXlzIHByb2dyYW0gdGhlIGxvYWQgdmFsdWUgd2hl
biBzd2l0Y2hpbmcgdG8gcGVyaW9kaWMgbW9kZSBzbyB0aGF0CndlIGRvbid0IG5lZWQgdG8gc2F2
ZSByZXN0b3JlIHR3ZCBsb2FkIHJlZ2lzdGVyLgoKU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5n
IDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+Ci0tLQogYXJjaC9hcm0va2VybmVsL3NtcF90
d2QuYyB8ICAgIDcgKystLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVsL3NtcF90d2QuYyBiL2Fy
Y2gvYXJtL2tlcm5lbC9zbXBfdHdkLmMKaW5kZXggZmQ5MTU2Ni4uNjA2MzZmNCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0va2VybmVsL3NtcF90d2QuYworKysgYi9hcmNoL2FybS9rZXJuZWwvc21wX3R3
ZC5jCkBAIC0zNiw2ICszNiw3IEBAIHN0YXRpYyB2b2lkIHR3ZF9zZXRfbW9kZShlbnVtIGNsb2Nr
X2V2ZW50X21vZGUgbW9kZSwKIAkJLyogdGltZXIgbG9hZCBhbHJlYWR5IHNldCB1cCAqLwogCQlj
dHJsID0gVFdEX1RJTUVSX0NPTlRST0xfRU5BQkxFIHwgVFdEX1RJTUVSX0NPTlRST0xfSVRfRU5B
QkxFCiAJCQl8IFRXRF9USU1FUl9DT05UUk9MX1BFUklPRElDOworCQlfX3Jhd193cml0ZWwodHdk
X3RpbWVyX3JhdGUgLyBIWiwgdHdkX2Jhc2UgKyBUV0RfVElNRVJfTE9BRCk7CiAJCWJyZWFrOwog
CWNhc2UgQ0xPQ0tfRVZUX01PREVfT05FU0hPVDoKIAkJLyogcGVyaW9kIHNldCwgYW5kIHRpbWVy
IGVuYWJsZWQgaW4gJ25leHRfZXZlbnQnIGhvb2sgKi8KQEAgLTgxLDcgKzgyLDcgQEAgaW50IHR3
ZF90aW1lcl9hY2sodm9pZCkKIAogc3RhdGljIHZvaWQgX19jcHVpbml0IHR3ZF9jYWxpYnJhdGVf
cmF0ZSh2b2lkKQogewotCXVuc2lnbmVkIGxvbmcgbG9hZCwgY291bnQ7CisJdW5zaWduZWQgbG9u
ZyBjb3VudDsKIAl1NjQgd2FpdGppZmZpZXM7CiAKIAkvKgpAQCAtMTE2LDEwICsxMTcsNiBAQCBz
dGF0aWMgdm9pZCBfX2NwdWluaXQgdHdkX2NhbGlicmF0ZV9yYXRlKHZvaWQpCiAJCXByaW50aygi
JWx1LiUwMmx1TUh6LlxuIiwgdHdkX3RpbWVyX3JhdGUgLyAxMDAwMDAwLAogCQkJKHR3ZF90aW1l
cl9yYXRlIC8gMTAwMDAwMCkgJSAxMDApOwogCX0KLQotCWxvYWQgPSB0d2RfdGltZXJfcmF0ZSAv
IEhaOwotCi0JX19yYXdfd3JpdGVsKGxvYWQsIHR3ZF9iYXNlICsgVFdEX1RJTUVSX0xPQUQpOwog
fQogCiAvKgotLSAKMS42LjAuNAoK
--001636c5a8605ea19c049aaddef1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--001636c5a8605ea19c049aaddef1--
