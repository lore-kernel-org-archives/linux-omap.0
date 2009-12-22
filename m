From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Tue, 22 Dec 2009 08:45:42 -0800
Message-ID: <87k4wfrm89.fsf@deeprootsystems.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
	<1258004721-7315-2-git-send-email-nm@ti.com>
	<1258004721-7315-3-git-send-email-nm@ti.com>
	<1258004721-7315-4-git-send-email-nm@ti.com>
	<1258004721-7315-5-git-send-email-nm@ti.com>
	<1258004721-7315-6-git-send-email-nm@ti.com>
	<87eimrx4em.fsf@deeprootsystems.com> <4B2CBA8A.5030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:42022 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbZLVQpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 11:45:52 -0500
Received: by pzk1 with SMTP id 1so4588781pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 08:45:51 -0800 (PST)
In-Reply-To: <4B2CBA8A.5030905@ti.com> (Nishanth Menon's message of "Sat\, 19 Dec 2009 17\:05\:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "K, Ambresh" <ambresh@ti.com>

"Menon, Nishanth" <nm@ti.com> writes:

> Kevin Hilman said the following on 12/19/2009 04:42 AM:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>   
>>> SmartReflex implements a get_opp to search through the opp table,
>>> replace it with the accessor function as it is a duplicate of
>>> freq_to_opp
>>>     
>>
>> SmartReflex is not quite working with this version which is in
>> pm-wip-opp.  My (untested) theory below...
>>
>> [...]
>>   
> Ambresh and I  just tested the very latest of the pm-wip-opp branch
> and checked. Voltage transitions and SR adjustments are happily
> happening on SDP3430 ES3.1 at the very least (verified with a scope on
> vdd1).
>
> and if you look closely in the code, sr2.vdd_opp_clk->rate and
> sr1.vdd_opp_clk->rate are based on
> sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck")
> sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");
>
> now, if the dpll1_ck ->rate and l3_ick->rate are not exact frequencies
> as the opp tables, I think we have a clockframework bug and the code
> here is correct. we should fix the clockframework/find the rootcause
> elsewhere.
>
> Now is the clockframework wrong? we added a patch to print the
> frequencies and checked if IS_ERR(opp) is true -> not a single call
> while using cpu_freq transitions resulted in an error value and all
> the frequencies we printed were from the OPP table
>
> Might be good to hear your rationale for saying this result..

Part of my rationale was that the PM branch version get_vdd1_opp()
does an approximate match (actually the equivalent of
opp_find_freq_ceil() via get_opp.)  So you replaced an approximate
match with an exact match.  That may be the right solution and point
to a bug elsewhere, but it was not an equivalent replacement, and
probably should've been done in a separate patch with
justification/rationale.  I didn't catch it during initial review.

But the primary reason I noticed it in the first place was that I was
seeing DVFS errors on n900, which is the only platform I have that
actually can do SmartReflex.  Specifically, sr_reset_voltage() is
failing for VDD1.  Dumping out the clock rates used in get_vdd1_opp()
show that the clocks rates are close, but not the exact value used in
the OPP table.

Here is the patch I used to add some debugging, and I see that for the
250MHz OPP, the clock framework rate is 249600000 and for the 125MHz
OPP, the clock rate is 124800000.  As I said, close, but clearly an
find with exact match is going to fail.

Below the patch, is the console dump and backtrace of how get_vdd1_opp()
was called so you can see the call chain.

Kevin

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d341857..01a3dbd 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -155,6 +155,8 @@ static u8 get_vdd1_opp(void)
 							mpu_opps == NULL)
 		return 0;
 
+	printk("%s: sr1.vdd_opp_clk->rate = %d\n", __func__,
+	       sr1.vdd_opp_clk->rate);
 	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
 	if (IS_ERR(opp))
 		return 0;
@@ -451,6 +453,7 @@ static int sr_reset_voltage(int srid)
 		target_opp_no = get_vdd1_opp();
 		if (!target_opp_no) {
 			pr_info("Current OPP unknown: Cannot reset voltage\n");
+			__backtrace();
 			return 1;
 		}
 


/sys/devices/system/cpu/cpu0/cpufreq # echo 250000 > scaling_setspeed 
get_vdd1_opp: sr1.vdd_opp_clk->rate = 249600000
Current OPP unknown: Cannot reset voltage
[<c0042c98>] (sr_reset_voltage+0x0/0x190) from [<c0043094>] (sr_stop_vddautocomap+0x12c/0x148)
 r7:00000001 r6:00000001 r5:c03ac878 r4:00000000
[<c0042f68>] (sr_stop_vddautocomap+0x0/0x148) from [<c0043388>] (sr_voltagescale_vcbypass+0x2c/0x170)
 r7:00000001 r6:00000001 r5:00000030 r4:00000026
[<c004335c>] (sr_voltagescale_vcbypass+0x0/0x170) from [<c0043e00>] (program_opp+0x1e4/0x210)
[<c0043c1c>] (program_opp+0x0/0x210) from [<c0043f64>] (resource_set_opp_level+0x138/0x1b0)
[<c0043e2c>] (resource_set_opp_level+0x0/0x1b0) from [<c0044024>] (set_opp+0x48/0x120)
[<c0043fdc>] (set_opp+0x0/0x120) from [<c004bb48>] (update_resource_level+0xb0/0xd4)
 r5:c03b365c r4:00000002
[<c004ba98>] (update_resource_level+0x0/0xd4) from [<c004be34>] (resource_request+0x154/0x184)
 r7:00000002 r6:c03db5a0 r5:c03b365c r4:00000000
[<c004bce0>] (resource_request+0x0/0x184) from [<c0043a50>] (set_freq+0xb4/0xe8)
 r7:0ee6b280 r6:cf801080 r5:cf801000 r4:c0359347
[<c004399c>] (set_freq+0x0/0xe8) from [<c004bb48>] (update_resource_level+0xb0/0xd4)
 r8:c03d52f8 r7:0ee6b280 r6:c03dbf70 r5:c03b36a4 r4:0ee6b280
[<c004ba98>] (update_resource_level+0x0/0xd4) from [<c004be34>] (resource_request+0x154/0x184)
 r7:0ee6b280 r6:c03dbf70 r5:c03b36a4 r4:00000000
[<c004bce0>] (resource_request+0x0/0x184) from [<c004b7a4>] (omap_pm_cpu_set_freq+0x34/0x44)
 r7:00000007 r6:cfae7000 r5:cf96c100 r4:0003d090
[<c004b770>] (omap_pm_cpu_set_freq+0x0/0x44) from [<c004ac44>] (omap_target+0x64/0x74)
[<c004abe0>] (omap_target+0x0/0x74) from [<c02318c4>] (__cpufreq_driver_target+0x30/0x40)
[<c0231894>] (__cpufreq_driver_target+0x0/0x40) from [<c02339e8>] (cpufreq_set+0x58/0x74)
[<c0233990>] (cpufreq_set+0x0/0x74) from [<c0231b9c>] (store_scaling_setspeed+0x64/0x7c)
 r5:00000007 r4:cf96c100
[<c0231b38>] (store_scaling_setspeed+0x0/0x7c) from [<c0232ae0>] (store+0x60/0x7c)
 r5:cf96c100 r4:c03d53f8
[<c0232a80>] (store+0x0/0x7c) from [<c010c684>] (sysfs_write_file+0x110/0x144)
 r7:cf96c150 r6:cfb10bc0 r5:cf8fc000 r4:00000007
[<c010c574>] (sysfs_write_file+0x0/0x144) from [<c00bbdcc>] (vfs_write+0xb8/0x164)
[<c00bbd14>] (vfs_write+0x0/0x164) from [<c00bbf3c>] (sys_write+0x44/0x70)
 r8:40001000 r7:00000007 r6:cfafa280 r5:00000000 r4:00000000
[<c00bbef8>] (sys_write+0x0/0x70) from [<c0030fc0>] (ret_fast_syscall+0x0/0x2c)
 r8:c0031144 r7:00000004 r6:41149600 r5:40001000 r4:00000007



/sys/devices/system/cpu/cpu0/cpufreq # echo 125000 > scaling_setspeed 
get_vdd1_opp: sr1.vdd_opp_clk->rate = 124800000
Current OPP unknown: Cannot reset voltage
[<c0042c98>] (sr_reset_voltage+0x0/0x190) from [<c0043094>] (sr_stop_vddautocomap+0x12c/0x148)
 r7:00000001 r6:00000001 r5:c03ac878 r4:00000000
[<c0042f68>] (sr_stop_vddautocomap+0x0/0x148) from [<c0043388>] (sr_voltagescale_vcbypass+0x2c/0x170)
 r7:00000001 r6:00000001 r5:00000026 r4:0000001e
[<c004335c>] (sr_voltagescale_vcbypass+0x0/0x170) from [<c0043e00>] (program_opp+0x1e4/0x210)
[<c0043c1c>] (program_opp+0x0/0x210) from [<c0043f64>] (resource_set_opp_level+0x138/0x1b0)
[<c0043e2c>] (resource_set_opp_level+0x0/0x1b0) from [<c0044024>] (set_opp+0x48/0x120)
[<c0043fdc>] (set_opp+0x0/0x120) from [<c004bb48>] (update_resource_level+0xb0/0xd4)
 r5:c03b365c r4:00000001
[<c004ba98>] (update_resource_level+0x0/0xd4) from [<c004be34>] (resource_request+0x154/0x184)
 r7:00000001 r6:c03db5a0 r5:c03b365c r4:00000000
[<c004bce0>] (resource_request+0x0/0x184) from [<c0043a50>] (set_freq+0xb4/0xe8)
 r7:07735940 r6:cf801080 r5:cf801000 r4:c0359347
[<c004399c>] (set_freq+0x0/0xe8) from [<c004bb48>] (update_resource_level+0xb0/0xd4)
 r8:c03d52f8 r7:07735940 r6:c03dbf70 r5:c03b36a4 r4:07735940
[<c004ba98>] (update_resource_level+0x0/0xd4) from [<c004be34>] (resource_request+0x154/0x184)
 r7:07735940 r6:c03dbf70 r5:c03b36a4 r4:00000000
[<c004bce0>] (resource_request+0x0/0x184) from [<c004b7a4>] (omap_pm_cpu_set_freq+0x34/0x44)
 r7:00000007 r6:cfae7000 r5:cf96c100 r4:0001e848
[<c004b770>] (omap_pm_cpu_set_freq+0x0/0x44) from [<c004ac44>] (omap_target+0x64/0x74)
[<c004abe0>] (omap_target+0x0/0x74) from [<c02318c4>] (__cpufreq_driver_target+0x30/0x40)
[<c0231894>] (__cpufreq_driver_target+0x0/0x40) from [<c02339e8>] (cpufreq_set+0x58/0x74)
[<c0233990>] (cpufreq_set+0x0/0x74) from [<c0231b9c>] (store_scaling_setspeed+0x64/0x7c)
 r5:00000007 r4:cf96c100
[<c0231b38>] (store_scaling_setspeed+0x0/0x7c) from [<c0232ae0>] (store+0x60/0x7c)
 r5:cf96c100 r4:c03d53f8
[<c0232a80>] (store+0x0/0x7c) from [<c010c684>] (sysfs_write_file+0x110/0x144)
 r7:cf96c150 r6:cfb10bc0 r5:cf8fc000 r4:00000007
[<c010c574>] (sysfs_write_file+0x0/0x144) from [<c00bbdcc>] (vfs_write+0xb8/0x164)
[<c00bbd14>] (vfs_write+0x0/0x164) from [<c00bbf3c>] (sys_write+0x44/0x70)
 r8:40001000 r7:00000007 r6:cfafa700 r5:00000000 r4:00000000
[<c00bbef8>] (sys_write+0x0/0x70) from [<c0030fc0>] (ret_fast_syscall+0x0/0x2c)
 r8:c0031144 r7:00000004 r6:41149600 r5:40001000 r4:00000007
