From: Li Jun <b47624@freescale.com>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Thu, 10 Sep 2015 17:28:56 +0800
Message-ID: <20150910092854.GA7703@shlinux2>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-8-git-send-email-rogerq@ti.com>
 <20150907074002.GA30578@shlinux2>
 <55ED6C9F.2000502@ti.com>
 <20150909062006.GB812@shlinux2>
 <55F0036A.60403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F0036A.60403@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 09, 2015 at 01:01:14PM +0300, Roger Quadros wrote:
... ...

> >>>> +	return -EINVAL;
> >>>
> >>> Return non-zero, then if err, do we need call usb_otg_add_hcd() after
> >>> usb_otg_register_hcd() fails?
> >>
> >> You should not call usb_otg_register_hcd() but usb_add_hcd().
> >> If that fails then you fail as ususal.
> > 
> > My point is if we use usb_add_hcd(), but failed in usb_otg_register_hcd(),
> > then usb_otg_add_hcd() will be called in *all* error case, is this your
> > expectation?
> > 	if (usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf))
> > 		return usb_otg_add_hcd(hcd, irqnum, irqflags);
> > 
> 
> Yes, my intention was that if otg fails then it is a non otg HCD so register normally.
> Let me correct my previous statement. If you are absolutely sure
> that the HCD is for otg/dual-role usage then you should call usb_otg_register_hcd().
> 

I think this is not just about a statement, in your usb_otg_register_hcd()
implementation, there are several places will return error, I think only
the first two are for a non-otg HCD case, the following error cases seems
mean this is for otg usage, but it fails in middle of registration, if that
is the case, is it reasonable to call usb_otg_add_hcd()?

> >>>> + * @fsm_running: state machine running/stopped indicator
> >>>> + */
> >>>>  struct usb_otg {
> >>>>  	u8			default_a;
> >>>>  
> >>>>  	struct phy		*phy;
> >>>>  	/* old usb_phy interface */
> >>>>  	struct usb_phy		*usb_phy;
> >>>> +
> >>>
> >>> add a blank line?
> >>>
> > 
> > You missed this.
> 
> Sorry. Did you suggest to remove that blank line
> or add a new one before usb_phy?
> 

Remove it.

> > 
> >>>>  	struct usb_bus		*host;
> >>>>  	struct usb_gadget	*gadget;
> >>>>  
> >>>>  	enum usb_otg_state	state;
> >>>>  
> >>>> +	struct device *dev;
> >>>> +	struct usb_otg_caps *caps;
> >>>> +	struct otg_fsm fsm;
> >>>> +	struct otg_fsm_ops fsm_ops;
> >>>> +
> >>>> +	/* internal use only */
> >>>> +	struct otg_hcd primary_hcd;
> >>>> +	struct otg_hcd shared_hcd;
> >>>> +	struct otg_gadget_ops *gadget_ops;
> >>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
> >>>> +	struct list_head list;
> >>>> +	struct work_struct work;
> >>>> -- 
> >>>> 2.1.4
> > 
> 
> --
> cheers,
> -roger
