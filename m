From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3 v5] AM35x: Add musb support
Date: Mon, 4 Oct 2010 10:28:14 -0700
Message-ID: <20101004172813.GV3117@atomide.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <20101001060037.GC2925@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101001060037.GC2925-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [100930 22:52]:
> Hi,
> 
> On Thu, Sep 30, 2010 at 12:19:07AM -0500, Gupta, Ajay Kumar wrote:
> >AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
> >It has USB phy built inside the IP itself.
> >
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> besides the one small question below:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Felipe, I'm assuming you're queuing up the omap USB platform data
patches. So not picking up these patches.

Also, please also note that the arch/arm/*omap*/ patches should
be posted with both linux-omap and linux-arm-kernel mailing lists
Cc'd.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
