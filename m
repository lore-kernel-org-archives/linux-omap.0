From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Wed, 6 Feb 2019 07:56:54 -0800
Message-ID: <20190206155654.GX5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
 <20190204193311.102a60e6@kemnade.info>
 <20190204184317.GO5720@atomide.com>
 <20190206073732.35ad315f@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206073732.35ad315f@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190206 06:38]:
> But wait... twl4030-power.c is to a big part about switching regulators
> on and off. But how does that connect to hwmods going to ret or off
> mode? That is imho slightly another topic.

The pmic wiring is what must be configured for the regulators
to actually get cut off. And the wiring may or may not be done
properly.

The SoC powerdomain bit to attempt off mode is a policy type
decision and should not be configured in the device tree.

> Ok, looking a bit closer, there is the sys_off_mode line
> which needs to be used.
> So we have to derive that from the devicetree.

Yes but that still does not mean it's wired right to the
PMIC :) We do have devices where sys_off_mode and sys_clkreq
lines are swapped for example. So enabling off mode really
should be only allowed if the PMIC is configured right.

And we also support devices that do muxing in the bootloader
like all the Nokia devices do except for dynamic pins.

I guess reading how the sys_clkreq is configured might
work, but not necessarily until the PMIC driver has probed
depending which device handles the muxing. And it won't
work for devices with lines swapped.

> > The PMIC is wired and configured for off mode, and those
> > properties should not be set unless the system is truly capable
> > of entering off mode. If not set, we should not enable off
> > idle by default.
> > 
> > Otherwise the boards should be already using just
> > "ti,twl4030-power" or "ti,twl4030-power-reset".
> > 
> We have also
> ti,twl4030-power-omap3-sdp,
> ti,twl4030-power-omap3-ldp,
> ti,twl4030-power-omap3-evm
> 
> so we have to maintain a list, especially if we want to allow another
> pmic.

Oops so it seems. Those are all early devices with their
own quirks. Anyways, that list is unlikely to change
any longer for twl4030.

> But since it is about connecting the soc to the pmic, we could also add a
> flag in the dtb on the soc side, so we are prepared if someone uses another
> pmic. It feels a bit strange to query something from devicetree for another
> device.

Well if you have something that actually describes the hardware
in mind for the SoC, sure. But let's not start adding any policy
flags to the dts.

Any other pmics would need their own checks to determine if
off mode is configured. It might depend on the firmware on the
pmic for example. But I don't think we need to worry about that
right now since we don't have any such users in the mainline
kernel.

> PS: I hope my omap-gta04.dtsi-related patches have made their way into
> your review queue and are not starving in a generic lkml fallback folder

Yup I should have the thread tagged in my inbox.

Regards,

Tony
