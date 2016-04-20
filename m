From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Wed, 20 Apr 2016 17:39:56 +0800
Message-ID: <20160420093956.GD27526@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <20160419080649.GJ4477@shlinux2.ap.freescale.net>
 <57172989.6060906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57172989.6060906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 20, 2016 at 10:02:33AM +0300, Roger Quadros wrote:
> On 19/04/16 11:06, Peter Chen wrote:
> > On Tue, Apr 05, 2016 at 05:05:12PM +0300, Roger Quadros wrote:
> >> +/**
> >> + * usb_otg_start_host - start/stop the host controller
> >> + * @otg:	usb_otg instance
> >> + * @on:		true to start, false to stop
> >> + *
> >> + * Start/stop the USB host controller. This function is meant
> >> + * for use by the OTG controller driver.
> >> + */
> >> +int usb_otg_start_host(struct usb_otg *otg, int on)
> >> +{
> >> +	struct otg_hcd_ops *hcd_ops = otg->hcd_ops;
> >> +
> >> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
> >> +	if (!otg->host) {
> >> +		WARN_ONCE(1, "otg: fsm running without host\n");
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (on) {
> >> +		if (otg->flags & OTG_FLAG_HOST_RUNNING)
> >> +			return 0;
> >> +
> >> +		otg->flags |= OTG_FLAG_HOST_RUNNING;
> >> +
> >> +		/* start host */
> >> +		hcd_ops->add(otg->primary_hcd.hcd, otg->primary_hcd.irqnum,
> >> +			     otg->primary_hcd.irqflags);
> >> +		if (otg->shared_hcd.hcd) {
> >> +			hcd_ops->add(otg->shared_hcd.hcd,
> >> +				     otg->shared_hcd.irqnum,
> >> +				     otg->shared_hcd.irqflags);
> >> +		}
> > 
> > Check the return value please.
> 
> And what should we do on failure?
> Even if things fail, they could potentially start working on next
> remove/add iteration so I didn't bother checking return values.
> 

If usb_add_hcd has failed, the hcd may be released (usb_put_hcd is
called), in that case, we can't call usb_remove_hcd, maybe we may
need to add hcd valid check for primary hcd too. Even we can't
stop fsm, we need to show an error message for user.

Chipidea idea have a bug before:

commit 41314fea2ffb6dc716b7e698a47c68b329602fc0
Author: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Wed Oct 16 13:45:15 2013 +0100

    usb/chipidea: fix oops on memory allocation failure

-- 

Best Regards,
Peter Chen
