From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: Re: [PATCH] usb: dwc3: gadget: fix burst size corruption
Date: Thu, 1 May 2014 17:14:24 -0400
Message-ID: <20140501211424.GE30575@intel.com>
References: <20140501071604.GB30575@intel.com>
 <20140430200353.GC3839@saruman.home>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140430200353.GC3839@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 30, 2014 at 03:03:53PM -0500, Felipe Balbi wrote:
> On Thu, May 01, 2014 at 03:16:04AM -0400, Zhuang Jin Can wrote:
> > endpoint.maxburst may be 0 if a gadget doesn't call config_ep_by_speed()
> > to update it from the companion descriptor.
> > And endpoint.maxburst - 1 returns 11111b which wrongly sets bit
> > 26 of endpoint parameter 0.
> > This sets a wrong endpoint state and will cause "Get Endpoint State"
> > command can't get the corret endpoint state and "Set Endpoint Config"
> > command can't restore the correct endpoint state during hibernation
> > resume flow.
> > Thus, when endpoint.maxburst is 0, we should set burst as 0 directly.
> > 
> > Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
> > ---
> >  drivers/usb/dwc3/gadget.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 70715ee..44eca95 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -440,7 +440,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
> >  
> >  	/* Burst size is only needed in SuperSpeed mode */
> >  	if (dwc->gadget.speed == USB_SPEED_SUPER) {
> > -		u32 burst = dep->endpoint.maxburst - 1;
> > +		u32 burst = dep->endpoint.maxburst ?
> > +				dep->endpoint.maxburst - 1 : 0;
> 
> again, you found a bug on the gadget driver. Fix that. composite.c
> guarantees that for those functions which don't pass bMaxBurst,
> gadget->maxburst will be set to *at least* 1.
> 
I agree the real fix should be in the gadget driver. The patch intents
to prevent hibernatition from being corrupted by a bad gadget driver.
If OEMs develop their own gadget driver forgetting to call
config_ep_by_speed(), it'll turn out to be everything works except
dwc3 hibernation, and they'll complain to dwc3. f_ffs is an
example has SuperSpeed support but doesn't call config_ep_by_speed().
It's just for robustness, and dwc3 is not doing anything wrong.
It did cause me a long time to figure out why the hibernation was broken.

Thanks
Jincan
