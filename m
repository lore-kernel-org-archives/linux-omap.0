From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: dts: AM43x: Fix DCDC3 regulator voltage
Date: Thu, 6 Nov 2014 10:25:27 -0800
Message-ID: <20141106182526.GC31454@atomide.com>
References: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15090 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaKFS0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 13:26:24 -0500
Content-Disposition: inline
In-Reply-To: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

* Keerthy <j-keerthy@ti.com> [141106 02:55]:
> Fix DCDC3 volatge to 1.5V which is the right value to be supplied by
> DCDC3 for all the boards.

Hmm so what about the comments for similar beaglebone changes
in thread "[PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
for 1.35v ddr3"?

Regards,

Tony
 
> Keerthy (3):
>   ARM: dts: AM43x-EPOS-EVM: Fix DCDC3 voltage
>   ARM: dts: AM437x-GP-EVM: Fix DCDC3 voltage
>   ARM: dts: AM437x-SK-EVM: Fix DCDC3 voltage
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts  |    4 ++--
>  arch/arm/boot/dts/am437x-sk-evm.dts  |    4 ++--
>  arch/arm/boot/dts/am43x-epos-evm.dts |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 1.7.9.5
> 
