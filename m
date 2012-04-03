From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 17:07:06 +0100
Message-ID: <20120403160706.GP17741@mudshark.cambridge.arm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58831 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754641Ab2DCQHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 12:07:35 -0400
Content-Disposition: inline
In-Reply-To: <878vicsxef.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Tue, Apr 03, 2012 at 03:27:52PM +0100, Kevin Hilman wrote:
> Hi Will,

Hi Kevin,

> Will Deacon <will.deacon@arm.com> writes:
> > The problem is, trying to boot this on my pandaboard results in a hang (see
> > dmesg below). Even worse, the problem isn't easily bisectable since rebuilding
> > a working image can give you something that no longer boots and I haven't found
> > a reliable way to cause the lockup.
> >
> > I'll take JTAG for a whirl to see where we are. If anything looks wrong in
> > my dmesg, please shout (there are plenty of things in there that look like
> > they've gone awry).
> 
> Not sure why it hangs for you, but it worked for me both with your
> branch on v3.3 and merging with v3.4-rc1[1]

Thanks for testing that. It turns out that updating my x-loader (it was
pretty ancient) fixed the boot hang, though I'm not sure I want to know why!

> # perf stat sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>           9.582520 task-clock                #    0.009 CPUs utilized          
>                  1 context-switches          #    0.104 K/sec                  
>                  0 CPU-migrations            #    0.000 K/sec                  
>                147 page-faults               #    0.015 M/sec                  
>            5096283 cycles                    #    0.532 GHz                    
>             607876 stalled-cycles-frontend   #   11.93% frontend cycles idle   
>            3285045 stalled-cycles-backend    #   64.46% backend  cycles idle   
>            2722485 instructions              #    0.53  insns per cycle        
>                                              #    1.21  stalled cycles per insn
>             259247 branches                  #   27.054 M/sec                  
>              84274 branch-misses             #   32.51% of all branches        

Right. Can you confirm whether the PMU/CTI interrupts fire for you please?
Just run perf top and look at /proc/interrupts while it's running. You
should see a couple of arm-pmu entries in there and hopefully numbers > 0.

For me, my earlier mis-diagnosis has turned out to be true and I can only
see PMU interrupts if I apply the SWSUSP patch, which Santosh says will
break pm.

Cheers,

Will
