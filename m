From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP2+: Remove unused MUSB initialization code
Date: Thu, 10 Nov 2016 10:54:02 -0700
Message-ID: <20161110175402.GE27724@atomide.com>
References: <1478799800-27945-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478799800-27945-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161110 10:43]:
> With the removal of board-ldp.c and board-rx51.c, the last users of the
> MUSB initialization board code are gone. Remove it.

Thanks, I have the same patch already from 3 years ago
in omap-for-v3.14/omap3-board-removal branch that I'll
use. Still need to rebase and check few other patches
there before reposting them all. FYI, to avoid duplicate
work, the old barnch is at [0].

Regards,

Tony

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.14/omap3-board-removal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
