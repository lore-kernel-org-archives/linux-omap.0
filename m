From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: phy: Implement am335x advisory 1.0.34
Date: Fri, 20 Jan 2017 14:31:06 -0600
Message-ID: <20170120203106.GF14571@uda0271908>
References: <20170120200104.16921-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170120200104.16921-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 20, 2017 at 12:01:04PM -0800, Tony Lindgren wrote:
> I noticed in sprz360i.pdf there's "Advisory 1.0.34 USB2PHY: Register
> Accesses After a USB Subsystem Soft Reset May Lock Up the Entire System"
> that seems to affect am335x revisions 1.0, 2.0 and 2.1:
> 
> "The synchronization bridge connecting the USB2PHY register interface
>  to the L3S interconnect may hang and lock up the entire system. When
>  there is a sequence of any USB2PHY register access, followed by a USB
>  subsystem soft reset initiated with the SOFT_RESET bit in the SYSCONFIG
>  register, followed by any USB2PHY register access, the L3S interconnect
>  may hang on the second USB2PHY register access."

I understand this patch adds runtime PM in the am335x phy driver, but the
message above is irrelevant. This advisory is meant for the PHY
registers, not the phy-ctrl registers in the USBSS wrapper. Currently we
don't touch any PHY register in any driver.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
