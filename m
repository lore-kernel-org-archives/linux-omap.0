From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Fri, 28 Feb 2014 14:56:28 -0800
Message-ID: <20140228225627.GU13624@atomide.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393510711-4697-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140227 06:21]:
> Hi,
> 
> This patchset brings up USB Host ports and Ethernet port on
> the OMAP5 uEVM board.
> 
> It also does some cleanup with respect to DT clock binding
> for the mfd/omap-usb-host driver.
> 
> Please queue these for -next.
> 
> Lee,
> 
> I've folded some platform data dependent patches with mfd patches
> so that they don't break functionality when applied individually.
> You can safely pull in all MFD patches (1 to 6).
> 
> Tony & Benoit,
> 
> Can you please accept patches 7, 8 and 9?

Are 7, 8 and 9 safe to queue separately from the MFD changes
or do they need to wait for the MFD changes to get merged
first?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
