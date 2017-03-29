From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 2/3] usb: musb: Add support of CPPI 4.1 DMA controller
 to DA8xx
Date: Wed, 29 Mar 2017 11:43:41 -0500
Message-ID: <20170329164341.GA5695@uda0271908>
References: <20170329162432.27299-1-abailon@baylibre.com>
 <20170329162432.27299-3-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170329162432.27299-3-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 29, 2017 at 06:24:31PM +0200, Alexandre Bailon wrote:
> Currently, only the PIO mode is supported.
> This add support of CPPI 4.1 to DA8xx.
> As the In DA8xx the CPPI 4.1 DMA is a part of the USB.
> Create the CPPI 4.1 device as a child of USB.

As in DA8xx the CPPI 4.1 DMA is a part of the USBSS, create the CPPI 4.1
device as a child of USB.

Regards,
-Bin.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
