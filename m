From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: rt2x00 support not available for beagleboard
Date: Fri, 08 Jan 2010 04:18:29 +0000
Message-ID: <4B46B215.10302@blueyonder.co.uk>
References: <4B4662DC.9000500@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:54685 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870Ab0AHESc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 23:18:32 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NT6Iw-00088V-EK
	for linux-omap@vger.kernel.org; Fri, 08 Jan 2010 04:18:30 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NT6Iw-0005vc-2P
	for linux-omap@vger.kernel.org; Fri, 08 Jan 2010 04:18:30 +0000
In-Reply-To: <4B4662DC.9000500@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 07/01/10 22:40, Sid Boyce wrote:
> That's the same on all recent kernels.
> # grep RT2X00 arch/arm/configs/omap3_beagle_defconfig
> #
> # grep RT2X00 arch/arm/configs/*
> arch/arm/configs/eseries_pxa_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00=m
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_USB=m
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB=m
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_HT=y
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_FIRMWARE=y
> arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_CRYPTO=y
> arch/arm/configs/igep0020_defconfig:# CONFIG_RT2X00_DEBUG is not set
> arch/arm/configs/kirkwood_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/mini2440_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/omap3_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/omap3_touchbook_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/overo_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/rx51_defconfig:# CONFIG_RT2X00 is not set
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00=m
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_USB=m
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB=m
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_FIRMWARE=y
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_CRYPTO=y
> arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_LEDS=y
> arch/arm/configs/zeus_defconfig:# CONFIG_RT2X00_DEBUG is not set
> Regards
> Sid.

OK, it seems I need to use omap3_defconfig.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

