From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume
 balanced enable()/disable()
Date: Thu, 4 Aug 2016 18:44:02 +0200
Message-ID: <20160804184402.73963e8a@aktux>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
	<FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
	<20160804142919.GG28140@atomide.com>
	<20160804183129.2e0cac71@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804183129.2e0cac71@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 4 Aug 2016 18:31:29 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
> 
> On Thu, 4 Aug 2016 07:29:19 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi,
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [160803 10:07]:
> > > All this prevents detection of cable plugin-events and VBUS
> > > measurement and setting OTG_EN before charging is attempted.
> > 
> > So I gave this patch a try but it now blocks all deeper SoC idle
> > states as the PHY stays active. I think the real fix is to make
> > sure the charger behaves independent of the USB PHY state. So
> > probably this needs to be fixed in phy-twl4030-usb.c and
> > twl4030_charger.c instead. Now it sounds like we're also shutting
> > down the charger with the USB PHY.
> > 
> Then there is another power management issue. The patch is not about
> fixing every pm issue in musb. That is not only about charging, it is
> about enabling/disabling() the phy unbalanced:
> Again what happens here without the patch:
> 
> musb will be initialized:
> omap2430_musb_disable()
>    calls phy_power_off(), phy will be disabled,
> 	phy->power_count goes to -1.
> 
sorry mixed something up.
Nothing happens here, so the previous state of the phy remains.
It would be disabled by the generic phy layer in drivers/phy/phy-core.c

> gadget driver is loaded.
> musb_start() is called
>     omap2430_musb_enable() is called
> 	calls phy_power_on(),
> 	phy->power_count goes to 0,
> 	phy is not powered on because power_count != 1
> -> no gadget working, no charging.
> 
... if not configured by u-boot before. USB gadget might work when
initialized earlier in the boot process (u-boot/x-loader/mlo ...)
and phy-twl4030 cannot do anything about it besides if we change
drivers/phy/phy-core.c

Regards,
Andreas
