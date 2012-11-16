From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: core: move dwc3_cache_hwparams before
 dwc3_alloc_event_buffers
Date: Fri, 16 Nov 2012 04:47:11 -0800
Message-ID: <20121116124711.GA14886@kroah.com>
References: <1353047874-4981-1-git-send-email-kishon@ti.com>
 <20121116081719.GA16568@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121116081719.GA16568-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 16, 2012 at 10:17:19AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Nov 16, 2012 at 12:07:54PM +0530, Kishon Vijay Abraham I wrote:
> > commit 392142 moved event buffer allocation out of dwc3_core_init() but
> > event buffer allocation uses the cached copy of hwparams to determine
> > the number of event buffers and the caching is done in dwc3_core_init.
> > So moved dwc3_cache_hwparams function before dwc3_alloc_event_buffers so
> > that dwc3_alloc_event_buffers sees the correct number of event buffers.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> 
> My bad, what a regression I caused :-)
> 
> Greg, can you take this one ?

Yes, will do.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
