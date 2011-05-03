From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Staging: Westbridge: replace custom debug macros with
 pr_...() macros
Date: Tue, 3 May 2011 10:54:12 -0700
Message-ID: <20110503175412.GA18990@kroah.com>
References: <1304016521.3749.13.camel@sutharsan-laptop>
 <20110428194725.GB25302@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110428194725.GB25302-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sutharsan <sutharsan.tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.cross-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, srmt-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 28, 2011 at 12:47:25PM -0700, Greg KH wrote:
> On Thu, Apr 28, 2011 at 11:48:41AM -0700, Sutharsan wrote:
> > >From Sutharsan Ramamoorthy <srmt-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> > 
> > This patch replaces custom debug macros with Linux kernel's pr_...() macros.
> 
> Why not use the dev_dbg() and other macros instead of these?  You do
> have access to a struct device for all of these places in the code,
> right?

As I never got a response from you, I'm dropping this from my
patch-queue.  Please resend when you have addressed this issue.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
