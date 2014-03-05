From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
Date: Wed, 5 Mar 2014 10:10:45 -0800
Message-ID: <20140305181045.GH4983@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
 <20140304173200.GA17470@atomide.com>
 <5316217C.2070906@ti.com>
 <20140304212811.GA8705@atomide.com>
 <5316DCF6.6070808@ti.com>
 <20140305170857.GD4983@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140305170857.GD4983-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [140305 09:12]:
> * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [140305 00:17]:
> > On 03/04/2014 11:28 PM, Tony Lindgren wrote:
> > >* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [140304 10:58]:
> > >>On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> > >>>* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [140304 01:22]:
> > >>>>This is no longer needed as clock data is provided through DT.
> > >>>
> > >>>Looks like there's a new error even before applying this patch in
> > >>>the series as I'm now getting the following oops on n8x0. So cannot
> > >>>test this patch yet.
> > >>
> > >>Is this with OMAP2 only boot?
> > >
> > >Yeah that's with omap2 only.
> > 
> > That explains it, as previous series was never boot tested in omap2
> > only config (due to build issues.)
> > 
> > I just force pushed the branch with the below additional patch, can
> > you check if it works now?
> 
> Yes seems to work with that thanks. And with the omap2 legacy clock
> data removed too, it boots fine on n8x0 and 2430sdp.
> 
> I suggest you drop the omap3 legacy data patch from this branch
> as it's not omap2 related and cannot be done yet. Then try to get
> acks from Paul. And if there are no issues, it seems Mike could take
> the whole branch as it seems to merge just fine with what I have
> queued. So for all the patches except for the omap3 legacy data
> removal, feel free to add:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Found one randconfig error with this series when CONFIG_ARCH_OMAP2
is not set:

/drivers/clk/ti/dpll.c:273: undefined reference to `omap2xxx_clkt_dpllcore_init'
drivers/clk/ti/dpll.c:311: undefined reference to `clkhwops_omap2xxx_dpll'

It's also possible the error is the PRM clean up series, but probably
in this series based drivers/clk/ti/dpll.c path.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
