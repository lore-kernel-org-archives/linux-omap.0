From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Thu, 6 Dec 2012 10:25:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1212061012570.1383-100000@iolanthe.rowland.org>
References: <50BFE159.1010009@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <50BFE159.1010009@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ming Lei <tom.leiming@gmail.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Dec 2012, Andy Green wrote:

> > Right.  The question is should it be done in this somewhat roundabout
> > way (you've got two separate assets for setting up this one thing), or
> > should the USB port code be responsible for explicitly checking if
> > there are any applicable assets when the port is created?
> >
> > The advantange of the second approach is that it doesn't involve
> > checking all the ancestors every time a new device is added (and it
> > involves only one asset).  The disadvantage is that it works only for
> > USB ports.
> 
> It's done in two steps to strongly filter candidate child devices 
> against being children of a known platform device.  If you go around 
> that, you will be back to full device path matching with wildcards at 
> the USB child to determine if he is "the one".  So that's a feature not 
> an issue I think.

I don't follow.  Suppose an asset is attached to ehci-omap.0 with its
string set to "-0:1.0/port1" and the other members pointing to the
regulator, clock and so on.  And suppose the USB port code, when
creating a new port, checks for a name match against all the assets
attached to its bus's host controller device structure.  That should
do exactly what you want while using only one asset.

> I can see doing it generically or not is equally a political issue as a 
> technical one, but I think if we bother to add this kind of support we 
> should prefer to do it generally.  It's going to be about the same 
> amount of code.

Not quite.  If you do it generally then you have to insert hooks at all 
the places where a subsystem _might_ need it.  If you do it 
specifically then no hooks are needed at all -- just a match call at 
the right place in the subsystem that needs it.

> As Tony Lindgren said, even board-omap4panda.c itself is deprecated, to 
> project platform info into USB stack you either have to add DT code into 
> usb stack then to go find things directly, or provide a generic 
> methodology like assets which have the dt bindings done outside of any 
> subsystem and apply their operations outside the subsystem too.

Assuming DT can be extended to support assets, adding one asset will be 
simpler than adding two.

> > To answer the question, we need to know how other subsystems might
> > want to use the asset-matching approach.  My guess is that only a small
> > number of device types would care about assets (in the same way that
> > assets matter to USB ports but not to other USB device types).  And it
> > might not be necessary to check against every ancestor; we might know
> > beforehand where to check (just as the USB port would know to look for
> > an asset attached to the host controller device).
> 
> Yes I think it boils down to "buses" in general can benefit from this. 
> They're the thing that dynamically - later - create child devices you 
> might need to target with what was ultimately platform information.
> 
> On Panda the other bus thing that can benefit is the WLAN module on 
> SDIO.  In fact that's a very illuminating case for your question above. 
>   Faced with exactly the same problem, that they needed to project 
> platform info on to SDIO-probed device instance to tell it what clock 
> rate it had been given, they invented an api which you can see today in 
> board-omap4panda.c and other boards there, wl12xx_set_platform_data(). 
> This is from board-4430sdp:
> 
> static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata = {
>          .board_ref_clock = WL12XX_REFCLOCK_26,
>          .board_tcxo_clock = WL12XX_TCXOCLOCK_26,
> };
> 
> ...
> 
> 	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
> 
> You can find the other end of it here in 
> drivers/net/wireless/ti/wlcore/wl12xx_platform_data.c
> 
> static struct wl12xx_platform_data *platform_data;
> 
> int __init wl12xx_set_platform_data(const struct wl12xx_platform_data *data)
> {
> 	if (platform_data)
> 		return -EBUSY;
> 	if (!data)
> 		return -EINVAL;
> 
> 	platform_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
> 	if (!platform_data)
> 		return -ENOMEM;
> 
> 	return 0;
> }
> 
> when the driver for the device instance wants to "get" its platform data 
> it reads the static pointer via another api.  Obviously if you want two 
> modules on your platform that's not so good.

Also it isn't type-safe, although that's probably not a big concern.

> I doubt that's the only SDIO device that wants to know platform info. 
> So I think by providing a generic way we help other buses and devices.

I agree, assets look like a good way to improve this.  In fact, to some
extent assets appear to be a generalization or extension of platform
data.

Alan Stern

