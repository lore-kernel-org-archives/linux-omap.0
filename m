From: Tony Lindgren <tony@atomide.com>
Subject: Re: Questions about enabling dps(dynamic power switching) and SLM
Date: Thu, 14 Aug 2014 07:09:43 -0700
Message-ID: <20140814140943.GB9239@atomide.com>
References: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36552 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753902AbaHNOJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2014 10:09:47 -0400
Content-Disposition: inline
In-Reply-To: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepa Raj <draj187@hotmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Deepa Raj <draj187@hotmail.com> [140813 06:16]:
> Hi,
>=20
> I am working on OMAP3 and OMaP4. I know we can do AVS by smartreflex.=
 The Questions are as follows:
>=20
> 1) I have gone through TRM but could not find how can we enable/disab=
le dps and slm. Can you please point out how can we do that?=C2=A0

With the mainline tree we currently have omap3 working for DPS.
=46or omap4 and later, features are not working at least not yet.
To play with omap3 dps with mainline kernel, you need to consider
the following:

1. Start with a board that's known to work, like beagleboard xm

2. Start with omap2plus_defconfig, keep EHCI disabled, and OTG cable
   disconnected

3. Enable UART timeouts and off-idle on the device with something like

#!/bin/bash

uarts=3D$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms
done

uarts=3D$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
	echo enabled > $uart/wakeup
	echo auto > $uart/control
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

Also the screen needs to be blanked if you have one. Once
the system starts hitting deeper idle states, you can see
that set off values in /sys/kernel/debug/pm_debug/count.
=20
> 2) Does DPS and SLM only applies to MPU,IVA and core domains or it ap=
plies to all devices?

We are now cutting off all voltages during idle if the twl4030
configuration is enabled with ti,twl4030-power-idle-osc-off
in the board specific .dts file.
=20
> 3) According to OMAP ppt, DPS (similar like run time power management=
 and having wakeup latency in micro seconds). If we enable DPS, does ha=
rdware take care of switching on/off power domains means there is no ne=
ed of powering on/off devices through software?

Right, the devices will idle and save and restore their
state using runtime PM. Once all the blocking devices are
idle, the system will automatically start entering deeper
idle states.
=20
> 4) Will DPS only triggers to retention state only or off state also?

Both work, depending on if /sys/kernel/debug/pm_debug/enable_off_mode
is enabled or not.
=20
> 5) If we enable SLM (according to omap ppt, suspend to ram) but wakeu=
p latencies in milliseconds, if we enable this feature, does the hardwa=
re be able to power off all the devices when system is idle or it only =
applies to VDD1 (MPU-IVA) or VDD2 (Core domain)?

What is automatically powered down depends on the twl4030 script
configuration, see for example omap3_idle_rconfig. For omap4,
and later the twl6040 control is only over I2C4 AFAIK.
=20
> Hope to see answers from experts.

Hopefully that will get you started :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
