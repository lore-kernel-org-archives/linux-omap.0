From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Wed, 4 May 2016 13:01:33 -0500
Message-ID: <572A38FD.9050801@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160504172634.GS5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/04/2016 12:26 PM, Tony Lindgren wrote:
> Hi,
> 
> Adding Nishanth to Cc.
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160429 05:15]:
>> ldo7_reg, obviously ;)
>>
>>> 	status = "okay";
>>> 	regulator-min-microvolt = <1800000>;
>>> 	regulator-max-microvolt = <1800000>;
>>> };
> 
> It really seems to be ldo7, otherwise there's no HDMI output. I don't
> have the schematics either.
> 
> But it seems we have at least two other regressions in Linux next that
> prevent me from testing this properly:
> 
> 1. On igepv5, I get this for the MMC regulator
> 
> ldo9: bypassed regulator has no supply!
> ldo9: failed to get the current voltage(-517)
> palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register 48070000.i2c:palmar
> 
> I'm pretty sure it really is using the ldo9 for MMC just like
> omap5-uevm.. Nishanth suggested it may use something else, but
> why would it as ldo9 has a nice voltage range?
> 
> 2. On both omap5-uevm and igepv5, NFSroot hangs
> 
> It seems that NFSroot boots to the point where PM runtime now
> just shuts down some regulator affecting the USB connected
> smsc Ethernet adapter?
> 
> Regards,

This one is interesting..
BayLibre uEVM:
https://storage.kernelci.org/next/next-20160504/arm-omap2plus_defconfig/lab-baylibre-seattle/boot-omap5-uevm_rootfs:mmc.txt

My uEVM:
https://github.com/nmenon/kernel-test-logs/blob/next-20160504/omap2plus_defconfig/omap5-evm.txt

Mine boots, but BayLibre one does not. So, that got me started
thinking it was bootloader... but then I realize it could be SDCard
since they are dual voltage. U-boot starting v2013.07-rc1 included
code that would set to bypass or program voltage for LDO9 based on
card voltage needed. It is possible (since my card seems to need 3.0v,
not 3.3v), that bypass to VCC_3v3_SDIO was never needed - but the
cards that Baylibre board could probably be setup in bypass.

I will send in a patch assuming (without access to igev5 schematics -
based on how it seems to be booting), that sdio path.


-- 
Regards,
Nishanth Menon
