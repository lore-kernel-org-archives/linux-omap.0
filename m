From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 7/7] ARM: dts: am335x-boneblack: Use new binding for
 HDMI
Date: Fri, 6 Mar 2015 08:58:20 -0800
Message-ID: <20150306165819.GR13520@atomide.com>
References: <cover.1425656120.git.jsarha@ti.com>
 <e68f9647bff12fda5c70b3f068d3feb3911bca91.1425656120.git.jsarha@ti.com>
 <20150306153632.GL13520@atomide.com>
 <54F9CE53.908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F9CE53.908-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [150306 07:57]:
> On 03/06/15 17:36, Tony Lindgren wrote:
> >* Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [150306 07:37]:
> >>Use new binding for the external tda19988 HDMI encoder.
> >
> >Can this be merged separately after the driver code is
> >merged with things still working?
> >
> 
> Yes absolutely. That is why DRM_TILCDC_SLAVE_COMPAT is there for.

Great, thanks for sorting it out properly. Please ping me to
apply this patch when the driver changes are in Linux next.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
