From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [patch-v2.6.39 08/12] usb: otg: OMAP4430: Introducing suspend
 function for power management
Date: Thu, 24 Feb 2011 13:31:43 -0800
Message-ID: <20110224213142.GP20560@atomide.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-9-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297946329-9353-9-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [110217 04:37]:
> From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> 
> Introduced the suspend/resume function for the OMAP4430 internal PHY.
> This will be used by the twl6030-usb transceiver driver.
> Moved the clock enable/disable function calls and power on/off of the PHY
> code from power on/off functions to suspend/resume function.
> 
> Pass the suspend function through board data for OMAP4430sdp and OMAP4panda.
> This will be used by the twl6030-usb transceiver driver.
> 
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
