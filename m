From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 17:58:02 +0100
Message-ID: <20171128165802.GA2186@lenoch>
References: <20171127220833.GA10070@lenoch>
 <20171128073328.GF10757@kroah.com>
 <20171128085751.GA28256@lenoch>
 <20171128093054.GA20720@kroah.com>
 <20171128093948.GA21766@lenoch>
 <20171128141131.GR28152@atomide.com>
 <20171128142851.GA12849@lenoch>
 <20171128143913.GS28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171128143913.GS28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 06:39:13AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [171128 14:31]:
> > On Tue, Nov 28, 2017 at 06:11:31AM -0800, Tony Lindgren wrote:
> > > * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [171128 09:42]:
> > > > On Tue, Nov 28, 2017 at 10:30:54AM +0100, Greg KH wrote:
> > > > > bit-banging an ir decoder, ugh, you are in for a world of hurt.  Can't
> > > > > you put a chip on the device that does this for you in hardware?
> > > > 
> > > > OMAP has DM timer which can be externally trigered on edge. Perfect for
> > > > that purpose. But I cannot pinmux its input as hw designers did poor job.
> > > > And there are thousands of devices deployed.
> > > > 
> > > > So it is about a lot of soldering or providing software solution.
> > > > 
> > > > > Anyway, good luck!
> > > > 
> > > > A little pointer would increase "luck" by several order of magnitudes.
> > > 
> > > Hmm did you already try limiting cpuidle to C1 only in /sys?
> > 
> > I have CONFIG_CPU_IDLE=n, which should be the same. Is that right?
> 
> You will then use the omap3_pm_idle() that does not know much
> anything about latencies.
> 
> > > From what I recall you just set the latency to less than C2
> > > has. The cpuidle latencies are in struct omap3_idle_statedata
> > > omap3_idle_data[].
> > 
> > I disabled cpuidle and frequency scaling completely. The only thing that
> > make jitter difference is CONFIG_PM (see original thread).
> 
> Right as then omap3_pm_idle() is disabled and only WFI is done :)
> 
> Limiting things to C1 with cpuidle is probably what you need
> for having USB also working.

With echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state{1-6}/disable
jitter is about 100us which is about 3x worse than with CONFIG_PM
disabled (and much better when idling), but decoder works with
occassional errors.

Anyway, it would be nice to find out why USB does not work with CONFIG_PM
disabled :)

> > There's lot of pm_wkup interrupts with CONFIG_PM - order of magnitude
> > more than gp_timer.
> 
> Hmm yeah that is true. And idling and waking up devices also takes
> some time.

Thank you,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
