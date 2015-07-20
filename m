From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 07/11] usb: otg: add OTG core
Date: Mon, 20 Jul 2015 09:45:01 +0800
Message-ID: <20150720014500.GC4584@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-8-git-send-email-rogerq@ti.com>
 <20150717074832.GA4515@shlinux2>
 <55A8EFBA.1000504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A8EFBA.1000504@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Li Jun <b47624@freescale.com>, stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 17, 2015 at 03:06:18PM +0300, Roger Quadros wrote:
> >> +
> >> +/**
> >> + * OTG FSM ops function to start/stop host
> >> + */
> >> +static int usb_otg_start_host(struct otg_fsm *fsm, int on)
> >> +{
> >> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
> >> +	struct otg_hcd_ops *hcd_ops;
> >> +
> >> +	dev_dbg(otgd->dev, "otg: %s %d\n", __func__, on);
> >> +	if (!fsm->otg->host) {
> >> +		WARN_ONCE(1, "otg: fsm running without host\n");
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (on) {
> >> +		/* OTG device operations */
> >> +		if (otgd->start_host)
> >> +			otgd->start_host(fsm, on);
> >> +
> >> +		/* start host */
> >> +		hcd_ops = otgd->primary_hcd.ops;
> >> +		hcd_ops->add(otgd->primary_hcd.hcd, otgd->primary_hcd.irqnum,
> >> +			     otgd->primary_hcd.irqflags);
> >> +		if (otgd->shared_hcd.hcd) {
> >> +			hcd_ops = otgd->shared_hcd.ops;
> >> +			hcd_ops->add(otgd->shared_hcd.hcd,
> >> +				     otgd->shared_hcd.irqnum,
> >> +				     otgd->shared_hcd.irqflags);
> >> +		}
> >> +	} else {
> >> +		/* stop host */
> >> +		if (otgd->shared_hcd.hcd) {
> >> +			hcd_ops = otgd->shared_hcd.ops;
> >> +			hcd_ops->remove(otgd->shared_hcd.hcd);
> >> +		}
> >> +		hcd_ops = otgd->primary_hcd.ops;
> >> +		hcd_ops->remove(otgd->primary_hcd.hcd);
> >> +
> >> +		/* OTG device operations */
> >> +		if (otgd->start_host)
> >> +			otgd->start_host(fsm, on);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > I do not see much benefit by this override function, usb_add/remove_hcd
> > can be simply included by controller's start_host function, also there
> > maybe some additional operations after usb_add_hcd, but this override
> > function limit usb_add_hcd() is the last step.
> 
> I had tried host start/stop way before but Alan's suggestion was to use
> bind/unbind the host controller completely as that is much simpler
> 
> [1] http://article.gmane.org/gmane.linux.usb.general/123842
> 

Jun may want we have some ways to override otg_fsm->ops by platform
drivers, I think we all agree to call usb_add_hcd/usb_remove_hcd
to start/stop host roles, just some platforms may need more than
just call them.

-- 

Best Regards,
Peter Chen
