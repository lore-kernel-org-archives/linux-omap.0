From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix warnings with broken
 omap2_set_init_voltage()
Date: Tue, 3 Dec 2019 17:54:23 +0100
Message-ID: <FB42ED12-5DDB-4A9E-941A-ACBE2C10C36A@goldelico.com>
References: <20190924233222.52757-1-tony@atomide.com>
 <8FFD44DB-73F8-4807-91E1-C97DA8F781BA@goldelico.com>
 <20191202213929.GB35479@atomide.com>
 <EE749881-C3DB-4BBE-85FE-E5AF3D34884F@goldelico.com>
 <BAF5B057-1017-4174-8C3F-4B49B31E2E0D@goldelico.com>
 <20191203154447.GC35479@atomide.com>
 <5F430C0D-7F25-4680-87B9-2D65A08A9F83@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5F430C0D-7F25-4680-87B9-2D65A08A9F83@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <aford173@gmail.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 03.12.2019 um 16:58 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> 
>> Am 03.12.2019 um 16:44 schrieb Tony Lindgren <tony@atomide.com>:
>> 
>> * H. Nikolaus Schaller <hns@goldelico.com> [191203 12:31]:
>>> Ok, dev_pm_opp_find_freq_ceil() is doing what it should do and it
>>> returns the first OPP higher or equal than the frequency passed in.
>>> 
>>> The real reason for the warning is that the same OPP table is used
>>> for vdd_mpu_iva and vdd_core and it appears as if "core" (l3_ick)
>>> runs at 200 MHz which does not correspond to a valid OPP.
>> 
>> OK
>> 
>>> So to silcence the warning it suffices to remove
>>> 
>>> 	omap2_set_init_voltage("core", "l3_ick", "l3_main");
>>> 
>>> The question is now what l3_ick has to do with the OPPs at all
>>> and how it should interwork with OPPs and cpufreq.
>> 
>> So what changed then for iva in your configuration then?
>> 
>> At least I'm getting errors for both for 34xx and dm3730 with
>> Linux next and reverted commit cf395f7ddb9e ("ARM: OMAP2+: Fix
>> warnings with broken omap2_set_init_voltage()"):
>> 
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
>> omap2_set_init_voltage: unable to set vdd_mpu_iva
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>> omap2_set_init_voltage: unable to set vdd_core
> 
> Hm... Is there maybe a dependency on u-boot?
> 
> We are using a quite old version which may boot with vdd_mpu_iva
> as 300 MHz while yours may have a different clock.
> 
> What we could do is augment the printk (or dev_err) to tell
> in these warnings what it is looking for...
> 
> 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> 	if (IS_ERR(opp)) {
> 		pr_err("%s: unable to find boot up OPP for vdd_%s freq %ulHz\n",
> 		__func__, vdd_name, freq);
> 		goto exit;
> 	}

Easier and always prints info:

	freq = clk_get_rate(clk);
	clk_put(clk);

	pr_info("%s: vdd=%s clk=%s %luHz oh=%s\n", __func__, vdd_name, clk_name, freq, oh_name);

	opp = dev_pm_opp_find_freq_ceil(dev, &freq);

I get this:

[    2.908142] omap2_set_init_voltage: vdd=mpu_iva clk=dpll1_ck 1000000000Hz oh=mpu
[    2.930816] omap2_set_init_voltage: vdd=core clk=l3_ick 200000000Hz oh=l3_main
[    2.946228] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    2.953460] omap2_set_init_voltage: unable to set vdd_core

Which means that cpufreq already has increased dpll1_ck to 1 GHz
(I have removed the turbo-mode tags so that it already boots at
full speed) and l3_ick runs at initial 200 MHz.

> 
>> Then for fixing this code, seems like this can all happen from
>> a regular device driver init based on the dts data.. We've had
>> PM init completely ignore these errors already for years so
>> whatever dependency there might be seems non-critical :)
>> 
>>> Or does all this mean we may need a second OPP fable for vdd_core
>>> and 200 MHz? But what would it be good for? I have not seen any
>>> reference for "core-OPPs" in the TRM.
>> 
>> OK yeah sounds like all the domains need an opp table.
>> 
>> Also, I recall some SoCs having a dependency between having to
>> run DSP at a lower rate for higher MPU rates, not sure if omap3
>> has such dependencies though.
> 
> Well, I not aware of documentation of such dependencies and there
> is also some confusion what vdd_mpu_iva exactly is and what vdd_core is.
> twl4030 has vdd1 and vdd2 but their relationship isn't clear either.
> 
> Maybe Tero or Nisanth can clarify?
> 
> BR and thanks,
> Nikolaus
> 
> 
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel
