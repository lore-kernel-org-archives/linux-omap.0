From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 23:45:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE60C@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
 <20091120162933.GC2354@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50038 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbZKTSQL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 13:16:11 -0500
In-Reply-To: <20091120162933.GC2354@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Petazzoni <mpetazzoni@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Maxime Petazzoni [mailto:mpetazzoni@mvista.com] 
> Sent: Friday, November 20, 2009 10:00 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: VDD1 voltage after resume from idle
> 
> Hi,
> 
> * Premi, Sanjeev <premi@ti.com> [2009-11-20 21:17:04]:
> 
> > I am facing a strange problem on OMAP3EVM after resuming from idle.
> > When using OPP5, the VDD1 voltage ramps to 1.35V.
> >  
> > However, when i go thru the idle/wakeup cycle, the voltage never
> > ramps back to 1.35V but stays at 1.20V.
> 
> I'm seeing some interesting behavior with the OPP values 
> here, too, with
> suspend/resume. I'm using SRF based PM and CPUFREQ. Here's 
> what happens:
> 
> When changing the CPU frequency through the scaling_setfreq knob of
> CPUFREQ, the vdd{1,2}_opp values are updated accordingly. After a
> suspend/resume cycles, the OPPs return to their pre-suspend 
> values, all
> is fine.
> 
> But when changing the OPP values by hand through the 
> vdd{1,2}_opp knobs,
> the CPU frequency is changed accordingly, which is expected. 
> But after a
> suspend/resume cycle, the OPP values return to the value CPUFREQ set
> them to (which may be different than the default OPP values of 3).
> 
> Is this the normal behavior? Is cpufreq authoritative on the 
> OPP values
> on resume? Or should it follow whatever value was manually set before
> suspending?

I guess the root cause could be same. I have not been able to ascertain
the reason for the voltage changing during the idle/wakeup sequence.
Also tried to eliminate the enable_smartreflex() calls on wakeup path.
Sill I see voltage ramp-up.

I am trying to find the cause of voltage ramping to 1.2V in hope that
the reason for ramp down will be just inverted reflection.

With smartreflex disabled, there is no change in the voltage during
suspend; so the problem area seems to be smartreflex.

Best regards,
Sanjeev

> 
> Thanks,
> - Maxime
> 
> PS: if I was not clear, I can provide a console log that may be more
> explicit--just ask.
> 
> -- 
> Maxime Petazzoni
> Linux kernel & software dev
> MontaVista Software, Inc
> 