From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/8]usb: musb:USB driver changes to use hwmod+ omap-device
 apis
Date: Mon, 09 Aug 2010 14:32:04 +0200
Message-ID: <4C5FF544.9050907@ti.com>
References: <1281110052-28990-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281110052-28990-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: HEMA HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/6/2010 5:54 PM, HEMA HK wrote:
> From: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>
> Series of patches to port musb driver to use hwmod and runtime pm
> APIs for OMAP4 and OMAP3.These patches are tested on OMAP4430SDP and
> OMAP3630-ZOOM3 boards.
>
> The patch 1 and 2 are are the prerequisites for the hwmod changes.
> Patch 6 is the OMAP3 offmode support patch.
>
> This patch series is generated on "origin/pm-wip/hwmods-omap4".
>
> Offmode is tested with origin/pm on omap3630 zoom3 board.

The way you are submitting that series is quite confusing!

You are mixing several numbering schemes and several series versions.
If this is a V2, you have to resubmit everything with a V2, and you must 
include an history.

[8/8] usb : musb:Using runtime pm apis for musb.  	
[7/8] : Hwmod api changes
[V2,6/8] usb: musb: Offmode fix for idle path
[V2,4/8] usb : musb:Using omap_device_build for musb device registration
[4/8] usb: musb: HWMOD database structures fixes OMAP4
[V2,3/4] usb: musb: HWMOD database structures addition for OMAP3
[2/8] usb: musb: Remove board_data parameter from musb_platform_init()
[1/8] usb: musb: Adding names for IRQs in resource structure


The cover letter does not contain the overall stat to summarize what 
files you are modifying.

Some spaces are missing after the ":" in the email subjects.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
