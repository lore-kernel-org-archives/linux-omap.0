From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Sun, 29 May 2011 12:25:18 -0500
Message-ID: <BANLkTimLvXDhExHoPTvWZKo4_O6bM_JQeQ@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com>
 <4DDF3169.9070503@ti.com> <BANLkTinv3HMBE_FBGWfLvnWyTRM=wXhpxA@mail.gmail.com>
 <4DDF4424.2000706@ti.com> <BANLkTiktQAt3q=a3-cNaFrTH5UeNH21tmg@mail.gmail.com>
 <871uzjwwq7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:32981 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841Ab1E2RZk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 13:25:40 -0400
Received: by mail-wy0-f176.google.com with SMTP id 40so3181334wyb.21
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 10:25:38 -0700 (PDT)
In-Reply-To: <871uzjwwq7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, May 27, 2011 at 18:27, Kevin Hilman <khilman@ti.com> wrote:
> All of this came up because this series is going through contortions =
to
> make two CPUfreq registrations only using one freq_table, protect
> against concurrent access from different CPUs etc., =A0which led me t=
o
> wonder why we need two registrations.
I believe we have two cpu_inits and exits per cpu -> the
/sys/devices/system/cpu/cpu1/online and
/sys/devices/system/cpu/cpu0/online
are not soft links. this is where the issue starts

Try this diff on the pm-wip/cpufreq branch:
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 33a91ec..f3e82ce 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -199,11 +199,15 @@ static int __cpuinit omap_cpu_init(struct
cpufreq_policy *policy)
        /* FIXME: what's the actual transition time? */
        policy->cpuinfo.transition_latency =3D 300 * 1000;

+       dev_err(mpu_dev, "%s: XXX: cpu%d freq_table pointer=3D%p\n", __=
func__,
+                       policy->cpu, freq_table);
        return 0;
 }

 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+       dev_err(mpu_dev, "%s: XXX: cpu%d freq_table pointer=3D%p\n", __=
func__,
+                       policy->cpu, freq_table);
        clk_exit_cpufreq_table(&freq_table);
        clk_put(mpu_clk);
        return 0;

[    2.045623] platform mpu.0: omap_cpu_init: XXX: cpu0 freq_table
pointer=3Deeff7e20
[    2.055664] platform mpu.0: omap_cpu_init: XXX: cpu1 freq_table
pointer=3Deeff7de0 <- Freq table eeff7e20 got overwritten by the new
alloc
[    2.063537] platform mpu.0: omap_cpu_exit: XXX: cpu1 freq_table
pointer=3Deeff7de0 <- if I had a kfree/ opp_freqtable_free in exit, we'=
d
have had a dangling pointer.

in this series:
patch 1: OMAP2+: cpufreq: dont support !freq_table -> This is a proper
fix to cleanup the code which seems to think that silicon with no
freq_table is to be supported - this is a hang over from OMAP1 time
and should be removed.
patch 2: OMAP2+: cpufreq: use OPP library -> Since we are using OPP
table and from your recommendation of a previous patch incarnation, I
have moved the cpufreq usage depdendent on OPP.
Patch 3: OMAP2+: cpufreq: put clk if cpu_init failed -> this is a
valid fix as well
Patch 4: OMAP2+: cpufreq: fix freq_table leak -> This is what I have
explained above -> Since online variables are not really a softlink, I
dont think we should be confused as to what the fix should look like!

table creation and registration is done as part of cpu_init - this is
probably the most appropriate place for it. but we should consider the
potential of cpu onlining and offlining dynamically in the system as
well. hence the need for patch 4 where I have used freq_table users.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
