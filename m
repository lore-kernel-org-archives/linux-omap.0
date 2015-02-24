From: Tony Lindgren <tony@atomide.com>
Subject: Re: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Date: Mon, 23 Feb 2015 17:59:04 -0800
Message-ID: <20150224015903.GP32521@atomide.com>
References: <20150223235947.GC25954@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery10.ore.mailhop.org ([54.149.36.10]:49648 "EHLO
	pmta1.delivery10.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751312AbbBXCDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 21:03:19 -0500
Received: from smtp4.ore.mailhop.org (172.31.36.112) by pmta1.delivery1.ore.mailhop.org id htfduc20r849 for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2015 02:03:17 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <20150223235947.GC25954@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150223 16:09]:
> Hi Nishanth,
> 
> Olof told me about a new L3 error happening on omap5-uevm with
> v4.0-rc1:
> 
> WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data Access in Supervisor mode during Functional access
> ...
> 
> I tried bisecting this with no luck, but narrowed it down to
> having CONFIG_CPUFREQ_DT=y causing it, while =m wont' trigger
> it. This got changed by commit 40d1746d2eee ("ARM:
> omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> 
> Any ideas?

Hmm so setting CONFIG_CPUFREQ_DT=m in arch/arm/configs/omap2plus_defconfig
produces the same output with make omap2plus_defconfig as with =y.. So
CPUFREQ_DT can't be the real cause of the problem.

It's now looking like the l3-noc warning does not get triggered on
every boot.

It also seems the zImage triggering the error does not trigger the
error on every boot. To trigger the error, it seems the device needs to
be powered down for at least 10 or so seconds between the boots.
So far no luck reproducing the error on v3.19.

The easy way to reproduce is to power down omap5 for at least 10 seconds,
make omap2lus_defconfig on v4.0-rc1 and boot it.

And so far it looks like next-20150204 works and next-20150209
failed at once so far. But of course I would not trust anything
at this point :)

Regards,

Tony 
