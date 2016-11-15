From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: twl4030-usb: make driver DT only
Date: Tue, 15 Nov 2016 07:45:07 -0800
Message-ID: <20161115154506.GJ4082@atomide.com>
References: <1478947191-30532-1-git-send-email-Nicolae_Rosia@mentor.com>
 <582B0B92.6050209@ti.com>
 <CAKP5S=0kf=S01OhSeBZtmPPSGvYMgjEdANjMn3mr7RDEuG1J0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKP5S=0kf=S01OhSeBZtmPPSGvYMgjEdANjMn3mr7RDEuG1J0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nicolae Rosia <nicolae.rosia.oss@gmail.com> [161115 05:26]:
> Hi,
> 
> On Tue, Nov 15, 2016 at 3:20 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Are you sure about this? I still see a bunch of board files in mach-omap2 using
> > twl4030.
> >
> > Thanks
> > Kishon
> 
> You are right, on v4.9 it is still used in arch/arm/mach-omap2/twl-common.c.
> I forgot to mention that I'm targeting v4.10 with this. On Tony's
> for-next [0], there are no users:
> git grep twl4030_usb_data
> drivers/phy/phy-twl4030-usb.c:  struct twl4030_usb_data *pdata =
> dev_get_platdata(&pdev->dev);
> drivers/usb/phy/phy-twl6030-usb.c:      struct twl4030_usb_data *pdata
> = dev_get_platdata(dev);
> include/linux/i2c/twl.h:struct twl4030_usb_data {
> include/linux/i2c/twl.h:        struct twl4030_usb_data                 *usb;

Yeah might be worht waiting on the omap3 specific driver changes until
v4.11 merge window unless the changes are blocking twl core clean up work.

Regards,

Tony

> [0] https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=for-next
