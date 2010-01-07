From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: rt2x00 support not available for beagleboard
Date: Thu, 07 Jan 2010 22:40:28 +0000
Message-ID: <4B4662DC.9000500@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:44821 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756Ab0AGWkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 17:40:33 -0500
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NT11q-0007rU-OE
	for linux-omap@vger.kernel.org; Thu, 07 Jan 2010 22:40:31 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NT11p-00024z-8J
	for linux-omap@vger.kernel.org; Thu, 07 Jan 2010 22:40:29 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

That's the same on all recent kernels.
# grep RT2X00 arch/arm/configs/omap3_beagle_defconfig
#
# grep RT2X00 arch/arm/configs/*
arch/arm/configs/eseries_pxa_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00=m
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_USB=m
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB=m
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_HT=y
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_FIRMWARE=y
arch/arm/configs/igep0020_defconfig:CONFIG_RT2X00_LIB_CRYPTO=y
arch/arm/configs/igep0020_defconfig:# CONFIG_RT2X00_DEBUG is not set
arch/arm/configs/kirkwood_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/mini2440_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/omap3_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/omap3_touchbook_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/overo_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/rx51_defconfig:# CONFIG_RT2X00 is not set
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00=m
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_USB=m
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB=m
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_FIRMWARE=y
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_CRYPTO=y
arch/arm/configs/zeus_defconfig:CONFIG_RT2X00_LIB_LEDS=y
arch/arm/configs/zeus_defconfig:# CONFIG_RT2X00_DEBUG is not set
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

