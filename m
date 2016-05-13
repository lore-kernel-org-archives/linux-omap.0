From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 07/15] usb: musb: Handle cable status better for 2430
 glue layer
Date: Fri, 13 May 2016 13:09:02 -0700
Message-ID: <20160513200902.GB5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-8-git-send-email-tony@atomide.com>
 <20160512013303.GO5995@atomide.com>
 <20160513195631.GB1665@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513195631.GB1665@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 12:58]:
> On Wed, May 11, 2016 at 06:33:04PM -0700, Tony Lindgren wrote:
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -49,6 +49,9 @@ struct omap2430_glue {
> >  	enum musb_vbus_id_status status;
> >  	struct work_struct	omap_musb_mailbox_work;
> >  	struct device		*control_otghs;
> > +	bool			cable_connected;
> > +	bool			enabled;
> > +	bool			powered;
> 
> This variable is only used within omap2430_set_power(), so it can be
> local within that function to save a few bytes.

Well it needs to be static as we keep things powered only if
glue is enabled and cable is connected.

I'd rather not add any more static stuff that's not specific to the
glue instance.. Got any better ideas?

BTW, we still have also at least _glue remaining in the 2430 glue.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
