From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MUSB: fix memory corruption when using more than max
	endpoints
Date: Mon, 15 Sep 2008 11:52:10 +0300
Message-ID: <20080915085210.GM759@gandalf.research.nokia.com>
References: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com> <20080910103616.GQ16796@gandalf.research.nokia.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080910103616.GQ16796-f9ZlEuEWxVfta4EC/59zMBl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 10, 2008 at 01:36:16PM +0300, ext Felipe Balbi wrote:
> Let's keep linux-usb on the loop for musb related patches ;-)
> 
> On Wed, Sep 10, 2008 at 08:53:56AM +0300, ext Kevin Hilman wrote:
> > There is no check if platform code passes in more endpoints (num_eps)
> > than the maximum number of enpoints (MUSB_C_NUM_EPS.)  The result is
> > that allocate_instance() happily writes past the end of 'struct musb'
> > corrupting memory.
> > 
> > The fix below increases the max to 32 (used on omap3) and also adds a
> > BUG() if the platform code requests more than the max.
> > 
> > This memory corruption was triggering various forms of crashes/panics
> > with kmem_cache_alloc() in the backtrace.
> > 
> > Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

Could you update this patch without the last change of max endpoints ???

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
