From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
 omap4430_phy_init function
Date: Mon, 28 Mar 2011 14:20:15 -0700
Message-ID: <20110328212015.GH30616@atomide.com>
References: <1300966722-10955-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1300966722-10955-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Hema HK <hemahk-l0cyMroinI0@public.gmane.org> [110324 04:36]:
> omap4430_phy_init() function can be called with no device pointer,
> to powerdown the PHY during board init when USB is disabled.
> Fix the function accordingly.

This should no longer be needed after merge commit
0df0914d414a504b975f3cc66ace0c16ef55b7f3.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
