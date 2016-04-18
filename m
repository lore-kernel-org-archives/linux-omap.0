From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Mon, 18 Apr 2016 10:11:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1604181007240.1775-100000@iolanthe.rowland.org>
References: <20160418022956.GB32090@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418022956.GB32090@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 18 Apr 2016, Peter Chen wrote:

> On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
> > On 06/04/16 09:09, Felipe Balbi wrote:
> > > 
> > > Hi,
> > > 
> > > Roger Quadros <rogerq@ti.com> writes:
> > >> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > >> index 2ca2cef..6b1930d 100644
> > >> --- a/drivers/usb/core/hcd.c
> > >> +++ b/drivers/usb/core/hcd.c
> > >> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> > >>  	int retval;
> > >>  	struct usb_device *rhdev;
> > >>  
> > >> +	hcd->flags = 0;
> > > 
> > > seems like this would make more sense in usb_del_hcd() instead.
> > > 
> > 
> > OK, I'll move it there.
> > 
> 
> It depends on Alan's comments, whether only usb_add_hcd/usb_del_hcd
> pair can be called repeat. If Alan acks it, I have no idea for it.

Most of the host controller drivers were not written with this in mind,
but I think it would be a good thing to allow.  It would speed up the
host/device role switches.

This might mean we need to fix up several drivers to make them work 
correctly in an OTG environment.  It should be possible to do this.  Is 
there any particular reason why it would be difficult for Chipidea?

Alan Stern
