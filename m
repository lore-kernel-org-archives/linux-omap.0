From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Mon, 12 Sep 2016 11:33:10 -0700
Message-ID: <20160912183309.s4cwccth4tzcucjq@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <20160912165455.GE18340@uda0271908>
 <20160912171938.5fmx2qi6xtzsohpy@atomide.com>
 <20160912173406.6qalsmolsylc2suq@atomide.com>
 <20160912200530.69cb195d@aktux>
 <20160912181229.nl56kapwcfok352b@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160912181229.nl56kapwcfok352b-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160912 11:13]:
> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160912 11:05]:
> > On Mon, 12 Sep 2016 10:34:08 -0700
> > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > 
> > > Oh I see davinci_musb_disable and am35x_musb_disable reset devctl and
> > > clear interrupts. I'll try to check on am3517 here today, don't have
> > > any davinci boards configured here.
> > > 
> > Hmm, then the question is: Couldn't the X_musb_disable simply be called
> > from X_probe if needed to be an the safe side?
> 
> Yes agreed, that's the sane way to deal with any potential issues
> there.

And looks like musb on am3517 has been broken for years, we don't
even have a PHY for it.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
