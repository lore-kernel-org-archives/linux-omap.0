From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] AM35x: Add musb support
Date: Mon, 22 Mar 2010 16:27:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E71B@dbde02.ent.ti.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com>
 <4BA5FBF6.8010102@mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
 <4BA742ED.6080004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BA742ED.6080004-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> >>> I have not added CPPI4.1 DMA  specific register here..
> >>>
> >>>
> >>    Ah. Then they're not compatible with DA8xx anyway...
> >>
> >
> > We could make it compatible with some change as done at,
> > http://arago-project.org/git/people/?p=sriram/ti-psp-
> omap.git;a=commitdiff;h=2ecce9529bd56c32997e0b2cbe84f7727ba5b217
> >
> 
> I'm not sure where cppi41_dma.c gets the definitions for
> USB_[RT]X_MODE_REG...

It is being used from plat/usb.h.

> anyway, I'm thinking of a different solution now,
> i.e. moving the functions that access the implementation specific
> acceleration
> 
> >>>> +#define USB_END_OF_INTR_REG  0x60
> >>    I wonder how it can work as the registers cppi41_dma.c relies upon
> >> are not the same as in DA8xx. Did you make some changes to
> cppi41_dma.c?
> >>
> >
> > There were only few changes to make it work. You can see the changes
> > in our internal release tree at,
> > http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary
> >
> > They have all the CPPI patches based out of your latest patch. All these
> >
> 
>    My latest was take 5, this tree has take 3 as a base.

Correct. Need to update.

> 
> > have to be reviewed/cleaned which is not happening as the base CPPI4.1
> patch
> > itself is pending to be merged.
> >
> > Any update on CPPI4.1 driver location?
> 
>    I'm pretty sure it should be in arch/arm/common/...
> 
> >  Are you still waiting for Russell's reply?
> >
> 
>    Well, yes and no. I'm not hoping on Russell's reply though but
> haven't found time to move the code and post the new patch...

Ok fine, would wait for this to get merged.

Ajay
> 
> WBR, Sergei
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
