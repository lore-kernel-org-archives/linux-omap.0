From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix warnings with broken
 omap2_set_init_voltage()
Date: Fri, 6 Dec 2019 19:34:44 +0100
Message-ID: <A0DC2BBE-C5A9-4873-BBD2-C69F7697B210@goldelico.com>
References: <20190924233222.52757-1-tony@atomide.com>
 <8FFD44DB-73F8-4807-91E1-C97DA8F781BA@goldelico.com>
 <20191202213929.GB35479@atomide.com>
 <EE749881-C3DB-4BBE-85FE-E5AF3D34884F@goldelico.com>
 <BAF5B057-1017-4174-8C3F-4B49B31E2E0D@goldelico.com>
 <20191203154447.GC35479@atomide.com>
 <5F430C0D-7F25-4680-87B9-2D65A08A9F83@goldelico.com>
 <FB42ED12-5DDB-4A9E-941A-ACBE2C10C36A@goldelico.com>
 <20191206182040.GH35479@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191206182040.GH35479@atomide.com>
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


> Am 06.12.2019 um 19:20 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [191203 16:55]:
>>> What we could do is augment the printk (or dev_err) to tell
>>> in these warnings what it is looking for...
>>> 
>>> 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>>> 	if (IS_ERR(opp)) {
>>> 		pr_err("%s: unable to find boot up OPP for vdd_%s freq %ulHz\n",
>>> 		__func__, vdd_name, freq);
>>> 		goto exit;
>>> 	}
>> 
>> Easier and always prints info:
>> 
>> 	freq = clk_get_rate(clk);
>> 	clk_put(clk);
>> 
>> 	pr_info("%s: vdd=%s clk=%s %luHz oh=%s\n", __func__, vdd_name, clk_name, freq, oh_name);
>> 
>> 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> 
>> I get this:
>> 
>> [    2.908142] omap2_set_init_voltage: vdd=mpu_iva clk=dpll1_ck 1000000000Hz oh=mpu
>> [    2.930816] omap2_set_init_voltage: vdd=core clk=l3_ick 200000000Hz oh=l3_main
>> [    2.946228] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>> [    2.953460] omap2_set_init_voltage: unable to set vdd_core
> 
> OK yeah that's more descriptive.

So what does your board say as it is also unable to find the initial mpu_iva?
And/or does it show a different core clock?

> 
>> Which means that cpufreq already has increased dpll1_ck to 1 GHz
>> (I have removed the turbo-mode tags so that it already boots at
>> full speed) and l3_ick runs at initial 200 MHz.
> 
> OK. I wonder where this initial code should live though..

Well, we all agree that it should live in deserved retirement :)

But it has some positive effect and maybe "fixes" a bug in cpufreq-only setup.

BR,
Nikolaus
