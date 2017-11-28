From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 09:16:48 -0800
Message-ID: <20171128171648.GF28152@atomide.com>
References: <20171127220833.GA10070@lenoch>
 <20171128073328.GF10757@kroah.com>
 <20171128085751.GA28256@lenoch>
 <20171128093054.GA20720@kroah.com>
 <20171128093948.GA21766@lenoch>
 <20171128141131.GR28152@atomide.com>
 <20171128142851.GA12849@lenoch>
 <20171128143913.GS28152@atomide.com>
 <20171128165802.GA2186@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171128165802.GA2186@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [171128 17:01]:
> On Tue, Nov 28, 2017 at 06:39:13AM -0800, Tony Lindgren wrote:
> > Limiting things to C1 with cpuidle is probably what you need
> > for having USB also working.
> 
> With echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state{1-6}/disable
> jitter is about 100us which is about 3x worse than with CONFIG_PM
> disabled (and much better when idling), but decoder works with
> occassional errors.

OK sounds like there is still something happening in the idle path
beyond WFI then.

> Anyway, it would be nice to find out why USB does not work with CONFIG_PM
> disabled :)

Sure.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
