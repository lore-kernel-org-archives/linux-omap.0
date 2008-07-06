From: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Hook start_hnp into ohci struct
Date: Sun, 6 Jul 2008 14:33:32 +0400
Message-ID: <20080706103332.GA28505@doriath.ww600.siemens.net>
References: <20080706102630.GA29934@doriath.ww600.siemens.net> <20080706103050.GB20019@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080706103050.GB20019-4vvIQG7NF+ITKvXZea5imILpUPVTGn5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 06, 2008 at 01:30:50PM +0300, Felipe Balbi wrote:
> On Sun, Jul 06, 2008 at 02:26:30PM +0400, Dmitry Baryshkov wrote:
> > diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> > index 4f21646..8b92532 100644
> > --- a/drivers/usb/host/ohci-omap.c
> > +++ b/drivers/usb/host/ohci-omap.c
> > @@ -222,6 +222,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
> >  			dev_err(hcd->self.controller, "can't find transceiver\n");
> >  			return -ENODEV;
> >  		}
> > +		ohci->start_hnp = start_hnp;
> 
> Why? It's part of struct otg_transceiver.
> 

Actually the ohci-omap.c:start_hnp does a bit more than just
otg_start_hnp(tranceiver). Maybe it should be merged. I dunno.

-- 
With best wishes
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
