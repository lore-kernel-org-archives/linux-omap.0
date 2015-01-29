From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Supporting two SMSC9221 interfaces on GPMC in a dts
Date: Thu, 29 Jan 2015 08:20:20 -0800
Message-ID: <20150129162020.GA16250@atomide.com>
References: <CAK8F28=sANBtwDdg45MuVmrE89SBYtzBsZcPZoXo=AhOv0wpOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK8F28=sANBtwDdg45MuVmrE89SBYtzBsZcPZoXo=AhOv0wpOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Adding devicetree list to Cc as well if somebody has a good solution.

* Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150128 18:54]:
> Hi,
> 
> The Gumstix Tobi-Duo board has two SMSC9221 NICs attached to the GPMC
> interface of an OMAP3.  I'm trying to figure out how best to include
> both interfaces in the device tree file.
> With just one interface, I can #include "omap-gpmc-smsc9221.dtsi", add
> the extra board specific settings in to "ethernet@gpmc" in the board
> file as well as any settings needed for the gpmc.
>
> For two interfaces though, I can setup the gpmc details, configure one
> "ethernet@gpmc" node as before but then, need to manually create (i.e.
> copy the meat from the "omap-gpmc-smsc9221.dtsi") a second node.
 
Yeah I think this is how we did it for omap3-sbc-*.dts*.

> This works but seems, well, verbose.  Is there a way to setup multiple
> interfaces without having to duplicate the omap-gpmc-smsc9221.dtsi
> content?

Hmm I wonder if the "[PATCH] dtc: parser: Add label while overriding
nodes" would help with this too?

I agree it would be nice to be able to have device specific .dtsi
file that can be included multiple times for the most common devices.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
