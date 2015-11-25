From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Wed, 25 Nov 2015 10:26:57 -0800
Message-ID: <20151125182657.GK2517@atomide.com>
References: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
 <20151112180027.GP3218@atomide.com>
 <565413EF.2040003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565413EF.2040003@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: paul@pwsan.com, balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151123 23:39]:
> Tony,
> 
> On 11/12/2015 08:00 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [151111 23:33]:
> >> Hi Tony,
> >>
> >> Changes since v3:
> >> - rebased on mainline's HEAD
> >> - Added Tested-by from Felipe
> >> - Added Acked-by from Paul for the hwmod patches
> >>
> >> Changes since v2:
> >> - DTS patch added which is needed because of the clock handling changes
> >>
> >> Felip Balbi reported that linux-next is broken right now since the DTS part of
> >> the earlier series has been applied, but we do not have the mcasp hwmod in the
> >> kernel:
> >> ...
> >> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> >> ...
> >> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> >> [    6.130790] ------------[ cut here ]------------
> >> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x34c()
> >> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3 (Read): Data Access in User mode during Functional access
> > 
> > 
> > Thanks applying all three into omap-for-v4.4/fixes.
> 
> Do you know when these patches are going to be merged to mainline? 4.4-rc2 is
> out, but it does not include them.

Sorry for the delays, hoping to send out the fixes today or Friday after
scanning emails one more time for more fixes.

Regards,

Tony
