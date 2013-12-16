From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/2] usb: fix controller-PHY binding for OMAP3 platform
Date: Mon, 16 Dec 2013 14:38:27 -0800
Message-ID: <20131216223826.GG26293@atomide.com>
References: <1387209225-11520-1-git-send-email-kishon@ti.com>
 <20131216212918.GH12896@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131216212918.GH12896@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, marek.belisko@gmail.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [131216 13:31]:
> Hi,
> 
> On Mon, Dec 16, 2013 at 09:23:43PM +0530, Kishon Vijay Abraham I wrote:
> > After the platform devices are created using PLATFORM_DEVID_AUTO, the
> > device names given in usb_bind_phy (in board file) does not match with
> > the actual device name causing the USB PHY library not to return the
> > PHY reference when the MUSB controller request for the PHY in the non-dt boot
> > case.
> > So removed creating platform devices using PLATFORM_DEVID_AUTO in omap2430.c.
> > 
> > Did enumeration testing in omap3 beagle.
> > 
> > Changes from v2:
> > * Fixed the commit log
> > 
> > Changes from v1:
> > * refreshed to the latested mainline kernel
> > * added musb_put_id from omap2430 remove.
> 
> Tony, how do you want to handle this ? You want me to provide you a
> branch which we both merge ?

Yes that would be great thanks. For the mach-omap2 touching parts:

Acked-by: Tony Lindgren <tony@atomide.com>
