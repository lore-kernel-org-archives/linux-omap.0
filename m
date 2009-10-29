From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH] omap-pm: Fixes behaviour of some shared resource
 framework functions
Date: Thu, 29 Oct 2009 13:42:40 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DDEF056E@dnce01.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com><87iqejktan.fsf@deeprootsystems.com><alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com><003201ca581b$256863c0$544ff780@am.dhcp.ti.com>
 <87hbtj3zpc.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbZJ2Mmm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 08:42:42 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: 'Paul Walmsley' <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Titiano, Patrick" <p-titiano@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Hi Romit,

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Dasgupta, Romit
>
> Paul/Kevin,
>                       As Madhu explained it looks like there are instances
> where we forcibly need to bump up to a higher CPU + L3 frequencies (VDD1 +
> VDD2 scaling). I understand that this should be done by cpufreq governors
> but here is reason that I think the current cpufreq governors won't be
> able to handle.
>
> Large latency response:
>
>      The sampling intervals for the cpufreq governors are quite large and
> thus the latency for the frequency change to occur is large. This was seen
> in Android UI responsiveness. The initial response of the UI seems to be
> quite sluggish until after a while when the cpufreq governors would catch
> up to the required MIPS.  I know that Patrick (Cc'd) did some experiments
> with conservative governor but my understanding is that it still has this
> basic problem.

In fact, this is Mike who started that analysis. We discussed that internally and our point is that if the CPUFreq ondemand or conservative heuristic is not able to increase quickly enough the CPU need to handle correctly the UI, we have to somehow improve or modify the governor in order to provide it a extra information in term of constraint maybe in order to increase immediately the frequency.

This should not be done in the low level omap_pm code; this is not the right level to do that. The issue is in the ondemand and must be fixed there.

Regards,
Benoit


> Tied to the above is necessity for high MIPS for short duration:
>
> I also presume that there might be situations where we need very high MIPS
> but for a very very short interval of time. This would never bump up the
> frequency as it would more or less be ignored by the cpufreq governors.
>
> Please let me know what you think.
> Thanks,
> -Romit
>
>
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Thursday, October 29, 2009 4:15 AM
> > To: Chikkature Rajashekar, Madhusudhan
> > Cc: 'Paul Walmsley'; Dasgupta, Romit; 'linux-omap@vger.kernel.org'
> > Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource
> > framework functions
> >
> > "Madhusudhan" <madhu.cr@ti.com> writes:
> >
> > >> -----Original Message-----
> > >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > >> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > >> Sent: Wednesday, October 28, 2009 1:38 PM
> > >> To: Kevin Hilman
> > >> Cc: Dasgupta\, Romit; linux-omap\@vger.kernel.org
> > >> Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource
> > >> framework functions
> > >>
> > >> On Tue, 13 Oct 2009, Kevin Hilman wrote:
> > >>
> > >> > "Dasgupta, Romit" <romit@ti.com> writes:
> > >> >
> > >> > > (Tested on Zoom2).
> > >> > >
> > >> > > 'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using
> > their
> > >> own
> > >> > > struct device *. This is a problem because invoking these
> functions
> > >> from
> > >> > > different clients would result in setting of the resource level
> as
> > >> requested by
> > >> > > the last caller. Fixes this by introducing a struct device * to
> the
> > >> parameter
> > >> > > list for these functions.
> > >> > > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > >> >
> > >> >
> > >> > This looks like the right fix to me.
> > >> >
> > >> > Paul, any comments?
> > >>
> > >>
> > >> Wait a minute, I am retracting my ack.
> > >>
> > >>
> > >> Romit, the only caller of omap_pm_dsp_set_min_opp() should be
> > DSPBridge
> > >> and the only caller of omap_pm_cpu_set_freq() should be CPUFreq.  So
> the
> > >> struct device * pointer is not necessary, unless I am missing
> something.
> > >> Can you please explain what you're trying to do?
> > >>
> > > I believe that omap_pm_cpu_set_freq() can be called by drivers to
> setup the
> > > optimal vdd1 opp, right? For example MMC works at opp1 but the
> > performance
> > > is certainly better at opp3.When ondemand is enabled drivers need to
> put
> > > certain constraints on vdd1 opp otherwise performance will be hurt. So,
> if
> > > the API takes care of device level calls then drivers can call this fn.
> >
> > So, the root use case is a power vs. performance policy decision.  And
> > using the proposed solution, a single driver gets to make a system
> > wide policy decision.  I don't like this.
> >
> > For your MMC usecase, I think we need some clarifications.
> >
> > What exactly does "better" performance mean.  Is it better throughput
> > that is needed?  or is it really the MPU side that is not
> > running/responding fast enough.
> >
> > If it's throughput, then omap_pm_set_min_bus_tput() should be used.
> >
> > If it's the MPU, what exactly is the problem with ondemand.  Is it
> > that it doesn't respond fast enough?  Or that it never switches to a
> > higher OPP.
> >
> > Kevin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


