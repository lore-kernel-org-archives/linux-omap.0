From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix locking errors for host only mode
Date: Fri, 26 Aug 2016 07:57:39 -0700
Message-ID: <20160826145738.ptsdhdbcn3vudszb@atomide.com>
References: <1471560038-6243-1-git-send-email-tony@atomide.com>
 <20160825171833.GD4050@uda0271908>
 <20160826143904.ew3cufraegj7rbjm@atomide.com>
 <20160826145626.GA4159@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160826145626.GA4159@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160826 07:57]:
> On Fri, Aug 26, 2016 at 07:39:05AM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160825 10:19]:
> > > Hi,
> > > 
> > > On Thu, Aug 18, 2016 at 03:40:38PM -0700, Tony Lindgren wrote:
> > > > If we have USB gadgets disabled and USB_MUSB_HOST set, we get
> > > > errors "possible irq lock inverssion dependency detected"
> > > > errors during boot.
> > > > 
> > > > Let's fix the issue by adding start_musb flag and start
> > > > the controller after we're out of the spinlock protected
> > > > section.
> > > > 
> > > > Reported-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > > > Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > Signed-off-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> > 
> > Bin, your Signed-off-by here suggests you've committed this to
> > a fixes branch somewhere but I can't see it in next. Are you
> > going to send a pull request for it or what's the plan?
> > Just wondering.. Also added Greg to Cc.
> 
> I don't have a public git repo to host my musb maintenance work yet, and
> I don't have a plan to create one since there aren't many musb patches
> from the community.  So far I have been managing all the patches in my
> local tree, and sending patch bombs to Greg. Your this patch will be
> sent to Greg today or tomorrow.

OK so no need for me to do anything then. Thanks for the update.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
