From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] usb: musb: Fix unbalanced platform_disable
Date: Thu, 15 Sep 2016 10:22:01 -0700
Message-ID: <20160915172200.syeyvwoka3senm23@atomide.com>
References: <20160914181019.22937-1-tony@atomide.com>
 <79edbb45-cf85-1aba-1d42-1897021e0904@redhat.com>
 <20160915144343.jpeoizgbw2o23iuc@atomide.com>
 <288e07e4-5dc3-3906-1aec-a24c0769972a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <288e07e4-5dc3-3906-1aec-a24c0769972a-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [160915 09:59]:
> Hi,
> 
> On 15-09-16 16:43, Tony Lindgren wrote:
> > * Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [160915 07:00]:
> > > Hi,
> > > 
> > > On 14-09-16 20:10, Tony Lindgren wrote:
> > > > Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> > > > for 2430 glue layer") moved PHY enable/disable calls to happen from
> > > > omap2430_musb_enable/disable(). That broke enumeration for several
> > > > devices as PM runtime in the PHY will never enable it.
> > > > 
> > > > The root cause of the problem is unpaired calls from musb_core.c to
> > > > musb_platform_enable/disable in musb_core.c as reported by
> > > > Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>.
> > > > 
> > > > As musb_platform_enable/disable are being called from various functions,
> > > > let's not attempt to make them paiered immediately. This would require
> > > > fixing all the callers like musb_remove.
> > > 
> > > Yeah, the sunxi glue actually has:
> > > 
> > > static void sunxi_musb_enable(struct musb *musb)
> > > {
> > >         struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
> > > 
> > >         glue->musb = musb;
> > > 
> > >         /* musb_core does not call us in a balanced manner */
> > >         if (test_and_set_bit(SUNXI_MUSB_FL_ENABLED, &glue->flags))
> > >                 return;
> > 
> > Heh we're trying to get to the "balanced manner" point hopefully soon :)
> > 
> > >         schedule_work(&glue->work);
> > > }
> > > 
> > > static void sunxi_musb_disable(struct musb *musb)
> > > {
> > >         struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
> > > 
> > >         clear_bit(SUNXI_MUSB_FL_ENABLED, &glue->flags);
> > > }
> > > 
> > > Note that since the glue struct is kzalloc-ed, this makes calling
> > > sunxi_musb_disable() from sunxi_musb_init() a nop, so if this
> > > needs a respin please drop the sunxi changes, they are not
> > > necessary.
> > 
> > Hmm we have sunxi_musb_probe() do platform_device_register_full(),
> > then musb_probe() happens, and calls musb_init_controller().
> > 
> > In musb_init_controller() we do musb_platform_init() that finally
> > calls sunxi_musb_init().
> > 
> > So the sunxi glue is kzalloc'ed and initialized already in
> > sunxi_musb_probe(), and musb parts are already initialized in
> > musb_init_controller().
> 
> Not really, musb_init_controller does little of interest before
> calling musb_platform_init(), which is a function pointer
> to sunxi_musb_init().
> 
> > I don't quite follow what you mean how it's a nop.. Care to
> > clarify that a bit? Maybe you're thinking we're calling it from
> > sunxi_musb_probe() instead?
> 
> Nope, I no the call chain, but nothing interesting happens between
> sunxi_musb_probe() and sunxi_musb_init().

OK thanks for confirming.

> > Anyways, calling sunxi_musb_disable() seems unnecessary from
> > sunxi_musb_init() because it does reset_control_deassert().
> > But that can be cleaned up later on if no other reasons for
> > changes for v4.8-rc cycle.
> 
> Ah is this patch for 4.8-rc, yeah then definitely keep it as
> is, as I tried to explain in my previous mail, my remark
> was only made in case you need to respin the patch for other
> reasons, if not then it is fine as is.

OK thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
