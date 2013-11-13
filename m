From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv3 0/8]  omap hwspinlock dt support
Date: Wed, 13 Nov 2013 09:36:22 +0000
Message-ID: <20131113093622.GA21713@e106331-lin.cambridge.arm.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
 <5282708A.30601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5282708A.30601-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 12, 2013 at 06:16:42PM +0000, Anna, Suman wrote:
> 
> > Hi,
> >
> > This is an updated series addressing the review comments from the
> > v2 series. The hwmod patches have been dropped from the repost
> > as per Paul's request, they have already been queued.
> 
> Mark,

Hi Suman,

> 
> Any comments on this series? Tony has picked up the OMAP DTS patches for 
> 3.13, and so
> the "ti,omap4-hwspinlock" compatible string is showing up as 
> undocumented in linux-next.
> How do you want me to proceed here? I will be separating out the 
> bindings into separate patches
> in the future.

The only thing I note that I'm not so keen on is that the
hwlock-specifier is always one cell, rather than using a #hwlock-cells
property on the provider (even if we required it to be <1> for the
moment and just failed if it wasn't).

If possible, I would like an amendment to always use #hwlock-cells, but
otherwise this looks fine to me. Feel free to add my Ack:

Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
