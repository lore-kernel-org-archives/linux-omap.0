From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] adding gpmc configuration functions, west bridge
 related
Date: Wed, 12 Jan 2011 13:36:29 -0800
Message-ID: <20110112213629.GA15225@kroah.com>
References: <AANLkTim-1+CwW50mPwi6DnQDF680fxjJms7JrEPqsqkv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim-1+CwW50mPwi6DnQDF680fxjJms7JrEPqsqkv@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sutharsan Ramamoorthy <sutharsan.tech@gmail.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, sutharsan.ramamoorthy@cypress.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 12, 2011 at 12:56:44PM -0800, Sutharsan Ramamoorthy wrote:
> This patch implements gpmc configuration functions.

Why?

> These gpmc functions are used by westbridge device controller driver
> in staging tree to configure gpmc timings and bus width.

How does the driver live today without these functions?

And as this is a staging driver, any way to just leave the functions in
the staging driver for now, as there are lots of other things that need
to be done to this driver before it can be moved out of the staging
tree.

Or is this one of those things?

> This patch has been compiled in linux-2.6.37-rc4

This line isn't needed.

You also forgot the line:
	This patch is corrupted by my email client and can not be
	applied or built properly.
:(

> New files:
> 1. ../arch/arm/mach-omap2/usb-cywb-pnand.c
> 2. ../include/linux/usb/cywb.h
> 
> Modified files:
> 1. ../arch/arm/mach-omap2/board-zoom-peripherals.c
> 2. ../arch/arm/mach-omap2/Makefile
> 3.
> ../drivers/staging/westbridge/astoria/arch/arm/mach-omap2/cyashalomap_kernel.c
> 4.
> ../drivers/staging/westbridge/astoria/arch/arm/plat-omap/include/mach/westbridge/westbridge-omap3-pnand-hal/cyashalomap_kernel.h
> 5. ../drivers/staging/westbridge/astoria/device/cyasdevice.c

What is this?  We know what has been added and modified by virtue of the
patch itself.  Please use 'git format-patch' to create a patch that
includes the diffstat in it automatically, if you want to show that
(which you should.)

> Signed-off by: Sutharsan Ramamoorthy <srmt@cypress.com>

This differs from your "From:" line in your email.  If you want to
properly attribute the patch's author, please read
Documentation/SubmittingPatches to do that.

Care to try it again?

thanks,

greg k-h
