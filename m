From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH] phy: twl4030-usb: make driver DT only
Date: Tue, 15 Nov 2016 15:26:06 +0200
Message-ID: <CAKP5S=0kf=S01OhSeBZtmPPSGvYMgjEdANjMn3mr7RDEuG1J0g@mail.gmail.com>
References: <1478947191-30532-1-git-send-email-Nicolae_Rosia@mentor.com> <582B0B92.6050209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <582B0B92.6050209@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 15, 2016 at 3:20 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Are you sure about this? I still see a bunch of board files in mach-omap2 using
> twl4030.
>
> Thanks
> Kishon

You are right, on v4.9 it is still used in arch/arm/mach-omap2/twl-common.c.
I forgot to mention that I'm targeting v4.10 with this. On Tony's
for-next [0], there are no users:
git grep twl4030_usb_data
drivers/phy/phy-twl4030-usb.c:  struct twl4030_usb_data *pdata =
dev_get_platdata(&pdev->dev);
drivers/usb/phy/phy-twl6030-usb.c:      struct twl4030_usb_data *pdata
= dev_get_platdata(dev);
include/linux/i2c/twl.h:struct twl4030_usb_data {
include/linux/i2c/twl.h:        struct twl4030_usb_data                 *usb;

Thanks,
Nicolae

[0] https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=for-next
