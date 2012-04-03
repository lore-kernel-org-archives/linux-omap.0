From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 03 Apr 2012 16:14:19 -0700
Message-ID: <87ehs4pfw4.fsf@ti.com>
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
	<CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
	<CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
	<CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
	<20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56316 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754860Ab2DCXOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 19:14:21 -0400
Received: by pbcwz17 with SMTP id wz17so391486pbc.41
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 16:14:20 -0700 (PDT)
In-Reply-To: <20120403160706.GP17741@mudshark.cambridge.arm.com> (Will
	Deacon's message of "Tue, 3 Apr 2012 17:07:06 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Will Deacon <will.deacon@arm.com> writes:

[...]

> Right. Can you confirm whether the PMU/CTI interrupts fire for you please?
> Just run perf top and look at /proc/interrupts while it's running. You
> should see a couple of arm-pmu entries in there and hopefully numbers > 0.

Ah, I see now (I'm a perf newbie.)

Indeed, like you, I have to change the EMU clock domain to SWSUP[1] in
order to see any interrupts and see anything in perf top.  This isn't
really a mergeable workaround, so I'll look into this a little closer
with Santosh to see what we can do once we fully understand the HW
problem.

Kevin

[1]
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..41d2260 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-	.flags		  = CLKDM_CAN_HWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
