From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is
 available.
Date: Thu, 12 Jan 2017 14:36:27 -0800
Message-ID: <20170112223627.GQ2630@atomide.com>
References: <1483964535-4298-1-git-send-email-jjhiblot@ti.com>
 <20170112223007.GP2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170112223007.GP2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170112 14:31]:
> * Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org> [170109 04:23]:
> > AHCI provides the register PORTS_IMPL to let the software know which port
> > is supported. The register must be initialized by the bootloader. However
> > in some cases u-boot doesn't properly initialize this value (if it is not
> > compiled with SATA support for example or if the SATA initialization fails).
> > The DTS entry "ports-implemented" can be used to override the value in
> > PORTS_IMPL.
> > Adding this entry in the dts allows us no to worry about what is done by
> > the bootloader.
> 
> Adding into omap-for-v4.11/dt thanks.

Actually not applying just yet as I just noticed you tagged this for stable.

Care to describe what breaks and on which devices without this patch?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
