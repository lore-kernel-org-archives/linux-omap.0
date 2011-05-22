From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RESEND][PATCH 4/5] arm: omap: usb: Runtime PM support
Date: Sun, 22 May 2011 22:53:54 +0200
Message-ID: <20110522205353.GK18610@sortiz-mobl>
References: <1305538732-21087-1-git-send-email-keshava_mgowda@ti.com>
 <20110518104806.GB13908@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110518104806.GB13908-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Wed, May 18, 2011 at 01:48:09PM +0300, Felipe Balbi wrote:
> On Mon, May 16, 2011 at 03:08:52PM +0530, Keshava Munegowda wrote:
> > From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> > 
> > The usbhs core driver does not enable/disable the intefrace and
> > fucntional clocks; These clocks are handled by hwmod and runtime pm,
> > hence insted of the clock enable/disable, the runtime pm APIS are
> > used. however,the port clocks and tll clocks are handled
> > by the usbhs core.
> > 
> > Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> 
> Samuel how do we solve this series ? I can take the arch/arm/*omap*/
> patches through Tony's tree, can you take the drivers/mfd/* via you
> tree ?
I'm taking this one. Let's hope the conflicts are not too bad.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
