From: Joe Perches <joe@perches.com>
Subject: [PATCH 2/3] cpufreq: Convert printk(KERN_<LEVEL> to pr_<level>
Date: Tue,  5 Apr 2016 13:28:24 -0700
Message-ID: <d85c4c927332ecd07d44990b5cb09280a9889f97.1459887986.git.joe@perches.com>
References: <cover.1459887986.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459887986.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the more common logging style.

Miscellanea:

o Coalesce formats
o Realign arguments
o Add a missing space between a coalesced format

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/cpufreq/acpi-cpufreq.c            | 10 ++--
 drivers/cpufreq/cpufreq-nforce2.c         | 24 ++++------
 drivers/cpufreq/e_powersaver.c            | 60 ++++++++++-------------
 drivers/cpufreq/elanfreq.c                |  2 +-
 drivers/cpufreq/ia64-acpi-cpufreq.c       |  9 ++--
 drivers/cpufreq/longhaul.c                | 80 +++++++++++++------------------
 drivers/cpufreq/loongson2_cpufreq.c       |  2 +-
 drivers/cpufreq/maple-cpufreq.c           |  9 ++--
 drivers/cpufreq/omap-cpufreq.c            |  4 +-
 drivers/cpufreq/p4-clockmod.c             | 15 ++----
 drivers/cpufreq/pmac32-cpufreq.c          | 12 ++---
 drivers/cpufreq/pmac64-cpufreq.c          | 43 ++++++++---------
 drivers/cpufreq/powernow-k6.c             | 13 ++---
 drivers/cpufreq/powernow-k7.c             | 65 ++++++++++---------------
 drivers/cpufreq/pxa2xx-cpufreq.c          |  7 ++-
 drivers/cpufreq/s3c2412-cpufreq.c         | 13 +++--
 drivers/cpufreq/s3c2440-cpufreq.c         |  4 +-
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c |  2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c         | 57 +++++++++++-----------
 drivers/cpufreq/s5pv210-cpufreq.c         |  4 +-
 drivers/cpufreq/sc520_freq.c              |  6 +--
 drivers/cpufreq/speedstep-centrino.c      |  3 +-
 drivers/cpufreq/speedstep-ich.c           |  6 +--
 drivers/cpufreq/speedstep-lib.c           |  9 ++--
 drivers/cpufreq/speedstep-smi.c           |  5 +-
 25 files changed, 199 insertions(+), 265 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7f38fb5..ed9e93d 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -648,10 +648,7 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 		if ((c->x86 == 15) &&
 		    (c->x86_model == 6) &&
 		    (c->x86_mask == 8)) {
-			printk(KERN_INFO "acpi-cpufreq: Intel(R) "
-			    "Xeon(R) 7100 Errata AL30, processors may "
-			    "lock up on frequency changes: disabling "
-			    "acpi-cpufreq.\n");
+			pr_info("acpi-cpufreq: Intel(R) Xeon(R) 7100 Errata AL30, processors may lock up on frequency changes: disabling acpi-cpufreq\n");
 			return -ENODEV;
 		    }
 		}
@@ -799,8 +796,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
 	    policy->cpuinfo.transition_latency > 20 * 1000) {
 		policy->cpuinfo.transition_latency = 20 * 1000;
-		printk_once(KERN_INFO
-			    "P-state transition latency capped at 20 uS\n");
+		pr_info_once("P-state transition latency capped at 20 uS\n");
 	}
 
 	/* table init */
@@ -822,7 +818,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_freqfree;
 
 	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
-		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
+		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index db69eeb..7da96d5 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -174,13 +174,13 @@ static int nforce2_set_fsb(unsigned int fsb)
 	int pll = 0;
 
 	if ((fsb > max_fsb) || (fsb < NFORCE2_MIN_FSB)) {
-		printk(KERN_ERR PFX "FSB %d is out of range!\n", fsb);
+		pr_err(PFX "FSB %d is out of range!\n", fsb);
 		return -EINVAL;
 	}
 
 	tfsb = nforce2_fsb_read(0);
 	if (!tfsb) {
-		printk(KERN_ERR PFX "Error while reading the FSB\n");
+		pr_err(PFX "Error while reading the FSB\n");
 		return -EINVAL;
 	}
 
@@ -276,8 +276,7 @@ static int nforce2_target(struct cpufreq_policy *policy,
 	/* local_irq_save(flags); */
 
 	if (nforce2_set_fsb(target_fsb) < 0)
-		printk(KERN_ERR PFX "Changing FSB to %d failed\n",
-			target_fsb);
+		pr_err(PFX "Changing FSB to %d failed\n", target_fsb);
 	else
 		pr_debug("Changed FSB successfully to %d\n",
 			target_fsb);
@@ -325,8 +324,7 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	/* FIX: Get FID from CPU */
 	if (!fid) {
 		if (!cpu_khz) {
-			printk(KERN_WARNING PFX
-			"cpu_khz not set, can't calculate multiplier!\n");
+			pr_warn(PFX "cpu_khz not set, can't calculate multiplier!\n");
 			return -ENODEV;
 		}
 
@@ -341,8 +339,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 		}
 	}
 
-	printk(KERN_INFO PFX "FSB currently at %i MHz, FID %d.%d\n", fsb,
-	       fid / 10, fid % 10);
+	pr_info(PFX "FSB currently at %i MHz, FID %d.%d\n",
+		fsb, fid / 10, fid % 10);
 
 	/* Set maximum FSB to FSB at boot time */
 	max_fsb = nforce2_fsb_read(1);
@@ -401,11 +399,9 @@ static int nforce2_detect_chipset(void)
 	if (nforce2_dev == NULL)
 		return -ENODEV;
 
-	printk(KERN_INFO PFX "Detected nForce2 chipset revision %X\n",
-	       nforce2_dev->revision);
-	printk(KERN_INFO PFX
-	       "FSB changing is maybe unstable and can lead to "
-	       "crashes and data loss.\n");
+	pr_info(PFX "Detected nForce2 chipset revision %X\n",
+		nforce2_dev->revision);
+	pr_info(PFX "FSB changing is maybe unstable and can lead to crashes and data loss\n");
 
 	return 0;
 }
@@ -423,7 +419,7 @@ static int __init nforce2_init(void)
 
 	/* detect chipset */
 	if (nforce2_detect_chipset()) {
-		printk(KERN_INFO PFX "No nForce2 chipset.\n");
+		pr_info(PFX "No nForce2 chipset\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 4085244c..c420f0c 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -141,11 +141,9 @@ static int eps_set_state(struct eps_cpu_data *centaur,
 	/* Print voltage and multiplier */
 	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
 	current_voltage = lo & 0xff;
-	printk(KERN_INFO "eps: Current voltage = %dmV\n",
-		current_voltage * 16 + 700);
+	pr_info("eps: Current voltage = %dmV\n", current_voltage * 16 + 700);
 	current_multiplier = (lo >> 8) & 0xff;
-	printk(KERN_INFO "eps: Current multiplier = %d\n",
-		current_multiplier);
+	pr_info("eps: Current multiplier = %d\n", current_multiplier);
 	}
 #endif
 	return 0;
@@ -166,7 +164,7 @@ static int eps_target(struct cpufreq_policy *policy, unsigned int index)
 	dest_state = centaur->freq_table[index].driver_data & 0xffff;
 	ret = eps_set_state(centaur, policy, dest_state);
 	if (ret)
-		printk(KERN_ERR "eps: Timeout!\n");
+		pr_err("eps: Timeout!\n");
 	return ret;
 }
 
@@ -194,36 +192,36 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 
 	/* Check brand */
-	printk(KERN_INFO "eps: Detected VIA ");
+	pr_info("eps: Detected VIA ");
 
 	switch (c->x86_model) {
 	case 10:
 		rdmsr(0x1153, lo, hi);
 		brand = (((lo >> 2) ^ lo) >> 18) & 3;
-		printk(KERN_CONT "Model A ");
+		pr_cont("Model A ");
 		break;
 	case 13:
 		rdmsr(0x1154, lo, hi);
 		brand = (((lo >> 4) ^ (lo >> 2))) & 0x000000ff;
-		printk(KERN_CONT "Model D ");
+		pr_cont("Model D ");
 		break;
 	}
 
 	switch (brand) {
 	case EPS_BRAND_C7M:
-		printk(KERN_CONT "C7-M\n");
+		pr_cont("C7-M\n");
 		break;
 	case EPS_BRAND_C7:
-		printk(KERN_CONT "C7\n");
+		pr_cont("C7\n");
 		break;
 	case EPS_BRAND_EDEN:
-		printk(KERN_CONT "Eden\n");
+		pr_cont("Eden\n");
 		break;
 	case EPS_BRAND_C7D:
-		printk(KERN_CONT "C7-D\n");
+		pr_cont("C7-D\n");
 		break;
 	case EPS_BRAND_C3:
-		printk(KERN_CONT "C3\n");
+		pr_cont("C3\n");
 		return -ENODEV;
 		break;
 	}
@@ -235,7 +233,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		/* Can be locked at 0 */
 		rdmsrl(MSR_IA32_MISC_ENABLE, val);
 		if (!(val & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
-			printk(KERN_INFO "eps: Can't enable Enhanced PowerSaver\n");
+			pr_info("eps: Can't enable Enhanced PowerSaver\n");
 			return -ENODEV;
 		}
 	}
@@ -243,22 +241,19 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	/* Print voltage and multiplier */
 	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
 	current_voltage = lo & 0xff;
-	printk(KERN_INFO "eps: Current voltage = %dmV\n",
-			current_voltage * 16 + 700);
+	pr_info("eps: Current voltage = %dmV\n", current_voltage * 16 + 700);
 	current_multiplier = (lo >> 8) & 0xff;
-	printk(KERN_INFO "eps: Current multiplier = %d\n", current_multiplier);
+	pr_info("eps: Current multiplier = %d\n", current_multiplier);
 
 	/* Print limits */
 	max_voltage = hi & 0xff;
-	printk(KERN_INFO "eps: Highest voltage = %dmV\n",
-			max_voltage * 16 + 700);
+	pr_info("eps: Highest voltage = %dmV\n", max_voltage * 16 + 700);
 	max_multiplier = (hi >> 8) & 0xff;
-	printk(KERN_INFO "eps: Highest multiplier = %d\n", max_multiplier);
+	pr_info("eps: Highest multiplier = %d\n", max_multiplier);
 	min_voltage = (hi >> 16) & 0xff;
-	printk(KERN_INFO "eps: Lowest voltage = %dmV\n",
-			min_voltage * 16 + 700);
+	pr_info("eps: Lowest voltage = %dmV\n", min_voltage * 16 + 700);
 	min_multiplier = (hi >> 24) & 0xff;
-	printk(KERN_INFO "eps: Lowest multiplier = %d\n", min_multiplier);
+	pr_info("eps: Lowest multiplier = %d\n", min_multiplier);
 
 	/* Sanity checks */
 	if (current_multiplier == 0 || max_multiplier == 0
@@ -276,17 +271,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 
 	/* Check for systems using underclocked CPU */
 	if (!freq_failsafe_off && max_multiplier != current_multiplier) {
-		printk(KERN_INFO "eps: Your processor is running at different "
-			"frequency then its maximum. Aborting.\n");
-		printk(KERN_INFO "eps: You can use freq_failsafe_off option "
-			"to disable this check.\n");
+		pr_info("eps: Your processor is running at different frequency then its maximum. Aborting.\n");
+		pr_info("eps: You can use freq_failsafe_off option to disable this check.\n");
 		return -EINVAL;
 	}
 	if (!voltage_failsafe_off && max_voltage != current_voltage) {
-		printk(KERN_INFO "eps: Your processor is running at different "
-			"voltage then its maximum. Aborting.\n");
-		printk(KERN_INFO "eps: You can use voltage_failsafe_off "
-			"option to disable this check.\n");
+		pr_info("eps: Your processor is running at different voltage then its maximum. Aborting.\n");
+		pr_info("eps: You can use voltage_failsafe_off option to disable this check.\n");
 		return -EINVAL;
 	}
 
@@ -297,13 +288,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	/* Check for ACPI processor speed limit */
 	if (!ignore_acpi_limit && !eps_acpi_init()) {
 		if (!acpi_processor_get_bios_limit(policy->cpu, &limit)) {
-			printk(KERN_INFO "eps: ACPI limit %u.%uGHz\n",
+			pr_info("eps: ACPI limit %u.%uGHz\n",
 				limit/1000000,
 				(limit%1000000)/10000);
 			eps_acpi_exit(policy);
 			/* Check if max_multiplier is in BIOS limits */
 			if (limit && max_multiplier * fsb > limit) {
-				printk(KERN_INFO "eps: Aborting.\n");
+				pr_info("eps: Aborting\n");
 				return -EINVAL;
 			}
 		}
@@ -319,8 +310,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		v = (set_max_voltage - 700) / 16;
 		/* Check if voltage is within limits */
 		if (v >= min_voltage && v <= max_voltage) {
-			printk(KERN_INFO "eps: Setting %dmV as maximum.\n",
-				v * 16 + 700);
+			pr_info("eps: Setting %dmV as maximum\n", v * 16 + 700);
 			max_voltage = v;
 		}
 	}
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 1c06e78..8f4dded 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -185,7 +185,7 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 static int __init elanfreq_setup(char *str)
 {
 	max_freq = simple_strtoul(str, &str, 0);
-	printk(KERN_WARNING "You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
+	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
 	return 1;
 }
 __setup("elanfreq=", elanfreq_setup);
diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 0202429..fd36d6c 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -118,8 +118,7 @@ processor_get_freq (
 
 	if (ret) {
 		set_cpus_allowed_ptr(current, &saved_mask);
-		printk(KERN_WARNING "get performance failed with error %d\n",
-		       ret);
+		pr_warn("get performance failed with error %d\n", ret);
 		ret = 0;
 		goto migrate_end;
 	}
@@ -177,7 +176,7 @@ processor_set_freq (
 
 	ret = processor_set_pstate(value);
 	if (ret) {
-		printk(KERN_WARNING "Transition failed with error %d\n", ret);
+		pr_warn("Transition failed with error %d\n", ret);
 		retval = -ENODEV;
 		goto migrate_end;
 	}
@@ -291,8 +290,8 @@ acpi_cpufreq_cpu_init (
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
 
-	printk(KERN_INFO "acpi-cpufreq: CPU%u - ACPI performance management "
-	       "activated.\n", cpu);
+	pr_info("acpi-cpufreq: CPU%u - ACPI performance management activated\n",
+		cpu);
 
 	for (i = 0; i < data->acpi_data.state_count; i++)
 		pr_debug("     %cP%d: %d MHz, %d mW, %d uS, %d uS, 0x%x 0x%x\n",
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 0f6b229..2baeb8c 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -347,14 +347,13 @@ retry_loop:
 	freqs.new = calc_speed(longhaul_get_cpu_mult());
 	/* Check if requested frequency is set. */
 	if (unlikely(freqs.new != speed)) {
-		printk(KERN_INFO PFX "Failed to set requested frequency!\n");
+		pr_info(PFX "Failed to set requested frequency!\n");
 		/* Revision ID = 1 but processor is expecting revision key
 		 * equal to 0. Jumpers at the bottom of processor will change
 		 * multiplier and FSB, but will not change bits in Longhaul
 		 * MSR nor enable voltage scaling. */
 		if (!revid_errata) {
-			printk(KERN_INFO PFX "Enabling \"Ignore Revision ID\" "
-						"option.\n");
+			pr_info(PFX "Enabling \"Ignore Revision ID\" option\n");
 			revid_errata = 1;
 			msleep(200);
 			goto retry_loop;
@@ -364,11 +363,10 @@ retry_loop:
 		 * but it doesn't change frequency. I tried poking various
 		 * bits in northbridge registers, but without success. */
 		if (longhaul_flags & USE_ACPI_C3) {
-			printk(KERN_INFO PFX "Disabling ACPI C3 support.\n");
+			pr_info(PFX "Disabling ACPI C3 support\n");
 			longhaul_flags &= ~USE_ACPI_C3;
 			if (revid_errata) {
-				printk(KERN_INFO PFX "Disabling \"Ignore "
-						"Revision ID\" option.\n");
+				pr_info(PFX "Disabling \"Ignore Revision ID\" option\n");
 				revid_errata = 0;
 			}
 			msleep(200);
@@ -379,7 +377,7 @@ retry_loop:
 		 * RevID = 1. RevID errata will make things right. Just
 		 * to be 100% sure. */
 		if (longhaul_version == TYPE_LONGHAUL_V2) {
-			printk(KERN_INFO PFX "Switching to Longhaul ver. 1\n");
+			pr_info(PFX "Switching to Longhaul ver. 1\n");
 			longhaul_version = TYPE_LONGHAUL_V1;
 			msleep(200);
 			goto retry_loop;
@@ -387,8 +385,7 @@ retry_loop:
 	}
 
 	if (!bm_timeout) {
-		printk(KERN_INFO PFX "Warning: Timeout while waiting for "
-				"idle PCI bus.\n");
+		pr_info(PFX "Warning: Timeout while waiting for idle PCI bus\n");
 		return -EBUSY;
 	}
 
@@ -433,12 +430,12 @@ static int longhaul_get_ranges(void)
 	/* Get current frequency */
 	mult = longhaul_get_cpu_mult();
 	if (mult == -1) {
-		printk(KERN_INFO PFX "Invalid (reserved) multiplier!\n");
+		pr_info(PFX "Invalid (reserved) multiplier!\n");
 		return -EINVAL;
 	}
 	fsb = guess_fsb(mult);
 	if (fsb == 0) {
-		printk(KERN_INFO PFX "Invalid (reserved) FSB!\n");
+		pr_info(PFX "Invalid (reserved) FSB!\n");
 		return -EINVAL;
 	}
 	/* Get max multiplier - as we always did.
@@ -468,11 +465,11 @@ static int longhaul_get_ranges(void)
 		 print_speed(highest_speed/1000));
 
 	if (lowest_speed == highest_speed) {
-		printk(KERN_INFO PFX "highestspeed == lowest, aborting.\n");
+		pr_info(PFX "highestspeed == lowest, aborting\n");
 		return -EINVAL;
 	}
 	if (lowest_speed > highest_speed) {
-		printk(KERN_INFO PFX "nonsense! lowest (%d > %d) !\n",
+		pr_info(PFX "nonsense! lowest (%d > %d) !\n",
 			lowest_speed, highest_speed);
 		return -EINVAL;
 	}
@@ -538,16 +535,16 @@ static void longhaul_setup_voltagescaling(void)
 
 	rdmsrl(MSR_VIA_LONGHAUL, longhaul.val);
 	if (!(longhaul.bits.RevisionID & 1)) {
-		printk(KERN_INFO PFX "Voltage scaling not supported by CPU.\n");
+		pr_info(PFX "Voltage scaling not supported by CPU\n");
 		return;
 	}
 
 	if (!longhaul.bits.VRMRev) {
-		printk(KERN_INFO PFX "VRM 8.5\n");
+		pr_info(PFX "VRM 8.5\n");
 		vrm_mV_table = &vrm85_mV[0];
 		mV_vrm_table = &mV_vrm85[0];
 	} else {
-		printk(KERN_INFO PFX "Mobile VRM\n");
+		pr_info(PFX "Mobile VRM\n");
 		if (cpu_model < CPU_NEHEMIAH)
 			return;
 		vrm_mV_table = &mobilevrm_mV[0];
@@ -558,27 +555,21 @@ static void longhaul_setup_voltagescaling(void)
 	maxvid = vrm_mV_table[longhaul.bits.MaximumVID];
 
 	if (minvid.mV == 0 || maxvid.mV == 0 || minvid.mV > maxvid.mV) {
-		printk(KERN_INFO PFX "Bogus values Min:%d.%03d Max:%d.%03d. "
-					"Voltage scaling disabled.\n",
-					minvid.mV/1000, minvid.mV%1000,
-					maxvid.mV/1000, maxvid.mV%1000);
+		pr_info(PFX "Bogus values Min:%d.%03d Max:%d.%03d - Voltage scaling disabled\n",
+			minvid.mV/1000, minvid.mV%1000,
+			maxvid.mV/1000, maxvid.mV%1000);
 		return;
 	}
 
 	if (minvid.mV == maxvid.mV) {
-		printk(KERN_INFO PFX "Claims to support voltage scaling but "
-				"min & max are both %d.%03d. "
-				"Voltage scaling disabled\n",
-				maxvid.mV/1000, maxvid.mV%1000);
+		pr_info(PFX "Claims to support voltage scaling but min & max are both %d.%03d - Voltage scaling disabled\n",
+			maxvid.mV/1000, maxvid.mV%1000);
 		return;
 	}
 
 	/* How many voltage steps*/
 	numvscales = maxvid.pos - minvid.pos + 1;
-	printk(KERN_INFO PFX
-		"Max VID=%d.%03d  "
-		"Min VID=%d.%03d, "
-		"%d possible voltage scales\n",
+	pr_info(PFX "Max VID=%d.%03d  Min VID=%d.%03d, %d possible voltage scales\n",
 		maxvid.mV/1000, maxvid.mV%1000,
 		minvid.mV/1000, minvid.mV%1000,
 		numvscales);
@@ -617,12 +608,12 @@ static void longhaul_setup_voltagescaling(void)
 			pos = minvid.pos;
 		freq_pos->driver_data |= mV_vrm_table[pos] << 8;
 		vid = vrm_mV_table[mV_vrm_table[pos]];
-		printk(KERN_INFO PFX "f: %d kHz, index: %d, vid: %d mV\n",
+		pr_info(PFX "f: %d kHz, index: %d, vid: %d mV\n",
 			speed, (int)(freq_pos - longhaul_table), vid.mV);
 	}
 
 	can_scale_voltage = 1;
-	printk(KERN_INFO PFX "Voltage scaling enabled.\n");
+	pr_info(PFX "Voltage scaling enabled\n");
 }
 
 
@@ -720,8 +711,7 @@ static int enable_arbiter_disable(void)
 			pci_write_config_byte(dev, reg, pci_cmd);
 			pci_read_config_byte(dev, reg, &pci_cmd);
 			if (!(pci_cmd & 1<<7)) {
-				printk(KERN_ERR PFX
-					"Can't enable access to port 0x22.\n");
+				pr_err(PFX "Can't enable access to port 0x22\n");
 				status = 0;
 			}
 		}
@@ -758,8 +748,7 @@ static int longhaul_setup_southbridge(void)
 		if (pci_cmd & 1 << 7) {
 			pci_read_config_dword(dev, 0x88, &acpi_regs_addr);
 			acpi_regs_addr &= 0xff00;
-			printk(KERN_INFO PFX "ACPI I/O at 0x%x\n",
-					acpi_regs_addr);
+			pr_info(PFX "ACPI I/O at 0x%x\n", acpi_regs_addr);
 		}
 
 		pci_dev_put(dev);
@@ -853,14 +842,14 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 			longhaul_version = TYPE_LONGHAUL_V1;
 	}
 
-	printk(KERN_INFO PFX "VIA %s CPU detected.  ", cpuname);
+	pr_info(PFX "VIA %s CPU detected.  ", cpuname);
 	switch (longhaul_version) {
 	case TYPE_LONGHAUL_V1:
 	case TYPE_LONGHAUL_V2:
-		printk(KERN_CONT "Longhaul v%d supported.\n", longhaul_version);
+		pr_cont("Longhaul v%d supported\n", longhaul_version);
 		break;
 	case TYPE_POWERSAVER:
-		printk(KERN_CONT "Powersaver supported.\n");
+		pr_cont("Powersaver supported\n");
 		break;
 	};
 
@@ -889,15 +878,14 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	if (!(longhaul_flags & USE_ACPI_C3
 	     || longhaul_flags & USE_NORTHBRIDGE)
 	    && ((pr == NULL) || !(pr->flags.bm_control))) {
-		printk(KERN_ERR PFX
-			"No ACPI support. Unsupported northbridge.\n");
+		pr_err(PFX "No ACPI support: Unsupported northbridge\n");
 		return -ENODEV;
 	}
 
 	if (longhaul_flags & USE_NORTHBRIDGE)
-		printk(KERN_INFO PFX "Using northbridge support.\n");
+		pr_info(PFX "Using northbridge support\n");
 	if (longhaul_flags & USE_ACPI_C3)
-		printk(KERN_INFO PFX "Using ACPI support.\n");
+		pr_info(PFX "Using ACPI support\n");
 
 	ret = longhaul_get_ranges();
 	if (ret != 0)
@@ -934,20 +922,18 @@ static int __init longhaul_init(void)
 		return -ENODEV;
 
 	if (!enable) {
-		printk(KERN_ERR PFX "Option \"enable\" not set. Aborting.\n");
+		pr_err(PFX "Option \"enable\" not set - Aborting\n");
 		return -ENODEV;
 	}
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > 1) {
-		printk(KERN_ERR PFX "More than 1 CPU detected, "
-				"longhaul disabled.\n");
+		pr_err(PFX "More than 1 CPU detected, longhaul disabled\n");
 		return -ENODEV;
 	}
 #endif
 #ifdef CONFIG_X86_IO_APIC
 	if (cpu_has_apic) {
-		printk(KERN_ERR PFX "APIC detected. Longhaul is currently "
-				"broken in this configuration.\n");
+		pr_err(PFX "APIC detected. Longhaul is currently broken in this configuration.\n");
 		return -ENODEV;
 	}
 #endif
@@ -955,7 +941,7 @@ static int __init longhaul_init(void)
 	case 6 ... 9:
 		return cpufreq_register_driver(&longhaul_driver);
 	case 10:
-		printk(KERN_ERR PFX "Use acpi-cpufreq driver for VIA C7\n");
+		pr_err(PFX "Use acpi-cpufreq driver for VIA C7\n");
 	default:
 		;
 	}
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index cd593c1..93c7928 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -76,7 +76,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpuclk = clk_get(NULL, "cpu_clk");
 	if (IS_ERR(cpuclk)) {
-		printk(KERN_ERR "cpufreq: couldn't get CPU clk\n");
+		pr_err("cpufreq: couldn't get CPU clk\n");
 		return PTR_ERR(cpuclk);
 	}
 
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index cc3408f..7e55632 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -174,7 +174,7 @@ static int __init maple_cpufreq_init(void)
 	/* Get first CPU node */
 	cpunode = of_cpu_device_node_get(0);
 	if (cpunode == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
+		pr_err("cpufreq: Can't find any CPU 0 node\n");
 		goto bail_noprops;
 	}
 
@@ -182,8 +182,7 @@ static int __init maple_cpufreq_init(void)
 	/* we actually don't care on which CPU to access PVR */
 	pvr_hi = PVR_VER(mfspr(SPRN_PVR));
 	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
-		printk(KERN_ERR "cpufreq: Unsupported CPU version (%x)\n",
-				pvr_hi);
+		pr_err("cpufreq: Unsupported CPU version (%x)\n", pvr_hi);
 		goto bail_noprops;
 	}
 
@@ -222,8 +221,8 @@ static int __init maple_cpufreq_init(void)
 	maple_pmode_cur = -1;
 	maple_scom_switch_freq(maple_scom_query_freq());
 
-	printk(KERN_INFO "Registering Maple CPU frequency driver\n");
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
+	pr_info("Registering Maple CPU frequency driver\n");
+	pr_info("Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
 		maple_cpu_freqs[1].frequency/1000,
 		maple_cpu_freqs[0].frequency/1000,
 		maple_cpu_freqs[maple_pmode_cur].frequency/1000);
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index e3866e0..655fc94 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -163,13 +163,13 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
 {
 	mpu_dev = get_cpu_device(0);
 	if (!mpu_dev) {
-		pr_warning("%s: unable to get the mpu device\n", __func__);
+		pr_warn("%s: unable to get the mpu device\n", __func__);
 		return -EINVAL;
 	}
 
 	mpu_reg = regulator_get(mpu_dev, "vcc");
 	if (IS_ERR(mpu_reg)) {
-		pr_warning("%s: unable to get MPU regulator\n", __func__);
+		pr_warn("%s: unable to get MPU regulator\n", __func__);
 		mpu_reg = NULL;
 	} else {
 		/* 
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 5dd95da..4d1a443 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -124,11 +124,7 @@ static unsigned int cpufreq_p4_get_frequency(struct cpuinfo_x86 *c)
 {
 	if (c->x86 == 0x06) {
 		if (cpu_has(c, X86_FEATURE_EST))
-			printk_once(KERN_WARNING PFX "Warning: EST-capable "
-			       "CPU detected. The acpi-cpufreq module offers "
-			       "voltage scaling in addition to frequency "
-			       "scaling. You should use that instead of "
-			       "p4-clockmod, if possible.\n");
+			pr_warn_once(PFX "Warning: EST-capable CPU detected. The acpi-cpufreq module offers voltage scaling in addition to frequency scaling. You should use that instead of p4-clockmod, if possible.\n");
 		switch (c->x86_model) {
 		case 0x0E: /* Core */
 		case 0x0F: /* Core Duo */
@@ -152,11 +148,7 @@ static unsigned int cpufreq_p4_get_frequency(struct cpuinfo_x86 *c)
 	p4clockmod_driver.flags |= CPUFREQ_CONST_LOOPS;
 
 	if (speedstep_detect_processor() == SPEEDSTEP_CPU_P4M) {
-		printk(KERN_WARNING PFX "Warning: Pentium 4-M detected. "
-		       "The speedstep-ich or acpi cpufreq modules offer "
-		       "voltage scaling in addition of frequency scaling. "
-		       "You should use either one instead of p4-clockmod, "
-		       "if possible.\n");
+		pr_warn(PFX "Warning: Pentium 4-M detected. The speedstep-ich or acpi cpufreq modules offer voltage scaling in addition of frequency scaling. You should use either one instead of p4-clockmod, if possible.\n");
 		return speedstep_get_frequency(SPEEDSTEP_CPU_P4M);
 	}
 
@@ -265,8 +257,7 @@ static int __init cpufreq_p4_init(void)
 
 	ret = cpufreq_register_driver(&p4clockmod_driver);
 	if (!ret)
-		printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock "
-				"Modulation available\n");
+		pr_info(PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
 
 	return ret;
 }
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 1f49d97..072d7b3 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -481,13 +481,13 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 		freqs = of_get_property(cpunode, "bus-frequencies", &lenp);
 		lenp /= sizeof(u32);
 		if (freqs == NULL || lenp != 2) {
-			printk(KERN_ERR "cpufreq: bus-frequencies incorrect or missing\n");
+			pr_err("cpufreq: bus-frequencies incorrect or missing\n");
 			return 1;
 		}
 		ratio = of_get_property(cpunode, "processor-to-bus-ratio*2",
 						NULL);
 		if (ratio == NULL) {
-			printk(KERN_ERR "cpufreq: processor-to-bus-ratio*2 missing\n");
+			pr_err("cpufreq: processor-to-bus-ratio*2 missing\n");
 			return 1;
 		}
 
@@ -550,7 +550,7 @@ static int pmac_cpufreq_init_7447A(struct device_node *cpunode)
 	if (volt_gpio_np)
 		voltage_gpio = read_gpio(volt_gpio_np);
 	if (!voltage_gpio){
-		printk(KERN_ERR "cpufreq: missing cpu-vcore-select gpio\n");
+		pr_err("cpufreq: missing cpu-vcore-select gpio\n");
 		return 1;
 	}
 
@@ -675,9 +675,9 @@ out:
 	pmac_cpu_freqs[CPUFREQ_HIGH].frequency = hi_freq;
 	ppc_proc_freq = cur_freq * 1000ul;
 
-	printk(KERN_INFO "Registering PowerMac CPU frequency driver\n");
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Boot: %d Mhz\n",
-	       low_freq/1000, hi_freq/1000, cur_freq/1000);
+	pr_info("Registering PowerMac CPU frequency driver\n");
+	pr_info("Low: %d Mhz, High: %d Mhz, Boot: %d Mhz\n",
+		low_freq/1000, hi_freq/1000, cur_freq/1000);
 
 	return cpufreq_register_driver(&pmac_cpufreq_driver);
 }
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 4ff8687..5ffe085 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -138,7 +138,7 @@ static void g5_vdnap_switch_volt(int speed_mode)
 		usleep_range(1000, 1000);
 	}
 	if (done == 0)
-		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
+		pr_warn("cpufreq: Timeout in clock slewing !\n");
 }
 
 
@@ -266,7 +266,7 @@ static int g5_pfunc_switch_freq(int speed_mode)
 		rc = pmf_call_one(pfunc_cpu_setfreq_low, NULL);
 
 	if (rc)
-		printk(KERN_WARNING "cpufreq: pfunc switch error %d\n", rc);
+		pr_warn("cpufreq: pfunc switch error %d\n", rc);
 
 	/* It's an irq GPIO so we should be able to just block here,
 	 * I'll do that later after I've properly tested the IRQ code for
@@ -282,7 +282,7 @@ static int g5_pfunc_switch_freq(int speed_mode)
 		usleep_range(500, 500);
 	}
 	if (done == 0)
-		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
+		pr_warn("cpufreq: Timeout in clock slewing !\n");
 
 	/* If frequency is going down, last ramp the voltage */
 	if (speed_mode > g5_pmode_cur)
@@ -368,7 +368,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 	}
 	pvr_hi = (*valp) >> 16;
 	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
-		printk(KERN_ERR "cpufreq: Unsupported CPU version\n");
+		pr_err("cpufreq: Unsupported CPU version\n");
 		goto bail_noprops;
 	}
 
@@ -403,8 +403,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 
 		root = of_find_node_by_path("/");
 		if (root == NULL) {
-			printk(KERN_ERR "cpufreq: Can't find root of "
-			       "device tree\n");
+			pr_err("cpufreq: Can't find root of device tree\n");
 			goto bail_noprops;
 		}
 		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
@@ -412,8 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 			pmf_find_function(root, "slewing-done");
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
-			printk(KERN_ERR "cpufreq: Can't find required "
-			       "platform function\n");
+			pr_err("cpufreq: Can't find required platform function\n");
 			goto bail_noprops;
 		}
 
@@ -453,10 +451,10 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 	g5_pmode_cur = -1;
 	g5_switch_freq(g5_query_freq());
 
-	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
-	printk(KERN_INFO "Frequency method: %s, Voltage method: %s\n",
-	       freq_method, volt_method);
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
+	pr_info("Registering G5 CPU frequency driver\n");
+	pr_info("Frequency method: %s, Voltage method: %s\n",
+		freq_method, volt_method);
+	pr_info("Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
 		g5_cpu_freqs[1].frequency/1000,
 		g5_cpu_freqs[0].frequency/1000,
 		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
@@ -493,7 +491,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 	if (cpuid != NULL)
 		eeprom = of_get_property(cpuid, "cpuid", NULL);
 	if (eeprom == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find cpuid EEPROM !\n");
+		pr_err("cpufreq: Can't find cpuid EEPROM !\n");
 		rc = -ENODEV;
 		goto bail;
 	}
@@ -511,7 +509,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 		break;
 	}
 	if (hwclock == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find i2c clock chip !\n");
+		pr_err("cpufreq: Can't find i2c clock chip !\n");
 		rc = -ENODEV;
 		goto bail;
 	}
@@ -539,7 +537,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 	/* Check we have minimum requirements */
 	if (pfunc_cpu_getfreq == NULL || pfunc_cpu_setfreq_high == NULL ||
 	    pfunc_cpu_setfreq_low == NULL || pfunc_slewing_done == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find platform functions !\n");
+		pr_err("cpufreq: Can't find platform functions !\n");
 		rc = -ENODEV;
 		goto bail;
 	}
@@ -567,7 +565,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 	/* Get max frequency from device-tree */
 	valp = of_get_property(cpunode, "clock-frequency", NULL);
 	if (!valp) {
-		printk(KERN_ERR "cpufreq: Can't find CPU frequency !\n");
+		pr_err("cpufreq: Can't find CPU frequency !\n");
 		rc = -ENODEV;
 		goto bail;
 	}
@@ -583,8 +581,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 
 	/* Check for machines with no useful settings */
 	if (il == ih) {
-		printk(KERN_WARNING "cpufreq: No low frequency mode available"
-		       " on this model !\n");
+		pr_warn("cpufreq: No low frequency mode available on this model !\n");
 		rc = -ENODEV;
 		goto bail;
 	}
@@ -595,7 +592,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 
 	/* Sanity check */
 	if (min_freq >= max_freq || min_freq < 1000) {
-		printk(KERN_ERR "cpufreq: Can't calculate low frequency !\n");
+		pr_err("cpufreq: Can't calculate low frequency !\n");
 		rc = -ENXIO;
 		goto bail;
 	}
@@ -619,10 +616,10 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 	g5_pmode_cur = -1;
 	g5_switch_freq(g5_query_freq());
 
-	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
-	printk(KERN_INFO "Frequency method: i2c/pfunc, "
-	       "Voltage method: %s\n", has_volt ? "i2c/pfunc" : "none");
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
+	pr_info("Registering G5 CPU frequency driver\n");
+	pr_info("Frequency method: i2c/pfunc, Voltage method: %s\n",
+		has_volt ? "i2c/pfunc" : "none");
+	pr_info("Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
 		g5_cpu_freqs[1].frequency/1000,
 		g5_cpu_freqs[0].frequency/1000,
 		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index e6f24b2..981f40b 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -141,7 +141,7 @@ static int powernow_k6_target(struct cpufreq_policy *policy,
 {
 
 	if (clock_ratio[best_i].driver_data > max_multiplier) {
-		printk(KERN_ERR PFX "invalid target frequency\n");
+		pr_err(PFX "invalid target frequency\n");
 		return -EINVAL;
 	}
 
@@ -175,13 +175,14 @@ static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 				max_multiplier = param_max_multiplier;
 				goto have_max_multiplier;
 			}
-		printk(KERN_ERR "powernow-k6: invalid max_multiplier parameter, valid parameters 20, 30, 35, 40, 45, 50, 55, 60\n");
+		pr_err("powernow-k6: invalid max_multiplier parameter, valid parameters 20, 30, 35, 40, 45, 50, 55, 60\n");
 		return -EINVAL;
 	}
 
 	if (!max_multiplier) {
-		printk(KERN_WARNING "powernow-k6: unknown frequency %u, cannot determine current multiplier\n", khz);
-		printk(KERN_WARNING "powernow-k6: use module parameters max_multiplier and bus_frequency\n");
+		pr_warn("powernow-k6: unknown frequency %u, cannot determine current multiplier\n",
+			khz);
+		pr_warn("powernow-k6: use module parameters max_multiplier and bus_frequency\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -193,7 +194,7 @@ have_max_multiplier:
 			busfreq = param_busfreq / 10;
 			goto have_busfreq;
 		}
-		printk(KERN_ERR "powernow-k6: invalid bus_frequency parameter, allowed range 50000 - 150000 kHz\n");
+		pr_err("powernow-k6: invalid bus_frequency parameter, allowed range 50000 - 150000 kHz\n");
 		return -EINVAL;
 	}
 
@@ -275,7 +276,7 @@ static int __init powernow_k6_init(void)
 		return -ENODEV;
 
 	if (!request_region(POWERNOW_IOPORT, 16, "PowerNow!")) {
-		printk(KERN_INFO PFX "PowerNow IOPORT region already used.\n");
+		pr_info(PFX "PowerNow IOPORT region already used\n");
 		return -EIO;
 	}
 
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index c1ae199..4a1b420 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -127,14 +127,13 @@ static int check_powernow(void)
 	maxei = cpuid_eax(0x80000000);
 	if (maxei < 0x80000007) {	/* Any powernow info ? */
 #ifdef MODULE
-		printk(KERN_INFO PFX "No powernow capabilities detected\n");
+		pr_info(PFX "No powernow capabilities detected\n");
 #endif
 		return 0;
 	}
 
 	if ((c->x86_model == 6) && (c->x86_mask == 0)) {
-		printk(KERN_INFO PFX "K7 660[A0] core detected, "
-				"enabling errata workarounds\n");
+		pr_info(PFX "K7 660[A0] core detected, enabling errata workarounds\n");
 		have_a0 = 1;
 	}
 
@@ -144,22 +143,22 @@ static int check_powernow(void)
 	if (!(edx & (1 << 1 | 1 << 2)))
 		return 0;
 
-	printk(KERN_INFO PFX "PowerNOW! Technology present. Can scale: ");
+	pr_info(PFX "PowerNOW! Technology present. Can scale: ");
 
 	if (edx & 1 << 1) {
-		printk("frequency");
+		pr_cont("frequency");
 		can_scale_bus = 1;
 	}
 
 	if ((edx & (1 << 1 | 1 << 2)) == 0x6)
-		printk(" and ");
+		pr_cont(" and ");
 
 	if (edx & 1 << 2) {
-		printk("voltage");
+		pr_cont("voltage");
 		can_scale_vid = 1;
 	}
 
-	printk(".\n");
+	pr_cont("\n");
 	return 1;
 }
 
@@ -427,16 +426,14 @@ err1:
 err05:
 	kfree(acpi_processor_perf);
 err0:
-	printk(KERN_WARNING PFX "ACPI perflib can not be used on "
-			"this platform\n");
+	pr_warn(PFX "ACPI perflib can not be used on this platform\n");
 	acpi_processor_perf = NULL;
 	return retval;
 }
 #else
 static int powernow_acpi_init(void)
 {
-	printk(KERN_INFO PFX "no support for ACPI processor found."
-	       "  Please recompile your kernel with ACPI processor\n");
+	pr_info(PFX "no support for ACPI processor found - please recompile your kernel with ACPI processor\n");
 	return -EINVAL;
 }
 #endif
@@ -468,8 +465,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
 			psb = (struct psb_s *) p;
 			pr_debug("Table version: 0x%x\n", psb->tableversion);
 			if (psb->tableversion != 0x12) {
-				printk(KERN_INFO PFX "Sorry, only v1.2 tables"
-						" supported right now\n");
+				pr_info(PFX "Sorry, only v1.2 tables supported right now\n");
 				return -ENODEV;
 			}
 
@@ -481,10 +477,8 @@ static int powernow_decode_bios(int maxfid, int startvid)
 
 			latency = psb->settlingtime;
 			if (latency < 100) {
-				printk(KERN_INFO PFX "BIOS set settling time "
-						"to %d microseconds. "
-						"Should be at least 100. "
-						"Correcting.\n", latency);
+				pr_info(PFX "BIOS set settling time to %d microseconds. Should be at least 100. Correcting.\n",
+					latency);
 				latency = 100;
 			}
 			pr_debug("Settling Time: %d microseconds.\n",
@@ -516,10 +510,9 @@ static int powernow_decode_bios(int maxfid, int startvid)
 						p += 2;
 				}
 			}
-			printk(KERN_INFO PFX "No PST tables match this cpuid "
-					"(0x%x)\n", etuple);
-			printk(KERN_INFO PFX "This is indicative of a broken "
-					"BIOS.\n");
+			pr_info(PFX "No PST tables match this cpuid (0x%x)\n",
+				etuple);
+			pr_info(PFX "This is indicative of a broken BIOS\n");
 
 			return -EINVAL;
 		}
@@ -552,7 +545,7 @@ static int fixup_sgtc(void)
 	sgtc = 100 * m * latency;
 	sgtc = sgtc / 3;
 	if (sgtc > 0xfffff) {
-		printk(KERN_WARNING PFX "SGTC too large %d\n", sgtc);
+		pr_warn(PFX "SGTC too large %d\n", sgtc);
 		sgtc = 0xfffff;
 	}
 	return sgtc;
@@ -574,14 +567,10 @@ static unsigned int powernow_get(unsigned int cpu)
 
 static int acer_cpufreq_pst(const struct dmi_system_id *d)
 {
-	printk(KERN_WARNING PFX
-		"%s laptop with broken PST tables in BIOS detected.\n",
+	pr_warn(PFX "%s laptop with broken PST tables in BIOS detected\n",
 		d->ident);
-	printk(KERN_WARNING PFX
-		"You need to downgrade to 3A21 (09/09/2002), or try a newer "
-		"BIOS than 3A71 (01/20/2003)\n");
-	printk(KERN_WARNING PFX
-		"cpufreq scaling has been disabled as a result of this.\n");
+	pr_warn(PFX "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
+	pr_warn(PFX "cpufreq scaling has been disabled as a result of this\n");
 	return 0;
 }
 
@@ -616,40 +605,38 @@ static int powernow_cpu_init(struct cpufreq_policy *policy)
 
 	fsb = (10 * cpu_khz) / fid_codes[fidvidstatus.bits.CFID];
 	if (!fsb) {
-		printk(KERN_WARNING PFX "can not determine bus frequency\n");
+		pr_warn(PFX "can not determine bus frequency\n");
 		return -EINVAL;
 	}
 	pr_debug("FSB: %3dMHz\n", fsb/1000);
 
 	if (dmi_check_system(powernow_dmi_table) || acpi_force) {
-		printk(KERN_INFO PFX "PSB/PST known to be broken.  "
-				"Trying ACPI instead\n");
+		pr_info(PFX "PSB/PST known to be broken - trying ACPI instead\n");
 		result = powernow_acpi_init();
 	} else {
 		result = powernow_decode_bios(fidvidstatus.bits.MFID,
 				fidvidstatus.bits.SVID);
 		if (result) {
-			printk(KERN_INFO PFX "Trying ACPI perflib\n");
+			pr_info(PFX "Trying ACPI perflib\n");
 			maximum_speed = 0;
 			minimum_speed = -1;
 			latency = 0;
 			result = powernow_acpi_init();
 			if (result) {
-				printk(KERN_INFO PFX
-					"ACPI and legacy methods failed\n");
+				pr_info(PFX "ACPI and legacy methods failed\n");
 			}
 		} else {
 			/* SGTC use the bus clock as timer */
 			latency = fixup_sgtc();
-			printk(KERN_INFO PFX "SGTC: %d\n", latency);
+			pr_info(PFX "SGTC: %d\n", latency);
 		}
 	}
 
 	if (result)
 		return result;
 
-	printk(KERN_INFO PFX "Minimum speed %d MHz. Maximum speed %d MHz.\n",
-				minimum_speed/1000, maximum_speed/1000);
+	pr_info(PFX "Minimum speed %d MHz - Maximum speed %d MHz\n",
+		minimum_speed/1000, maximum_speed/1000);
 
 	policy->cpuinfo.transition_latency =
 		cpufreq_scale(2000000UL, fsb, latency);
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 46fee15..8a27667 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -233,9 +233,8 @@ static void pxa27x_guess_max_freq(void)
 {
 	if (!pxa27x_maxfreq) {
 		pxa27x_maxfreq = 416000;
-		printk(KERN_INFO "PXA CPU 27x max frequency not defined "
-		       "(pxa27x_maxfreq), assuming pxa271 with %dkHz maxfreq\n",
-		       pxa27x_maxfreq);
+		pr_info("PXA CPU 27x max frequency not defined (pxa27x_maxfreq), assuming pxa271 with %dkHz maxfreq\n",
+			pxa27x_maxfreq);
 	} else {
 		pxa27x_maxfreq *= 1000;
 	}
@@ -417,7 +416,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_table_validate_and_show(policy, pxa27x_freq_table);
 	}
 
-	printk(KERN_INFO "PXA CPU frequency change support initialized\n");
+	pr_info("PXA CPU frequency change support initialized\n");
 
 	return 0;
 }
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index eb26213..f9447ba 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -197,21 +197,20 @@ static int s3c2412_cpufreq_add(struct device *dev,
 
 	hclk = clk_get(NULL, "hclk");
 	if (IS_ERR(hclk)) {
-		printk(KERN_ERR "%s: cannot find hclk clock\n", __func__);
+		pr_err("%s: cannot find hclk clock\n", __func__);
 		return -ENOENT;
 	}
 
 	fclk = clk_get(NULL, "fclk");
 	if (IS_ERR(fclk)) {
-		printk(KERN_ERR "%s: cannot find fclk clock\n", __func__);
+		pr_err("%s: cannot find fclk clock\n", __func__);
 		goto err_fclk;
 	}
 
 	fclk_rate = clk_get_rate(fclk);
 	if (fclk_rate > 200000000) {
-		printk(KERN_INFO
-		       "%s: fclk %ld MHz, assuming 266MHz capable part\n",
-		       __func__, fclk_rate / 1000000);
+		pr_info("%s: fclk %ld MHz, assuming 266MHz capable part\n",
+			__func__, fclk_rate / 1000000);
 		s3c2412_cpufreq_info.max.fclk = 266000000;
 		s3c2412_cpufreq_info.max.hclk = 133000000;
 		s3c2412_cpufreq_info.max.pclk =  66000000;
@@ -219,13 +218,13 @@ static int s3c2412_cpufreq_add(struct device *dev,
 
 	armclk = clk_get(NULL, "armclk");
 	if (IS_ERR(armclk)) {
-		printk(KERN_ERR "%s: cannot find arm clock\n", __func__);
+		pr_err("%s: cannot find arm clock\n", __func__);
 		goto err_armclk;
 	}
 
 	xtal = clk_get(NULL, "xtal");
 	if (IS_ERR(xtal)) {
-		printk(KERN_ERR "%s: cannot find xtal clock\n", __func__);
+		pr_err("%s: cannot find xtal clock\n", __func__);
 		goto err_xtal;
 	}
 
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 0129f5c..f6cefe3 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -66,7 +66,7 @@ static int s3c2440_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 		     __func__, fclk, armclk, hclk_max);
 
 	if (armclk > fclk) {
-		printk(KERN_WARNING "%s: armclk > fclk\n", __func__);
+		pr_warn("%s: armclk > fclk\n", __func__);
 		armclk = fclk;
 	}
 
@@ -273,7 +273,7 @@ static int s3c2440_cpufreq_add(struct device *dev,
 	armclk = s3c_cpufreq_clk_get(NULL, "armclk");
 
 	if (IS_ERR(xtal) || IS_ERR(hclk) || IS_ERR(fclk) || IS_ERR(armclk)) {
-		printk(KERN_ERR "%s: failed to get clocks\n", __func__);
+		pr_err("%s: failed to get clocks\n", __func__);
 		return -ENOENT;
 	}
 
diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
index 9b7b428..8182608 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
@@ -178,7 +178,7 @@ static int __init s3c_freq_debugfs_init(void)
 {
 	dbgfs_root = debugfs_create_dir("s3c-cpufreq", NULL);
 	if (IS_ERR(dbgfs_root)) {
-		printk(KERN_ERR "%s: error creating debugfs root\n", __func__);
+		pr_err("%s: error creating debugfs root\n", __func__);
 		return PTR_ERR(dbgfs_root);
 	}
 
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 68ef8fd..68f8837 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -175,7 +175,7 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 	cpu_new.freq.fclk = cpu_new.pll.frequency;
 
 	if (s3c_cpufreq_calcdivs(&cpu_new) < 0) {
-		printk(KERN_ERR "no divisors for %d\n", target_freq);
+		pr_err("no divisors for %d\n", target_freq);
 		goto err_notpossible;
 	}
 
@@ -187,7 +187,7 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 
 	if (cpu_new.freq.hclk != cpu_cur.freq.hclk) {
 		if (s3c_cpufreq_calcio(&cpu_new) < 0) {
-			printk(KERN_ERR "%s: no IO timings\n", __func__);
+			pr_err("%s: no IO timings\n", __func__);
 			goto err_notpossible;
 		}
 	}
@@ -262,7 +262,7 @@ static int s3c_cpufreq_settarget(struct cpufreq_policy *policy,
 	return 0;
 
  err_notpossible:
-	printk(KERN_ERR "no compatible settings for %d\n", target_freq);
+	pr_err("no compatible settings for %d\n", target_freq);
 	return -EINVAL;
 }
 
@@ -331,7 +331,7 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 						     &index);
 
 		if (ret < 0) {
-			printk(KERN_ERR "%s: no PLL available\n", __func__);
+			pr_err("%s: no PLL available\n", __func__);
 			goto err_notpossible;
 		}
 
@@ -346,7 +346,7 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 	return s3c_cpufreq_settarget(policy, target_freq, pll);
 
  err_notpossible:
-	printk(KERN_ERR "no compatible settings for %d\n", target_freq);
+	pr_err("no compatible settings for %d\n", target_freq);
 	return -EINVAL;
 }
 
@@ -356,7 +356,7 @@ struct clk *s3c_cpufreq_clk_get(struct device *dev, const char *name)
 
 	clk = clk_get(dev, name);
 	if (IS_ERR(clk))
-		printk(KERN_ERR "cpufreq: failed to get clock '%s'\n", name);
+		pr_err("cpufreq: failed to get clock '%s'\n", name);
 
 	return clk;
 }
@@ -378,15 +378,16 @@ static int __init s3c_cpufreq_initclks(void)
 
 	if (IS_ERR(clk_fclk) || IS_ERR(clk_hclk) || IS_ERR(clk_pclk) ||
 	    IS_ERR(_clk_mpll) || IS_ERR(clk_arm) || IS_ERR(_clk_xtal)) {
-		printk(KERN_ERR "%s: could not get clock(s)\n", __func__);
+		pr_err("%s: could not get clock(s)\n", __func__);
 		return -ENOENT;
 	}
 
-	printk(KERN_INFO "%s: clocks f=%lu,h=%lu,p=%lu,a=%lu\n", __func__,
-	       clk_get_rate(clk_fclk) / 1000,
-	       clk_get_rate(clk_hclk) / 1000,
-	       clk_get_rate(clk_pclk) / 1000,
-	       clk_get_rate(clk_arm) / 1000);
+	pr_info("%s: clocks f=%lu,h=%lu,p=%lu,a=%lu\n",
+		__func__,
+		clk_get_rate(clk_fclk) / 1000,
+		clk_get_rate(clk_hclk) / 1000,
+		clk_get_rate(clk_pclk) / 1000,
+		clk_get_rate(clk_arm) / 1000);
 
 	return 0;
 }
@@ -424,7 +425,7 @@ static int s3c_cpufreq_resume(struct cpufreq_policy *policy)
 
 	ret = s3c_cpufreq_settarget(NULL, suspend_freq, &suspend_pll);
 	if (ret) {
-		printk(KERN_ERR "%s: failed to reset pll/freq\n", __func__);
+		pr_err("%s: failed to reset pll/freq\n", __func__);
 		return ret;
 	}
 
@@ -449,13 +450,12 @@ static struct cpufreq_driver s3c24xx_driver = {
 int s3c_cpufreq_register(struct s3c_cpufreq_info *info)
 {
 	if (!info || !info->name) {
-		printk(KERN_ERR "%s: failed to pass valid information\n",
-		       __func__);
+		pr_err("%s: failed to pass valid information\n", __func__);
 		return -EINVAL;
 	}
 
-	printk(KERN_INFO "S3C24XX CPU Frequency driver, %s cpu support\n",
-	       info->name);
+	pr_info("S3C24XX CPU Frequency driver, %s cpu support\n",
+		info->name);
 
 	/* check our driver info has valid data */
 
@@ -478,7 +478,7 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 	struct s3c_cpufreq_board *ours;
 
 	if (!board) {
-		printk(KERN_INFO "%s: no board data\n", __func__);
+		pr_info("%s: no board data\n", __func__);
 		return -EINVAL;
 	}
 
@@ -487,7 +487,7 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 
 	ours = kzalloc(sizeof(*ours), GFP_KERNEL);
 	if (ours == NULL) {
-		printk(KERN_ERR "%s: no memory\n", __func__);
+		pr_err("%s: no memory\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -502,15 +502,15 @@ static int __init s3c_cpufreq_auto_io(void)
 	int ret;
 
 	if (!cpu_cur.info->get_iotiming) {
-		printk(KERN_ERR "%s: get_iotiming undefined\n", __func__);
+		pr_err("%s: get_iotiming undefined\n", __func__);
 		return -ENOENT;
 	}
 
-	printk(KERN_INFO "%s: working out IO settings\n", __func__);
+	pr_info("%s: working out IO settings\n", __func__);
 
 	ret = (cpu_cur.info->get_iotiming)(&cpu_cur, &s3c24xx_iotiming);
 	if (ret)
-		printk(KERN_ERR "%s: failed to get timings\n", __func__);
+		pr_err("%s: failed to get timings\n", __func__);
 
 	return ret;
 }
@@ -561,7 +561,7 @@ static void s3c_cpufreq_update_loctkime(void)
 	val = calc_locktime(rate, cpu_cur.info->locktime_u) << bits;
 	val |= calc_locktime(rate, cpu_cur.info->locktime_m);
 
-	printk(KERN_INFO "%s: new locktime is 0x%08x\n", __func__, val);
+	pr_info("%s: new locktime is 0x%08x\n", __func__, val);
 	__raw_writel(val, S3C2410_LOCKTIME);
 }
 
@@ -580,7 +580,7 @@ static int s3c_cpufreq_build_freq(void)
 
 	ftab = kzalloc(sizeof(*ftab) * size, GFP_KERNEL);
 	if (!ftab) {
-		printk(KERN_ERR "%s: no memory for tables\n", __func__);
+		pr_err("%s: no memory for tables\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -608,15 +608,14 @@ static int __init s3c_cpufreq_initcall(void)
 		if (cpu_cur.board->auto_io) {
 			ret = s3c_cpufreq_auto_io();
 			if (ret) {
-				printk(KERN_ERR "%s: failed to get io timing\n",
+				pr_err("%s: failed to get io timing\n",
 				       __func__);
 				goto out;
 			}
 		}
 
 		if (cpu_cur.board->need_io && !cpu_cur.info->set_iotiming) {
-			printk(KERN_ERR "%s: no IO support registered\n",
-			       __func__);
+			pr_err("%s: no IO support registered\n", __func__);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -666,9 +665,9 @@ int s3c_plltab_register(struct cpufreq_frequency_table *plls,
 		vals += plls_no;
 		vals->frequency = CPUFREQ_TABLE_END;
 
-		printk(KERN_INFO "cpufreq: %d PLL entries\n", plls_no);
+		pr_info("cpufreq: %d PLL entries\n", plls_no);
 	} else
-		printk(KERN_ERR "cpufreq: no memory for PLL tables\n");
+		pr_err("cpufreq: no memory for PLL tables\n");
 
 	return vals ? 0 : -ENOMEM;
 }
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index a145b31..344e584 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -205,7 +205,7 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
 	} else if (ch == DMC1) {
 		reg = (dmc_base[1] + 0x30);
 	} else {
-		printk(KERN_ERR "Cannot find DMC port\n");
+		pr_err("Cannot find DMC port\n");
 		return;
 	}
 
@@ -534,7 +534,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	mem_type = check_mem_type(dmc_base[0]);
 
 	if ((mem_type != LPDDR) && (mem_type != LPDDR2)) {
-		printk(KERN_ERR "CPUFreq doesn't support this memory type\n");
+		pr_err("CPUFreq doesn't support this memory type\n");
 		ret = -EINVAL;
 		goto out_dmc1;
 	}
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index ac84e48..57bbddf 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -44,8 +44,8 @@ static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
 
 	switch (clockspeed_reg & 0x03) {
 	default:
-		printk(KERN_ERR PFX "error: cpuctl register has unexpected "
-				"value %02x\n", clockspeed_reg);
+		pr_err(PFX "error: cpuctl register has unexpected value %02x\n",
+		       clockspeed_reg);
 	case 0x01:
 		return 100000;
 	case 0x02:
@@ -112,7 +112,7 @@ static int __init sc520_freq_init(void)
 
 	cpuctl = ioremap((unsigned long)(MMCR_BASE + OFFS_CPUCTL), 1);
 	if (!cpuctl) {
-		printk(KERN_ERR "sc520_freq: error: failed to remap memory\n");
+		pr_err("sc520_freq: error: failed to remap memory\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 7d4a315..47df2d6 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -386,8 +386,7 @@ static int centrino_cpu_init(struct cpufreq_policy *policy)
 		/* check to see if it stuck */
 		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 		if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
-			printk(KERN_INFO PFX
-				"couldn't enable Enhanced SpeedStep\n");
+			pr_info(PFX "couldn't enable Enhanced SpeedStep\n");
 			return -ENODEV;
 		}
 	}
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 37555c6..9d00c22 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -68,13 +68,13 @@ static int speedstep_find_register(void)
 	/* get PMBASE */
 	pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
 	if (!(pmbase & 0x01)) {
-		printk(KERN_ERR "speedstep-ich: could not find speedstep register\n");
+		pr_err("speedstep-ich: could not find speedstep register\n");
 		return -ENODEV;
 	}
 
 	pmbase &= 0xFFFFFFFE;
 	if (!pmbase) {
-		printk(KERN_ERR "speedstep-ich: could not find speedstep register\n");
+		pr_err("speedstep-ich: could not find speedstep register\n");
 		return -ENODEV;
 	}
 
@@ -136,7 +136,7 @@ static void speedstep_set_state(unsigned int state)
 		pr_debug("change to %u MHz succeeded\n",
 			speedstep_get_frequency(speedstep_processor) / 1000);
 	else
-		printk(KERN_ERR "cpufreq: change failed - I/O error\n");
+		pr_err("cpufreq: change failed - I/O error\n");
 
 	return;
 }
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 15d3214..32bdf1d 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -153,7 +153,7 @@ static unsigned int pentium_core_get_frequency(void)
 		fsb = 333333;
 		break;
 	default:
-		printk(KERN_ERR "PCORE - MSR_FSB_FREQ undefined value");
+		pr_err("PCORE - MSR_FSB_FREQ undefined value\n");
 	}
 
 	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
@@ -453,11 +453,8 @@ unsigned int speedstep_get_freqs(enum speedstep_processor processor,
 		 */
 		if (*transition_latency > 10000000 ||
 		    *transition_latency < 50000) {
-			printk(KERN_WARNING PFX "frequency transition "
-					"measured seems out of range (%u "
-					"nSec), falling back to a safe one of"
-					"%u nSec.\n",
-					*transition_latency, 500000);
+			pr_warn(PFX "frequency transition measured seems out of range (%u nSec), falling back to a safe one of %u nSec\n",
+				*transition_latency, 500000);
 			*transition_latency = 500000;
 		}
 	}
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 819229e..af32a5f 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -204,9 +204,8 @@ static void speedstep_set_state(unsigned int state)
 			(speedstep_freqs[new_state].frequency / 1000),
 			retry, result);
 	else
-		printk(KERN_ERR "cpufreq: change to state %u "
-			"failed with new_state %u and result %u\n",
-			state, new_state, result);
+		pr_err("cpufreq: change to state %u failed with new_state %u and result %u\n",
+		       state, new_state, result);
 
 	return;
 }
-- 
2.8.0.rc4.16.g56331f8
