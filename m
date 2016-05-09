From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 02/10] usb: musb: Fix idling after host mode by
 increasing autosuspend delay
Date: Mon, 9 May 2016 12:57:24 -0700
Message-ID: <20160509195724.GL5995@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
 <1461864800-29979-3-git-send-email-tony@atomide.com>
 <20160505150159.GA25950@uda0271908>
 <20160505170439.GX5995@atomide.com>
 <20160505174742.GF22575@uda0271908>
 <87k2j7it0f.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87k2j7it0f.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160505 23:49]:
> 
> Hi,
> 
> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
> >> Does the current 200 ms autosuspend timeout relate to anything real
> >> other than what I found out with my measurements?
> >
> > Not sure, I didn't checkk where the 200ms comes from.
> 
> It was an arbitrary number from when runtime PM was first added by
> Hema. I don't think it has any esoteric meaning ;-)

OK thanks for clarifying that. I'll add a comment for the 500 ms
value in the patch so we will remember why it is set.

Tony


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
