From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 10/11] usb: otg: Add dual-role device (DRD) support
Date: Mon, 20 Jul 2015 09:23:09 +0800
Message-ID: <20150720012308.GB4584@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-11-git-send-email-rogerq@ti.com>
 <20150717090212.GC4515@shlinux2> <55A8DD30.5030407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A8DD30.5030407-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 17, 2015 at 01:47:12PM +0300, Roger Quadros wrote:
> >> + * DRD mode hardware Inputs
> >> + *
> >> + * @id:		TRUE for B-device, FALSE for A-device.
> >> + * @vbus:	VBUS voltage in regulation.
> >> + *
> >>   * OTG hardware Inputs
> >>   *
> >>   *	Common inputs for A and B device
> >> @@ -122,7 +127,8 @@ enum otg_fsm_timer {
> >>   */
> >>  struct otg_fsm {
> >>  	/* Input */
> >> -	int id;
> >> +	int id;			/* DRD + OTG */
> >> +	int vbus;		/* DRD only */
> > 
> > Existing b_sess_vld can be also used for drd only case, no need create
> > a new flag.
> 
> b_sess_vld is a bit confusing to people not familiar with OTG.
> My suggestion is to use dedicated 'vbus' flag for DRD case
> for simplicity.
> 

Since OTG DRD is the subset in OTG FSM (FSM, data structure, APIs, etc),
I agree with Jun to reuse existing variables, and we can add some comments
for b_sess_vld if needed.


> > 
> >>  	int adp_change;
> >>  	int power_up;
> >>  	int a_srp_det;
> 
> cheers,
> -roger

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
