From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: OMAP3xxx: Fix device detection in otg &
 host mode
Date: Tue, 1 Mar 2011 11:37:39 +0200
Message-ID: <20110301093739.GF2942@legolas.emea.dhcp.ti.com>
References: <1298885729-7938-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298885729-7938-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 03:05:29PM +0530, Hema HK wrote:
> In OMAP3xxx with OTG mode or host only mode, When the device
> is inserted after the gadget driver loading the enumeration was not
> through. This is because the mentor controller will start sensing the
> ID PIN only after setting the session bit.
> So after ID-GND, need to set the session bit for mentor to get it
> configured as A device.
> 
> This is a fix to set the session bit again in ID_GND notification handler.
> Tested with OMAP3630Zoom3 platform.
> 
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

applied, thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
