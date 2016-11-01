From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Tue, 1 Nov 2016 22:13:58 +0100
Message-ID: <20161101211358.GA2597@localhost.localdomain>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161024180708.kpx6s2jb7dpg6xfx-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Oct 24, 2016 at 11:07:08AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161021 00:18]:
> > * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 12:37]:
> > > [  186.457519] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_bcon (90, <VBusValid), retry #3, port1 0008010c
> > > 
> > > And that's the end, since now it does not react on hub plug/unplug.
> > > 
> > > Also all that VBUS_ERROR conditions are strange as hub is powered separately
> > > and power lines from phy are not used.
> > 
> > Hmm yeah. I'd like to be able to reproduce this. Can you email me
> > your .config (again)? You have things in host mode with a powered
> > hub plus few devices with no USB gadgets configured?
> 
> Well I found your earlier .config so presumably that did not change.
> Below patch seems to do the trick for me, but I need to test more.
> 
> Care to test if it helps for you? Please test with v4.9-rc2 and the
> following two fixes heading in Greg's usb-linus branch:
> 
> cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
> d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order error")

tested with v4.9-rc3 which have these included.

> I'll send a proper patch if that works for you.

Unfortunately it's still the same. Direct connection (without hub) remains
untested as there's not enough power to supply display:
usb 2-1: USB disconnect, device number 2
usb 2-1: new high-speed USB device number 3 using musb-hdrc
usb 2-1: New USB device found, idVendor=17e9, idProduct=0335
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: Product: MIMO
usb 2-1: Manufacturer: DisplayLink
usb 2-1: SerialNumber: 1071007195
usb 2-1: rejected 1 configuration due to insufficient available bus power
usb 2-1: no configuration chosen from 1 choice

Regards,
	ladis

> Regards,
> 
> Tony
> 
> 8< ------------------------
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -459,8 +459,6 @@ static int twl4030_phy_power_off(struct phy *phy)
>  	struct twl4030_usb *twl = phy_get_drvdata(phy);
>  
>  	dev_dbg(twl->dev, "%s\n", __func__);
> -	pm_runtime_mark_last_busy(twl->dev);
> -	pm_runtime_put_autosuspend(twl->dev);
>  
>  	return 0;
>  }
> @@ -472,6 +470,8 @@ static int twl4030_phy_power_on(struct phy *phy)
>  	dev_dbg(twl->dev, "%s\n", __func__);
>  	pm_runtime_get_sync(twl->dev);
>  	schedule_delayed_work(&twl->id_workaround_work, HZ);
> +	pm_runtime_mark_last_busy(twl->dev);
> +	pm_runtime_put_autosuspend(twl->dev);
>  
>  	return 0;
>  }
> -- 
> 2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
