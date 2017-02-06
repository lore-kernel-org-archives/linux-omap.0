From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 5/6] usb: musb: cppi_dma: Clean up tusb_omap_dma
 structure
Date: Mon, 6 Feb 2017 07:56:32 -0600
Message-ID: <20170206135632.GB17548@uda0271908>
References: <20170125101709.15696-1-abailon@baylibre.com>
 <20170125101709.15696-6-abailon@baylibre.com>
 <be359fa3-0754-ff68-5f60-564df168fc83@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <be359fa3-0754-ff68-5f60-564df168fc83-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 06, 2017 at 10:13:47AM +0200, Peter Ujfalusi wrote:
> 
> 
> On 01/25/2017 12:17 PM, Alexandre Bailon wrote:
> > A pointer to musb is now present in the dma_controller structure.
> > Remove the one present in tusb_omap_dma structure.
> 
> the subject line should be: usb: musb: tusb6010_omap: ...

Revised it to 'usb: musb: tusb6010: ...'.

Thanks,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
