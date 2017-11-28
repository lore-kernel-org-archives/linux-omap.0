From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 06:11:31 -0800
Message-ID: <20171128141131.GR28152@atomide.com>
References: <20171127220833.GA10070@lenoch>
 <20171128073328.GF10757@kroah.com>
 <20171128085751.GA28256@lenoch>
 <20171128093054.GA20720@kroah.com>
 <20171128093948.GA21766@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171128093948.GA21766@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [171128 09:42]:
> On Tue, Nov 28, 2017 at 10:30:54AM +0100, Greg KH wrote:
> > bit-banging an ir decoder, ugh, you are in for a world of hurt.  Can't
> > you put a chip on the device that does this for you in hardware?
> 
> OMAP has DM timer which can be externally trigered on edge. Perfect for
> that purpose. But I cannot pinmux its input as hw designers did poor job.
> And there are thousands of devices deployed.
> 
> So it is about a lot of soldering or providing software solution.
> 
> > Anyway, good luck!
> 
> A little pointer would increase "luck" by several order of magnitudes.

Hmm did you already try limiting cpuidle to C1 only in /sys?

>From what I recall you just set the latency to less than C2
has. The cpuidle latencies are in struct omap3_idle_statedata
omap3_idle_data[].

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
