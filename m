From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and
 CPSW
Date: Tue, 22 Jul 2014 18:53:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407221853340.25593@utopia.booyaka.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com> <20140709095552.GA25154@breakpoint.cc> <20140709100147.GB25154@breakpoint.cc> <alpine.DEB.2.02.1407152019020.21432@utopia.booyaka.com> <20140716070643.GC3378@breakpoint.cc>
 <alpine.DEB.2.02.1407161854360.23074@utopia.booyaka.com> <20140717075028.GG18374@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140717075028.GG18374-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Jul 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> [140716 11:59]:
> > On Wed, 16 Jul 2014, Sebastian Andrzej Siewior wrote:
> > 
> > > On 2014-07-15 20:21:21 [+0000], Paul Walmsley wrote:
> > > 
> > > > > Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
> > > > > 
> > > > > This is basically what Tony hasked me to do: No IRQ numbers & iomem.
> > > > 
> > > > Sorry - I'm a bit confused - Sebastian, did you test this one?  If so, is 
> > > > it okay to add a Tested-by from you?
> > > 
> > > Tested-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
> > 
> > Thanks Sebastian.
> > 
> > Mugunthan, next step would be for you to get a Reviewed-by: by someone who 
> > has access to the (non-public) DRA7xx TRM, and can review for SoC 
> > integration.  Since Rajendra is no longer at TI, the right person is 
> > probably Tony.
> > 
> > Then this patch should be mergeable.
> 
> Yeah took a look at it and acked it.

Thanks queued for 3.17.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
