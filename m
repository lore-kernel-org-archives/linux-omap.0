From: Tony Lindgren <tony@atomide.com>
Subject: Re: dss_pwrdm & core_pwrdm not entering sleep state correctly on
 am37xx
Date: Tue, 6 May 2014 12:58:41 -0700
Message-ID: <20140506195841.GA31384@atomide.com>
References: <CABCN2SufRoYEDokszRJ4Xme91f6xsfXZ9M7=wp_CUGZaTXAteQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62391 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754021AbaEFT6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 15:58:45 -0400
Content-Disposition: inline
In-Reply-To: <CABCN2SufRoYEDokszRJ4Xme91f6xsfXZ9M7=wp_CUGZaTXAteQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew LeCain <alecain@google.com>
Cc: linux-omap@vger.kernel.org

* Andrew LeCain <alecain@google.com> [140506 12:10]:
> Hi,
> 
> I'm trying to backport a display driver for an RFBI panel to 2.6.32,
> but the dss_pwrdm is complaining about not entering target state:

Backport from which kernel? The RFBI got removed recently because
of the move of the panels. Probably should get patched back in once
it's working again, so at least I would like to see this get fixed
properly in the mainline kernel if you have patches somewhere.
 
> root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss
> dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
> dss_clkdm->dss_pwrdm (0)
> 
> root@02AA01AB381207S7# echo -n "mem" > /sys/power/state
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.02 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.04 seconds) done.
> PM: Entering mem sleep
> spidev spi2.0: ... can't suspend
> WLAN: Suspend call
> WLAN_firmware Suspend
> Wake locks are active (count: 0)
> Shutting Down I&F Clock Interface
> Powerdomain (core_pwrdm) didn't enter target state 0
> Powerdomain (dss_pwrdm) didn't enter target state 0
> Could not enter target state in pm_suspend
> <snip>
> #no change after attempted suspend.
> root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss
> 
> dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
> dss_clkdm->dss_pwrdm (0)
> 
> 
> I was worried it might be the dss clocks not being disabled, but I
> instrumented dss_clk_(en|dis)able to print clock counts and it goes to
> 0 before suspending. I don't really understand what will prevent the
> dss power domain from entering retain state or not, so any pointers
> would be useful.

Maybe dump out the autoidle registers like CM_IDLEST_PER and
CM_IDLEST*_CORE and that should show you what's still blocking 
idle transitions.
 
> I'm less worried about the core_pwrdm error because that isn't a
> regression from the old panel, and power numbers are low enough
> without it, but any tips there would be great as well.

2.6.32 is getting pretty old.. We do have pending patches to
have mainline kernel hit core off for omap3 with twl4030 cutting
off vdd_core. I did not yet test with a display as the panels
have been still pending for device tree based booting. These
should allow you to quite easily to test against v3.14-rc4:

[PATCH 00/11] Fixes for omap PM for making omap3 DT only

BTW, if your SoC is 3703 then you need to also idle IVA2:

2d403f7b1981 (ARM: OMAP3: Fix iva2_pwrdm settings for 3703)

Regards,

Tony


