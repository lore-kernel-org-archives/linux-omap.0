From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 07/15] usb: musb: Handle cable status better for 2430
 glue layer
Date: Fri, 13 May 2016 13:33:30 -0700
Message-ID: <20160513203330.GC5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-8-git-send-email-tony@atomide.com>
 <20160512013303.GO5995@atomide.com>
 <20160513195631.GB1665@uda0271908>
 <20160513200902.GB5995@atomide.com>
 <20160513202155.GA31180@uda0271908>
 <20160513202426.GB31180@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513202426.GB31180@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 13:26]:
> On Fri, May 13, 2016 at 03:21:55PM -0500, Bin Liu wrote:
> > On Fri, May 13, 2016 at 01:09:02PM -0700, Tony Lindgren wrote:
> > > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 12:58]:
> > > > On Wed, May 11, 2016 at 06:33:04PM -0700, Tony Lindgren wrote:
> > > > > --- a/drivers/usb/musb/omap2430.c
> > > > > +++ b/drivers/usb/musb/omap2430.c
> > > > > @@ -49,6 +49,9 @@ struct omap2430_glue {
> > > > >  	enum musb_vbus_id_status status;
> > > > >  	struct work_struct	omap_musb_mailbox_work;
> > > > >  	struct device		*control_otghs;
> > > > > +	bool			cable_connected;
> > > > > +	bool			enabled;
> > > > > +	bool			powered;
> > > > 
> > > > This variable is only used within omap2430_set_power(), so it can be
> > > > local within that function to save a few bytes.
> > > 
> > > Well it needs to be static as we keep things powered only if
> > > glue is enabled and cable is connected.
> > 
> > I think it does not have to static in omap2430_glue, how about in the
> 
> I meant in omap2430_set_power().
> 
> > very beginning of omap2430_set_power(),
> > 
> > 	bool powered = glue->enabled && glue->cable_connected;
> > 
> > before changing glue->enabled and glue->cable_connected, then this
> > local powered variable is equivalent to glue->powered.

Hmm but pm_runtime_get_sync() can fail too. I was seeing -EACCES
there while chasing various PM runtime issues. That can happen for
example if the parent and child PM runtime use counts get out of sync
like happened in the -EPROBE_DEFER case. Now we at least know if
something goes wrong with the "could not enable" error.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
