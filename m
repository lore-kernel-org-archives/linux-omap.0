From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] AM35x: Add musb support
Date: Mon, 22 Mar 2010 12:12:25 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com>
 <4BA5FBF6.8010102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BA5FBF6.8010102-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> >> +/* USB 2.0 OTG module registers */
> >> +#define USB_REVISION_REG     0x00
> >> +#define USB_CTRL_REG         0x04
> >> +#define USB_STAT_REG         0x08
> >> +#define USB_EMULATION_REG    0x0c
> >> +/* 0x10 Reserved */
> >>  Wait... so the mode register isn't supported? Does AM35x support any
> >> accelerated modes?
> >>
> >
> > Mode register is available though with some difference due to 15Rx/Tx
> eps.
> > I have not added CPPI4.1 DMA  specific register here..
> >
> 
>    Ah. Then they're not compatible with DA8xx anyway...

We could make it compatible with some change as done at,
http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=commitdiff;h=2ecce9529bd56c32997e0b2cbe84f7727ba5b217


> >> +#define USB_END_OF_INTR_REG  0x60
> >>   Hm, I don't see the generic RNDIS EP size registers also. So, generic
> >> RNDIS mode isn't supported? Then cppi41_dma.c won't work with this
> >> chip... :-/
> >>
> >
> > Generic RNDIS mode is suported and CPPi4,1 is already verified to be
> working on
> > AM3517.
> 
>    I wonder how it can work as the registers cppi41_dma.c relies upon
> are not the same as in DA8xx. Did you make some changes to cppi41_dma.c?

There were only few changes to make it work. You can see the changes
in our internal release tree at,
http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary

They have all the CPPI patches based out of your latest patch. All these
have to be reviewed/cleaned which is not happening as the base CPPI4.1 patch
itself is pending to be merged. 

Any update on CPPI4.1 driver location? Are you still waiting for Russell's reply?

Ajay
> 
> > You can get more details on this at AM3517 TRM,
> >
> > http://focus.ti.com/lit/ug/sprugr0/sprugr0.pdf
> >
> 
>    Thanks for the pointer...
> 
> WBR, Sergei
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
