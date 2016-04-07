From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Thu, 7 Apr 2016 17:42:46 +0800
Message-ID: <20160407094246.GA9963@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-2-git-send-email-rogerq@ti.com>
 <87zit72rqz.fsf@intel.com>
 <5704AD76.9080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5704AD76.9080806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@kernel.org>, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
> On 06/04/16 09:09, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Roger Quadros <rogerq@ti.com> writes:
> >> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >> index 2ca2cef..6b1930d 100644
> >> --- a/drivers/usb/core/hcd.c
> >> +++ b/drivers/usb/core/hcd.c
> >> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>  	int retval;
> >>  	struct usb_device *rhdev;
> >>  
> >> +	hcd->flags = 0;
> > 

I am not sure if this usb_add(remove)_hcd pair is safe and clean enough
for start/stop host role. From my point, we may need to do like
.probe/.remove host platform driver interface. In that case, we can make
sure the clocks and regulators are off, and hcd will be zero-initialized
next time. Assume we are at gadget mode, we may not hope the vbus regulator
is still on which is for host only. So, this part may need to implement
by each user.

-- 

Best Regards,
Peter Chen
