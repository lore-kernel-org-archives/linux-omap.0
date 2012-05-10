From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH 0/6] twl4030: Various fixes for charing-from-USB
Date: Thu, 10 May 2012 09:24:23 +0800
Message-ID: <20120510012422.GA32077@nchen-desktop>
References: <20120425072931.20124.56635.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120425072931.20124.56635.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 25, 2012 at 05:33:10PM +1000, NeilBrown wrote:
> Following are a collection of patches that I've need using for a while
> to make sure the charge-from-usb on my GTA04 works.
> Hopefully I've included the right people in the recipient list :-)
> 
> The issues are:
>  - charge the backup battery as well as the main battery
>  - charge from a charger which ties ID to ground via a resistor
>  - charge while device is suspended, or when no gadget module is
>    loaded (i.e. when the USB side thinks the phy should be powered
>    down).
According to USB Spec, when the USB bus goes to suspend, the device
should not draw more than 2.5mA. So when the device is suspended,
it should notify the battery driver do NOT charge any more.
> 
> Questions and comments more welcome.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (6):
>       twl4030-usb: Don't report EVENT_ID when there is VBUS.
>       twl4030-usb: Don't power down phy when it is in-use by charger.
>       twl4030_charger: Allow charger to control the regulator that feeds it.
>       twl4030_charger: allow charging whenever VBUS is present.
>       twl4030_charger: add backup-battery charging.
>       twl4030_charger: Fix some typos
> 
> 
>  drivers/mfd/twl-core.c          |    9 ++--
>  drivers/power/twl4030_charger.c |   86 +++++++++++++++++++++++++++++++++++----
>  drivers/usb/otg/twl4030-usb.c   |   27 ++++++++----
>  include/linux/i2c/twl.h         |    2 +
>  4 files changed, 102 insertions(+), 22 deletions(-)
> 
> -- 
> Signature
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
