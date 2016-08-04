From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Thu, 4 Aug 2016 16:49:30 +0200
Message-ID: <3EF398D0-6B90-46B6-83AE-EAE065A68890@goldelico.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info> <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com> <20160804142919.GG28140@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804142919.GG28140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 04.08.2016 um 16:29 schrieb Tony Lindgren <tony@atomide.com>:
> 
> Hi,
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [160803 10:07]:
>> All this prevents detection of cable plugin-events and VBUS measurement
>> and setting OTG_EN before charging is attempted.
> 
> So I gave this patch a try but it now blocks all deeper SoC idle
> states as the PHY stays active. I think the real fix is to make
> sure the charger behaves independent of the USB PHY state.

IMHO, plugin detection of the cable is a phy task and then it tells
the charger to start. This part works.

Charging did work up to kernel 4.3. It started to fail with 4.4-rc1
without obvious changes to the charger but many patches to phy
and musb. We had even backported the 4.7 charger driver
to 4.3 and it failed as well.

> So
> probably this needs to be fixed in phy-twl4030-usb.c and
> twl4030_charger.c instead. Now it sounds like we're also shutting
> down the charger with the USB PHY.

As a very deeply hidden side-effect the charger is shut down immediately
after being started. Because phy-twl4030-usb.c does not do what it is expected
and told to do.

I have developed a workaround for the charger driver but I do not consider it
as the solution.

http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=b8c538e75c6dd034889bdb0d66e00ca6e128e616

> power:twl4030_charger: hack to set POWER_CTRL_OTG_ENAB what twl4030-phy does not do
> 
> This hack is a workaround in the charger driver to do what the  twl4030-usb
> driver is expected to have done. It is designed in a way that it can be
> removed after the twl4030-usb issue is solved, but it does not harm if it
> isn't removed immediately.
> 
> Rationale:
> 
> The charger driver calls pm_runtime_get_sync(bci->transceiver->dev);
> which should indirectly call twl4030_usb_set_mode to set the
> POWER_CTRL_OTG_ENAB bit. This enables the prescaler hardware
> for ADC8 (VBUS) channel. But this does not happen for reasons outside
> the charger driver.
> 
> If this bit is not set there are strange effects:
> * VBUS reports 0mV through MADC
> * the automatic charging stops after some ms
> * ITHEN is disabled automatically and the temperature
>   reports 56°C through MADC
> 
> The TPS65950 TRM says:
> "The prescaler for the ADCIN8 channel is in the On-The-Go (OTG) module of
> the USB subchip. This prescaler is enabled when the OTG is enabled by
> writing 1 to the OTG_EN bit of the POWER_CTRL register of the USB subchip."
> 
> and
> 
> "The software must set the POWER_CTRL[5] OTG_EN bit to 1 at least 50 ms
> before forcing the BCIMFSTS4[2] USBFASTMCHG bit to 1."
> 
> For unknown reasons this does not happen with current phy-twl4030-usb code.
> 
> Therefore we add a hack that ensures that this bit is set and the 50ms
> delay is done.
> 
> It appears as if this problem occurred for the first time in linux 4.4-rc1.


With that we have a workaround in the charger, but not a correct solution.
That is what Andreas is trying to fix. The charger driver seems to be ok to
me.

Hope this helps to better understand what is going wrong in phy4030 or musb.

BR,
Nikolaus
