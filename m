From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 16:18:52 -0700
Message-ID: <20160412231852.GM5995@atomide.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
 <570D7922.5020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570D7922.5020206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160412 15:40]:
> On 4/12/2016 1:13 PM, Frank Rowand wrote:
> > Hi Tony,
> 
> < snip >
> 
> > With that change, the bulk of your patch looks good, with
> > minor changes:
> > 
> >   __of_device_is_available() would not need to change.
> > 
> >   __of_device_is_incomplete() would change to check the new
> >   boolean property.  (And I would suggest renaming it to
> >   something that conveys it is ok to power manage the
> >   device, but do not do anything else to the device.)
> > 
> > -Frank
> 
> One more thought...
> 
> Are there multiple drivers that need to follow this
> pattern, or just one at the moment?  If just one driver,
> then I would suggest open-coding accessing the property
> in the probe routine instead of adding the helper
> functions.  If more drivers appear with the same
> pattern then the helper functions could be added.

Well we already have several workarounds for devices to reset
them for idle by accessing the device registers:

omap_dss_reset
omap_hdq1w_reset
omap_i2c_reset

At least the three above are doing access to the device
registers partially duplicating the driver probe functionality.

Then the PM init code has some workarounds ti idle device
wrapper IP on SoCs that don't have the video or modem:

omap3xxx_prm_iva_idle
omap3_prm_reset_modem

And I'm just aware of the ones that we have in the mainline kernel
for PM to work. I bet Nishanth has more examples in mind where the
bootloader needs set devices to incomplete state based on
the SoC revision.

In general, I would rather see board specific dts files set
the unused devices to incomplete status rather than set them
to disabled. If they are set to disabled, from PM point of
view SoC specific workarounds are needed to idle them.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
