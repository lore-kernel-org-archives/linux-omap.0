From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Westbridge software module, fixes errors reported by
 checkpatch.pl
Date: Fri, 21 Jan 2011 12:33:52 -0800
Message-ID: <20110121203352.GD22299@kroah.com>
References: <444938.26253.qm@web121610.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <444938.26253.qm-bemt2lWHc5TnPdaBJcMgDZOW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sutharsan Ramamoorthy <sutharsan.ramamoorthy-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.cross-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, srmt-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 19, 2011 at 05:31:46PM -0800, Sutharsan Ramamoorthy wrote:
> From: Sutharsan Ramamoorthy <srmt-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> 
> This patch fixes errors in westbridge device controller driver in the 
> staging tree reported by checkpatch.pl. File containing EXPORT_SYMBOL() 
> macros for all the APIs exported by the westbridge software has been removed. EXPORT_SYMBOL() macros are added after the corresponding function definitions.

In the future, please wrap your commit messages at 72 characters, so I
don't have to edit the patch by hand.

Your subject was also quite vague, I've fixed it up, please be more
careful in the future.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
