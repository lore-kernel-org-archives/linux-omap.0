From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for platform_cpu_die()
Date: Thu, 23 Feb 2012 14:10:30 +0530
Message-ID: <CAMQu2gxLJOY8HzMO71dHTr8VfQ+G=KJP+wv5SwvrktTi7b82+A@mail.gmail.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
 <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com> <20120223074504.GZ14173@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00235429d1acf107d004b99d9918
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38929 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841Ab2BWIkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 03:40:51 -0500
Received: by mail-qw0-f42.google.com with SMTP id y23so9893518qad.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 00:40:50 -0800 (PST)
In-Reply-To: <20120223074504.GZ14173@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--00235429d1acf107d004b99d9918
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/23 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Feb 23, 2012 at 12:28:30PM +0530, Santosh Shilimkar wrote:
>> WARNING: vmlinux.o(.text+0x226d0):
>> Section mismatch in reference from the function
>> platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
>> The function platform_cpu_die() references
>> the function __cpuinit omap4_hotplug_cpu().
>> This is often because platform_cpu_die lacks a __cpuinit
>> annotation or the annotation of omap4_hotplug_cpu is wrong.
>>
>> Thanks to Russell King for suggesting __ref annotation trick
>> just like it's parent function for this warning becasue __cupinit
> s/it's/its/; s/becasue/because/; s/cup/cpu/
>
> Having said that I think the grammar is broken, too. Maybe:
>
> =A0 =A0 =A0 =A0Thanks to Russell King for suggesting to use __ref instead=
 of
> =A0 =A0 =A0 =A0the initial (and wrong) approach to use __cpuinit.
>
> (But note I'm not a native speaker, too)
>
Thanks for fixing the grammar. :)
Updated patch below with comments corrected as per
your suggestion.

Regards
Santosh

>From a53dd2d822dc9c9894c2f2f3d239af341c66d891 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 22 Feb 2012 16:10:04 +0530
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
platform_cpu_die()

WARNING: vmlinux.o(.text+0x226d0):
Section mismatch in reference from the function
platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
The function platform_cpu_die() references
the function __cpuinit omap4_hotplug_cpu().
This is often because platform_cpu_die lacks a __cpuinit
annotation or the annotation of omap4_hotplug_cpu is wrong.

Thanks to Russell King for suggesting to use __ref instead of
the initial (and wrong) approach to use __cpuinit.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c
b/arch/arm/mach-omap2/omap-hotplug.c
index adbe4d8..56c345b 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;

--=20
1.7.4.1

--00235429d1acf107d004b99d9918
Content-Type: application/octet-stream;
	name="0002-ARM-OMAP-Fix-section-mismatch-warning-for-platform_c.patch"
Content-Disposition: attachment;
	filename="0002-ARM-OMAP-Fix-section-mismatch-warning-for-platform_c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gyzjk75e0

RnJvbSBhNTNkZDJkODIyZGM5Yzk4OTRjMmYyZjNkMjM5YWYzNDFjNjZkODkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBXZWQsIDIyIEZlYiAyMDEyIDE2OjEwOjA0ICswNTMwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIEFSTTogT01BUDogRml4IHNlY3Rpb24gbWlzbWF0Y2ggd2FybmluZyBmb3IgcGxh
dGZvcm1fY3B1X2RpZSgpCgpXQVJOSU5HOiB2bWxpbnV4Lm8oLnRleHQrMHgyMjZkMCk6ClNlY3Rp
b24gbWlzbWF0Y2ggaW4gcmVmZXJlbmNlIGZyb20gdGhlIGZ1bmN0aW9uCnBsYXRmb3JtX2NwdV9k
aWUoKSB0byB0aGUgZnVuY3Rpb24gLmNwdWluaXQudGV4dDpvbWFwNF9ob3RwbHVnX2NwdSgpClRo
ZSBmdW5jdGlvbiBwbGF0Zm9ybV9jcHVfZGllKCkgcmVmZXJlbmNlcwp0aGUgZnVuY3Rpb24gX19j
cHVpbml0IG9tYXA0X2hvdHBsdWdfY3B1KCkuClRoaXMgaXMgb2Z0ZW4gYmVjYXVzZSBwbGF0Zm9y
bV9jcHVfZGllIGxhY2tzIGEgX19jcHVpbml0CmFubm90YXRpb24gb3IgdGhlIGFubm90YXRpb24g
b2Ygb21hcDRfaG90cGx1Z19jcHUgaXMgd3JvbmcuCgpUaGFua3MgdG8gUnVzc2VsbCBLaW5nIGZv
ciBzdWdnZXN0aW5nIHRvIHVzZSBfX3JlZiBpbnN0ZWFkIG9mCnRoZSBpbml0aWFsIChhbmQgd3Jv
bmcpIGFwcHJvYWNoIHRvIHVzZSBfX2NwdWluaXQuCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNo
aWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21h
cDIvb21hcC1ob3RwbHVnLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29t
YXAtaG90cGx1Zy5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLWhvdHBsdWcuYwppbmRleCBh
ZGJlNGQ4Li41NmMzNDViIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAtaG90
cGx1Zy5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcC1ob3RwbHVnLmMKQEAgLTMzLDcg
KzMzLDcgQEAgaW50IHBsYXRmb3JtX2NwdV9raWxsKHVuc2lnbmVkIGludCBjcHUpCiAgKiBwbGF0
Zm9ybS1zcGVjaWZpYyBjb2RlIHRvIHNodXRkb3duIGEgQ1BVCiAgKiBDYWxsZWQgd2l0aCBJUlFz
IGRpc2FibGVkCiAgKi8KLXZvaWQgcGxhdGZvcm1fY3B1X2RpZSh1bnNpZ25lZCBpbnQgY3B1KQor
dm9pZCBfX3JlZiBwbGF0Zm9ybV9jcHVfZGllKHVuc2lnbmVkIGludCBjcHUpCiB7CiAJdW5zaWdu
ZWQgaW50IHRoaXNfY3B1OwogCi0tIAoxLjcuNC4xCgo=
--00235429d1acf107d004b99d9918--
