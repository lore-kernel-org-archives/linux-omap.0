From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-sniper: Discard deprecated twl4030-power
 property
Date: Tue, 12 Apr 2016 14:19:44 -0700
Message-ID: <20160412211943.GH5995@atomide.com>
References: <1459279545-17539-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459279545-17539-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Kocialkowski <contact@paulk.fr> [160329 12:26]:
> This uses ti,system-power-controller instead of the deprecated ti,use_poweroff
> property for powering off.

But what about the others?

We have more of them:

$ git grep ti,use_poweroff arch/arm/boot/dts
arch/arm/boot/dts/logicpd-som-lv.dtsi:          ti,use_poweroff;
arch/arm/boot/dts/logicpd-torpedo-som.dtsi:             ti,use_poweroff;
arch/arm/boot/dts/omap3-beagle-xm.dts:                  ti,use_poweroff;
arch/arm/boot/dts/omap3-evm-common.dtsi:                ti,use_poweroff;
arch/arm/boot/dts/omap3-gta04.dtsi:                     ti,use_poweroff;
arch/arm/boot/dts/omap3-ldp.dts:                        ti,use_poweroff;
arch/arm/boot/dts/omap3-n900.dts:               ti,use_poweroff;
arch/arm/boot/dts/omap3-n950-n9.dtsi:           ti,use_poweroff;
arch/arm/boot/dts/omap3-pandora-common.dtsi:                    ti,use_poweroff;
arch/arm/boot/dts/omap3-sniper.dts:                     ti,use_poweroff;

Regards,

Tony
