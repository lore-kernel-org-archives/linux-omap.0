From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.18-rc7
Date: Wed, 03 Dec 2014 09:05:31 +0200
Message-ID: <547EB63B.5070200@compulab.co.il>
References: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34671 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbaLCHFi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Dec 2014 02:05:38 -0500
In-Reply-To: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hi Paul,

On 12/02/14 20:39, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.18-rc7.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.18-rc7/20141201203859/
> 
> 
> Test summary
> ------------
> 

[...]

> Build: uImage+dtb:
>     Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
> 		  omap2plus_defconfig/omap4-panda,
> 		  omap2plus_defconfig/omap4-panda-es,
> 		  omap2plus_defconfig/omap4-var-som,
> 		  omap2plus_defconfig/omap3-evm-37xx,
> 		  omap2plus_defconfig_n800_only_a/omap2420-n800,
> 		  omap2plus_defconfig/omap2430-sdp,
> 		  omap2plus_defconfig/am3517-evm,
> 		  omap2plus_defconfig/omap3-beagle,
> 		  omap2plus_defconfig/omap3-beagle-xm,
> 		  omap2plus_defconfig/omap3-sbc-t3517,
> 		  omap2plus_defconfig/omap5-uevm,
> 		  omap2plus_defconfig/omap5-sbc-t54
> 

[...]

> Boot to userspace:
>     FAIL ( 1/16): 2430sdp
>     skip ( 2/16): 5912osk, 3517evm
>     Pass (13/16): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
> 		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
> 		  3730beaglexm, 3730es12beaglexm, 5430es2uevm,
> 		  5430es2sbct54, 2420n800

I've looked at the boot log and it seems cm-t3517 is booting just fine...
A problem with the test/report collecting script?
5912osk is not listed by the link above, but there are indeed 16 entries...

[...]

-- 
Regards,
Igor.
