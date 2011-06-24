From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 16:12:01 +0100
Message-ID: <20110624151201.GO9449@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
	<20110624141402.GN9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110624141402.GN9449@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Right, thanks for the file.  Here's the patch.

--- omap2plus-cpufreq.c~	2011-06-24 15:50:32.000000000 +0100
+++ omap2plus-cpufreq.c	2011-06-24 16:00:08.000000000 +0100
@@ -44,6 +44,16 @@
 static char *mpu_clk_name;
 static struct device *mpu_dev;
 
+#ifdef CONFIG_SMP
+struct lpj_info {
+	unsigned long	ref;
+	unsigned int	freq;
+};
+
+static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
+static struct lpj_info global_lpj_ref;
+#endif
+
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
 	if (!freq_table)
@@ -109,14 +119,25 @@
 	freqs.new = omap_getspeed(policy->cpu);
 
 #ifdef CONFIG_SMP
-	/* Adjust jiffies before transition */
+	/* Adjust per-cpu loops_per_jiffy before transition */
 	for_each_cpu(i, policy->cpus) {
-		unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
-
-		per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
-							freqs.old,
-							freqs.new);
+		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
+		if (!lpj->freq) {
+			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
+			lpj->freq = freqs.old;
+		}
+
+		per_cpu(cpu_data, i).loops_per_jiffy =
+			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
+	}
+
+	/* And don't forget to adjust the global one */
+	if (!global_lpj_ref.freq) {
+		global_lpj_ref.ref = loops_per_jiffy;
+		global_lpj_ref.freq = freqs.old;
 	}
+	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
+					freqs.new);
 #endif
 
 	/* Notify transitions */


Notice how we adjust _both_ the per-cpu loops_per_jiffy, and that we
adjust them with reference to the initial values.

If you adjust lpj with reference to the last, then you _will_ build up
a progressively bigger and bigger error in the value over time.
