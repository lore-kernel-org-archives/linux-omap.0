From: Deepa Raj <draj187@hotmail.com>
Subject: RE: Questions about enabling dps(dynamic power switching) and SLM
Date: Mon, 18 Aug 2014 17:30:13 +0000
Message-ID: <BLU185-W16CBCC06A88D78F300AE9AECD40@phx.gbl>
References: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>,<20140814140943.GB9239@atomide.com>,<BLU185-W41F1B3F381C31F1C3B8266ECD40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [65.55.111.166] ([65.55.111.166]:49330 "EHLO
	BLU004-OMC4S27.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751648AbaHRRbO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2014 13:31:14 -0400
In-Reply-To: <BLU185-W41F1B3F381C31F1C3B8266ECD40@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

I have few more questions on OMAP3:

1) As you know there are power scripts in drivers/mfd folder for PMIC c=
hip (Triton2). Is this mandatory to use these scripts like there are P1=
,P2,P3 areas are there in PMIC.

2) My understanding was when regulator_enable and disable are called fr=
om device drivers, voltage regulators are powered on/off, is it correct=
, if yes, why do we need to use power scripts?

3) Suppose HiFreq clk source (Oscillator), since there are no suspend/r=
esume hooks from PMIC. Do we mandatory to use these scripts during susp=
end to RAM or we can directly power off oscillators or is there any har=
dware mechanism also, when all voltage regulators are disabled, HiFreq =
oscillator will be cut off.

4) Do power scripts are mandatory for all OMAP platforms?

Regards,
d. raj

> Date: Thu, 14 Aug 2014 07:09:43 -0700
> From: tony@atomide.com
> To: draj187@hotmail.com
> CC: linux-omap@vger.kernel.org
> Subject: Re: Questions about enabling dps(dynamic power switching) an=
d SLM
>=20
> * Deepa Raj <draj187@hotmail.com> [140813 06:16]:
>> Hi,
>>=20
>> I am working on OMAP3 and OMaP4. I know we can do AVS by smartreflex=
=2E The Questions are as follows:
>>=20
>> 1) I have gone through TRM but could not find how can we enable/disa=
ble dps and slm. Can you please point out how can we do that?=A0
>=20
> With the mainline tree we currently have omap3 working for DPS.
> For omap4 and later, features are not working at least not yet.
> To play with omap3 dps with mainline kernel, you need to consider
> the following:
>=20
> 1. Start with a board that's known to work, like beagleboard xm
>=20
> 2. Start with omap2plus_defconfig, keep EHCI disabled, and OTG cable
> disconnected
>=20
> 3. Enable UART timeouts and off-idle on the device with something lik=
e
>=20
> #!/bin/bash
>=20
> uarts=3D$(find /sys/class/tty/ttyO*/device/power/ -type d)
> for uart in $uarts; do
> echo 3000> $uart/autosuspend_delay_ms
> done
>=20
> uarts=3D$(find /sys/class/tty/ttyO*/power/ -type d)
> for uart in $uarts; do
> echo enabled> $uart/wakeup
> echo auto> $uart/control
> done
>=20
> echo 1> /sys/kernel/debug/pm_debug/enable_off_mode
>=20
> Also the screen needs to be blanked if you have one. Once
> the system starts hitting deeper idle states, you can see
> that set off values in /sys/kernel/debug/pm_debug/count.
>=20
>> 2) Does DPS and SLM only applies to MPU,IVA and core domains or it a=
pplies to all devices?
>=20
> We are now cutting off all voltages during idle if the twl4030
> configuration is enabled with ti,twl4030-power-idle-osc-off
> in the board specific .dts file.
>=20
>> 3) According to OMAP ppt, DPS (similar like run time power managemen=
t and having wakeup latency in micro seconds). If we enable DPS, does h=
ardware take care of switching on/off power domains means there is no n=
eed of powering on/off devices through software?
>=20
> Right, the devices will idle and save and restore their
> state using runtime PM. Once all the blocking devices are
> idle, the system will automatically start entering deeper
> idle states.
>=20
>> 4) Will DPS only triggers to retention state only or off state also?
>=20
> Both work, depending on if /sys/kernel/debug/pm_debug/enable_off_mode
> is enabled or not.
>=20
>> 5) If we enable SLM (according to omap ppt, suspend to ram) but wake=
up latencies in milliseconds, if we enable this feature, does the hardw=
are be able to power off all the devices when system is idle or it only=
 applies to VDD1 (MPU-IVA) or VDD2 (Core domain)?
>=20
> What is automatically powered down depends on the twl4030 script
> configuration, see for example omap3_idle_rconfig. For omap4,
> and later the twl6040 control is only over I2C4 AFAIK.
>=20
>> Hope to see answers from experts.
>=20
> Hopefully that will get you started :)
>=20
> Regards,
>=20
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
