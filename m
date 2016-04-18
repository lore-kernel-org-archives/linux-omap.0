From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Mon, 18 Apr 2016 10:29:56 +0800
Message-ID: <20160418022956.GB32090@shlinux2.ap.freescale.net>
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
To: Roger Quadros <rogerq@ti.com>, stern@rowland.harvard.edu
Cc: Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
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
> > seems like this would make more sense in usb_del_hcd() instead.
> > 
> 
> OK, I'll move it there.
> 

It depends on Alan's comments, whether only usb_add_hcd/usb_del_hcd
pair can be called repeat. If Alan acks it, I have no idea for it.

-- 

Best Regards,
Peter Chen
