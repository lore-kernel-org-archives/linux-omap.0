From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and
 ohci
Date: Wed, 29 Jun 2011 13:33:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106291331300.2064-100000@iolanthe.rowland.org>
References: <BANLkTi=pKL6RDBTDBStv+uhxVKp3-bwXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=pKL6RDBTDBStv+uhxVKp3-bwXbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On Wed, 29 Jun 2011, Munegowda, Keshava wrote:

> for usb host case , I am seeing that the pm_runtime_get_sync
> 
> 
> static int rpm_resume(struct device *dev, int rpmflags)
> {
>   ............
>  ..........
> 	if (dev->pwr_domain) {
> 		callback = dev->pwr_domain->ops.runtime_resume;
> 		if(!strcmp(dev_name(dev),"usbhs_omap"))
> 			 pr_err("dev->pwr_domain->ops.runtime_resume");
> 	}	
> 	else if (dev->type && dev->type->pm) {
> 		callback = dev->type->pm->runtime_resume;
> 		if(!strcmp(dev_name(dev),"usbhs_omap"))
> 			 pr_err("dev->type->pm->runtime_resume");
> 	}	
> 	else if (dev->class && dev->class->pm) {
> 		callback = dev->class->pm->runtime_resume;
> 		if(!strcmp(dev_name(dev),"usbhs_omap"))
> 			 pr_err("ev->class->pm->runtime_resume");
> 	}	
> 	else if (dev->bus && dev->bus->pm) {
> 		callback = dev->bus->pm->runtime_resume;
> 	if(!strcmp(dev_name(dev),"usbhs_omap"))
> 		 pr_err("dev->bus->pm->runtime_resume");
> 	}	
> 	else
> 		callback = NULL;
> }
> 
> 
> I am seeing that below if statement was hitting true:
> 
> 	if (dev->pwr_domain) {
> 		callback = dev->pwr_domain->ops.runtime_resume;
> 		if(!strcmp(dev_name(dev),"usbhs_omap"))
> 			 pr_err("dev->pwr_domain->ops.runtime_resume");
> 
> 
> due to this; the driver->runtime_resume was not getting called.
> 
> Any idea on why I am seeing only the dev->pwr_domain is set not
> dev->bus && dev->bus->pm is hitting here?

Because the PM domain takes precedence over the subsystem for PM 
callbacks.  If the subsystem routine should be called then the PM 
domain code has to call it.

Alan Stern
