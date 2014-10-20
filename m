From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.18-rc1
Date: Mon, 20 Oct 2014 18:13:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1410201810160.4472@utopia.booyaka.com>
References: <alpine.DEB.2.02.1410201804050.4472@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35922 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbaJWPUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2014 11:20:23 -0400
In-Reply-To: <alpine.DEB.2.02.1410201804050.4472@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 20 Oct 2014, Paul Walmsley wrote:

> Boot-time memory difference
> (delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb))
>   avail  rsrvd   high  freed  board          kconfig
>  -117908k -13164k      .  -148k  2420n800    omap2plus_defconfig_n800_only_a
>  -1012k  1012k      .      .  2430sdp        omap2plus_defconfig
>  -1268k  1268k      .    16k  3530es31beagle omap2plus_defconfig
>  -1268k  1268k      .    16k  3530es3beagle  omap2plus_defconfig
>  -1780k  1780k      .    16k  3730beaglexm   omap2plus_defconfig
>  -1780k  1780k      .    16k  3730es12beaglexmomap2plus_defconfig
>  -1268k  1268k      .    16k  37xxevm        omap2plus_defconfig
>  -2780k  2780k -16384k    16k  4460pandaes    omap2plus_defconfig
>  -2776k  2776k -16384k    16k  4460varsomom   omap2plus_defconfig
>  -4848k  4848k -16384k    16k  5430es2sbct54  omap2plus_defconfig
>  -4800k  4800k -16384k    16k  5430es2uevm    omap2plus_defconfig
>   -996k   996k      .     8k  am335xbone     omap2plus_defconfig_am33xx_only
>  -1268k  1268k      .    16k  am335xbonelt   omap2plus_defconfig
> 
> 
> The size of an omap2plus_defconfig kernel has increased by 760K - a 
> remarkable increase that fortunately does not appear to be matched by 
> runtime memory consumption.

Well let's take that back.  I seem to have glazed over the 1 to 4MB (!) 
runtime memory usage increases in boot memory consumption.  That is also 
an extraordinary increase.


- Paul
