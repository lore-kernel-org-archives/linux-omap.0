From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 4 Nov 2016 01:09:03 +0100
Message-ID: <20161104000903.GA27632@localhost.localdomain>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
 <20161101211358.GA2597@localhost.localdomain>
 <20161103205902.GB21430@atomide.com>
 <20161103225532.GD21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103225532.GD21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 03, 2016 at 03:55:32PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161103 13:59]:
> > * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161101 14:14]:
> > > > cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
> > > > d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order error")
> > > 
> > > tested with v4.9-rc3 which have these included.
> > 
> > OK thanks.
> 
> So here's something to test, v4.9-rc3 + the PHY patch I
> posted + the patch below.
> 
> > Hmm yeah playing with a hub connected devices don't always enumerate.
> > When that happens, I get this:
> > 
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: USB disconnect, device number 45
> > usb 1-1: new high-speed USB device number 47 using musb-hdrc
> > usb 1-1: new high-speed USB device number 48 using musb-hdrc
> > ...
> > 
> > And that keeps on going until I reconnect the hub.
> 
> The patch below seems to work with PM for me, except I
> the dsps glue layer won't go to idle after disconnecting
> the hub. On 2430 glue layer things idle for me properly
> and I don't seem to get any more vbus errors.

Well, at least musb reacts on hub disconnects now. Devices
get enumerated, but do not work. Also musb does notice
only hub connect/disconnect, but does not react on
disconnection of devices in hub.

Best regards,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
