From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
 speed-up boot
Date: Fri, 21 Jan 2011 19:13:48 +0530
Message-ID: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
 <4D385155.4050301@gmail.com> <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
 <4D38641E.2000301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d9a271b7ebd0049a5b7037
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57621 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab1AUNnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 08:43:52 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so1665745bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 05:43:50 -0800 (PST)
In-Reply-To: <4D38641E.2000301@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

--0016e6d9a271b7ebd0049a5b7037
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Rob Herring [mailto:robherring2@gmail.com]
> Sent: Thursday, January 20, 2011 10:05 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; Russell King; linux-
> omap@vger.kernel.org; Linus Walleij
> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
> to speed-up boot

[..]

> >>
> >> There's already one way to do this with pre-calculated lpj.
> >>
> > How about the hot-plug path? This is not for just boot.
>
> The path is the same for hotplug and secondary boot, so yes for
> both.
> Plus you get the added benefit of speeding up the primary core boot
> as well.
>
No 'preset_lpj' will not work for the hotplug path when
cpufreq is active. It just useful only for boot in
its current form.

> >
> >> Also, this isn't multi-platform friendly. You could accomplish
> the
> >> same
> >> thing using the clock api to get the core frequency of each core
> and
> >> only calculate lpj if the frequency is different.
> > May be but what's wrong with the obvious approach which is
> > completely non-intrusive.
> > Why is not multi-platform friendly ?
> > Archs can choose not to select this option.
>
> I meant you can't have single kernel binary with a platform with
> single
> core freq and a platform with independent core freq.
>
> Looking at this some more, the only reason to call calibrate_delay
> is to
> get a more accurate value. If you have different frequencies per
> core,
> you've got bigger problems as loops_per_jiffy value is not per core.
> So
> your kconfig option name is misleading. Something like
> ARCH_WANT_UDELAY_RECALC would be more accurate. To get a more
> accurate
> calculation, calibrate_delay only needs to be called by 1 secondary
> core. Perhaps it could be called from somewhere that is not in the
> boot/hotplug path or only done once.
>
Similar name was there in my earlier version.
	"ARCH_SKIP_SECONDARY_CALIBRATE"
I changed it based on Linus W suggestion. I understand your one
binary point and this patch.

How about below approach?

-----------------------------------------------------
[PATCH] ARM: smp: Skip secondary cpu calibration to speed-up boot

On some architectures, secondary cores shares clock with primiary
core and hence scale together. Hence secondary core lpj calibration
is not necessary and can be skipped to save considerable time.

This can speed up the secondary cpu boot and hotplug cpu online
paths.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/smp.h     |    8 ++++++++
 arch/arm/kernel/smp.c          |   34 ++++++++++++++++++++++++++--------
 arch/arm/mach-omap2/omap-smp.c |    3 +++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..7ffdfec 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -69,6 +69,14 @@ asmlinkage void secondary_start_kernel(void);
 extern void platform_secondary_init(unsigned int cpu);

 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs inside
+ * platform_secondary_init()
+ */
+extern void secondary_skip_calibrate(void);
+
+
+/*
  * Initialize cpu_possible map, and enable coherency
  */
 extern void platform_smp_prepare_cpus(unsigned int);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..b20c408 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -55,6 +55,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };

+static unsigned int skip_secondary_calibrate;
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
@@ -270,6 +272,16 @@ static void __cpuinit smp_store_cpu_info(unsigned int
cpuid)
 }

 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs from
+ * platform_secondary_init()
+ */
+void secondary_skip_calibrate(void)
+{
+	skip_secondary_calibrate = 1;
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -312,7 +324,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();

-	calibrate_delay();
+	if (!skip_secondary_calibrate)
+		calibrate_delay();

 	smp_store_cpu_info(cpu);

@@ -332,14 +345,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	int cpu;
 	unsigned long bogosum = 0;

-	for_each_online_cpu(cpu)
-		bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+	if (!skip_secondary_calibrate) {
+		for_each_online_cpu(cpu)
+			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;

-	printk(KERN_INFO "SMP: Total of %d processors activated "
-	       "(%lu.%02lu BogoMIPS).\n",
-	       num_online_cpus(),
-	       bogosum / (500000/HZ),
-	       (bogosum / (5000/HZ)) % 100);
+		printk(KERN_INFO "SMP: Total of %d processors activated "
+		       "(%lu.%02lu BogoMIPS).\n",
+			num_online_cpus(),
+			bogosum / (500000/HZ),
+			(bogosum / (5000/HZ)) % 100);
+	} else {
+		printk(KERN_INFO "SMP: Total of %d processors
activated.\n",
+			num_online_cpus());
+	}
 }

 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm/mach-omap2/omap-smp.c
b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..7342cd5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -39,6 +39,9 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 */
 	gic_secondary_init(0);

+	/* Allow to skip secondary CPU calibration */
+	secondary_skip_calibrate();
+
 	/*
 	 * Synchronise with the boot thread.
 	 */
-- 
1.6.0.4

--0016e6d9a271b7ebd0049a5b7037
Content-Type: application/octet-stream;
	name="0001-ARM-smp-Skip-secondary-cpu-calibration-to-speed-up.patch"
Content-Disposition: attachment;
	filename="0001-ARM-smp-Skip-secondary-cpu-calibration-to-speed-up.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: da48af5e6300b15d_0.1

RnJvbSA4YmM1YTI0YjdjYzYwYjU0YzdhYmFlMDZmMWNjMzMxMWUyMGZiODE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBNb24sIDEwIEphbiAyMDExIDAyOjU4OjM5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBzbXA6IFNraXAgc2Vjb25kYXJ5IGNwdSBjYWxpYnJhdGlvbiB0byBzcGVlZC11
cCBib290CgpPbiBzb21lIGFyY2hpdGVjdHVyZXMsIHNlY29uZGFyeSBjb3JlcyBzaGFyZXMgY2xv
Y2sgd2l0aCBwcmltaWFyeQpjb3JlIGFuZCBoZW5jZSBzY2FsZSB0b2dldGhlci4gSGVuY2Ugc2Vj
b25kYXJ5IGNvcmUgbHBqIGNhbGlicmF0aW9uCmlzIG5vdCBuZWNlc3NhcnkgYW5kIGNhbiBiZSBz
a2lwcGVkIHRvIHNhdmUgY29uc2lkZXJhYmxlIHRpbWUuCgpUaGlzIGNhbiBzcGVlZCB1cCB0aGUg
c2Vjb25kYXJ5IGNwdSBib290IGFuZCBob3RwbHVnIGNwdSBvbmxpbmUKcGF0aHMuCgpTaWduZWQt
b2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgotLS0K
IGFyY2gvYXJtL2luY2x1ZGUvYXNtL3NtcC5oICAgICB8ICAgIDggKysrKysrKysKIGFyY2gvYXJt
L2tlcm5lbC9zbXAuYyAgICAgICAgICB8ICAgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLXNtcC5jIHwgICAgMyArKysKIDMgZmls
ZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9pbmNsdWRlL2FzbS9zbXAuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3NtcC5o
CmluZGV4IDk2ZWQ1MjEuLjdmZmRmZWMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNt
L3NtcC5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3NtcC5oCkBAIC02OSw2ICs2OSwxNCBA
QCBhc21saW5rYWdlIHZvaWQgc2Vjb25kYXJ5X3N0YXJ0X2tlcm5lbCh2b2lkKTsKIGV4dGVybiB2
b2lkIHBsYXRmb3JtX3NlY29uZGFyeV9pbml0KHVuc2lnbmVkIGludCBjcHUpOwogCiAvKgorICog
U2tpcCB0aGUgc2Vjb25kYXJ5IGNhbGlicmF0aW9uIG9uIGFyY2hpdGVjdHVyZXMgc2hhcmluZyBj
bG9jaworICogd2l0aCBwcmltYXJ5IGNwdS4gTmVlZHMgdG8gYmUgY2FsbGVkIGZvciBhcmNocyBp
bnNpZGUgCisgKiBwbGF0Zm9ybV9zZWNvbmRhcnlfaW5pdCgpCisgKi8KK2V4dGVybiB2b2lkIHNl
Y29uZGFyeV9za2lwX2NhbGlicmF0ZSh2b2lkKTsKKworCisvKgogICogSW5pdGlhbGl6ZSBjcHVf
cG9zc2libGUgbWFwLCBhbmQgZW5hYmxlIGNvaGVyZW5jeQogICovCiBleHRlcm4gdm9pZCBwbGF0
Zm9ybV9zbXBfcHJlcGFyZV9jcHVzKHVuc2lnbmVkIGludCk7CmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9rZXJuZWwvc21wLmMgYi9hcmNoL2FybS9rZXJuZWwvc21wLmMKaW5kZXggNDUzOWViYy4uYjIw
YzQwOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0va2VybmVsL3NtcC5jCisrKyBiL2FyY2gvYXJtL2tl
cm5lbC9zbXAuYwpAQCAtNTUsNiArNTUsOCBAQCBlbnVtIGlwaV9tc2dfdHlwZSB7CiAJSVBJX0NQ
VV9TVE9QLAogfTsKIAorc3RhdGljIHVuc2lnbmVkIGludCBza2lwX3NlY29uZGFyeV9jYWxpYnJh
dGU7CisKIGludCBfX2NwdWluaXQgX19jcHVfdXAodW5zaWduZWQgaW50IGNwdSkKIHsKIAlzdHJ1
Y3QgY3B1aW5mb19hcm0gKmNpID0gJnBlcl9jcHUoY3B1X2RhdGEsIGNwdSk7CkBAIC0yNzAsNiAr
MjcyLDE2IEBAIHN0YXRpYyB2b2lkIF9fY3B1aW5pdCBzbXBfc3RvcmVfY3B1X2luZm8odW5zaWdu
ZWQgaW50IGNwdWlkKQogfQogCiAvKgorICogU2tpcCB0aGUgc2Vjb25kYXJ5IGNhbGlicmF0aW9u
IG9uIGFyY2hpdGVjdHVyZXMgc2hhcmluZyBjbG9jaworICogd2l0aCBwcmltYXJ5IGNwdS4gTmVl
ZHMgdG8gYmUgY2FsbGVkIGZvciBhcmNocyBmcm9tCisgKiBwbGF0Zm9ybV9zZWNvbmRhcnlfaW5p
dCgpCisgKi8KK3ZvaWQgc2Vjb25kYXJ5X3NraXBfY2FsaWJyYXRlKHZvaWQpCit7CisJc2tpcF9z
ZWNvbmRhcnlfY2FsaWJyYXRlID0gMTsKK30KKworLyoKICAqIFRoaXMgaXMgdGhlIHNlY29uZGFy
eSBDUFUgYm9vdCBlbnRyeS4gIFdlJ3JlIHVzaW5nIHRoaXMgQ1BVcwogICogaWRsZSB0aHJlYWQg
c3RhY2ssIGJ1dCBhIHNldCBvZiB0ZW1wb3JhcnkgcGFnZSB0YWJsZXMuCiAgKi8KQEAgLTMxMiw3
ICszMjQsOCBAQCBhc21saW5rYWdlIHZvaWQgX19jcHVpbml0IHNlY29uZGFyeV9zdGFydF9rZXJu
ZWwodm9pZCkKIAkgKi8KIAlwZXJjcHVfdGltZXJfc2V0dXAoKTsKIAotCWNhbGlicmF0ZV9kZWxh
eSgpOworCWlmICghc2tpcF9zZWNvbmRhcnlfY2FsaWJyYXRlKQorCQljYWxpYnJhdGVfZGVsYXko
KTsKIAogCXNtcF9zdG9yZV9jcHVfaW5mbyhjcHUpOwogCkBAIC0zMzIsMTQgKzM0NSwxOSBAQCB2
b2lkIF9faW5pdCBzbXBfY3B1c19kb25lKHVuc2lnbmVkIGludCBtYXhfY3B1cykKIAlpbnQgY3B1
OwogCXVuc2lnbmVkIGxvbmcgYm9nb3N1bSA9IDA7CiAKLQlmb3JfZWFjaF9vbmxpbmVfY3B1KGNw
dSkKLQkJYm9nb3N1bSArPSBwZXJfY3B1KGNwdV9kYXRhLCBjcHUpLmxvb3BzX3Blcl9qaWZmeTsK
KwlpZiAoIXNraXBfc2Vjb25kYXJ5X2NhbGlicmF0ZSkgeworCQlmb3JfZWFjaF9vbmxpbmVfY3B1
KGNwdSkKKwkJCWJvZ29zdW0gKz0gcGVyX2NwdShjcHVfZGF0YSwgY3B1KS5sb29wc19wZXJfamlm
Znk7CiAKLQlwcmludGsoS0VSTl9JTkZPICJTTVA6IFRvdGFsIG9mICVkIHByb2Nlc3NvcnMgYWN0
aXZhdGVkICIKLQkgICAgICAgIiglbHUuJTAybHUgQm9nb01JUFMpLlxuIiwKLQkgICAgICAgbnVt
X29ubGluZV9jcHVzKCksCi0JICAgICAgIGJvZ29zdW0gLyAoNTAwMDAwL0haKSwKLQkgICAgICAg
KGJvZ29zdW0gLyAoNTAwMC9IWikpICUgMTAwKTsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiU01QOiBU
b3RhbCBvZiAlZCBwcm9jZXNzb3JzIGFjdGl2YXRlZCAiCisJCSAgICAgICAiKCVsdS4lMDJsdSBC
b2dvTUlQUykuXG4iLAorCQkJbnVtX29ubGluZV9jcHVzKCksCisJCQlib2dvc3VtIC8gKDUwMDAw
MC9IWiksCisJCQkoYm9nb3N1bSAvICg1MDAwL0haKSkgJSAxMDApOworCX0gZWxzZSB7CisJCXBy
aW50ayhLRVJOX0lORk8gIlNNUDogVG90YWwgb2YgJWQgcHJvY2Vzc29ycyBhY3RpdmF0ZWQuXG4i
LAorCQkJbnVtX29ubGluZV9jcHVzKCkpOworCX0KIH0KIAogdm9pZCBfX2luaXQgc21wX3ByZXBh
cmVfYm9vdF9jcHUodm9pZCkKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcC1z
bXAuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcC1zbXAuYwppbmRleCBiNjZjZmU4Li43MzQy
Y2Q1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAtc21wLmMKKysrIGIvYXJj
aC9hcm0vbWFjaC1vbWFwMi9vbWFwLXNtcC5jCkBAIC0zOSw2ICszOSw5IEBAIHZvaWQgX19jcHVp
bml0IHBsYXRmb3JtX3NlY29uZGFyeV9pbml0KHVuc2lnbmVkIGludCBjcHUpCiAJICovCiAJZ2lj
X3NlY29uZGFyeV9pbml0KDApOwogCisJLyogQWxsb3cgdG8gc2tpcCBzZWNvbmRhcnkgQ1BVIGNh
bGlicmF0aW9uICovCisJc2Vjb25kYXJ5X3NraXBfY2FsaWJyYXRlKCk7CisKIAkvKgogCSAqIFN5
bmNocm9uaXNlIHdpdGggdGhlIGJvb3QgdGhyZWFkLgogCSAqLwotLSAKMS42LjAuNAoK
--0016e6d9a271b7ebd0049a5b7037--
