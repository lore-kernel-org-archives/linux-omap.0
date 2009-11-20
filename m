From: Jean Pihet <jpihet@mvista.com>
Subject: Re: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 19:55:44 +0100
Message-ID: <200911201955.44354.jpihet@mvista.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com> <20091120162933.GC2354@mvista.com> <87my2h3v9t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hu47.mvista.com ([206.112.117.47]:44064 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1755000AbZKTSzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 13:55:54 -0500
In-Reply-To: <87my2h3v9t.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Maxime Petazzoni <mpetazzoni@mvista.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

On Friday 20 November 2009 19:29:02 Kevin Hilman wrote:
> Maxime Petazzoni <mpetazzoni@mvista.com> writes:
> > Hi,
> >
> > * Premi, Sanjeev <premi@ti.com> [2009-11-20 21:17:04]:
> >> I am facing a strange problem on OMAP3EVM after resuming from idle.
> >> When using OPP5, the VDD1 voltage ramps to 1.35V.
> >>
> >> However, when i go thru the idle/wakeup cycle, the voltage never
> >> ramps back to 1.35V but stays at 1.20V.
> >
> > I'm seeing some interesting behavior with the OPP values here, too, with
> > suspend/resume. I'm using SRF based PM and CPUFREQ. Here's what happens:
> >
> > When changing the CPU frequency through the scaling_setfreq knob of
> > CPUFREQ, the vdd{1,2}_opp values are updated accordingly. After a
> > suspend/resume cycles, the OPPs return to their pre-suspend values, all
> > is fine.
> >
> > But when changing the OPP values by hand through the vdd{1,2}_opp knobs,
> > the CPU frequency is changed accordingly, which is expected. But after a
> > suspend/resume cycle, the OPP values return to the value CPUFREQ set
> > them to (which may be different than the default OPP values of 3).
> >
> > Is this the normal behavior? Is cpufreq authoritative on the OPP values
> > on resume? Or should it follow whatever value was manually set before
> > suspending?
>
> FWIW, the vdd*_opp sysfs hooks were for initial debug/dev and should
> be considered experimental (a.k.a broken.) They will disappear from
> the PM branch shortly.
>
> CPUfreq should be the only interface used for DVFS.
Could the PM page on elinux.org be updated with that info? I am proposing to 
change it before you ask me ;p

>
> Kevin

Thanks,
Jean

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


