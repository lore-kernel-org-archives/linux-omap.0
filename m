From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.17-rc3
Date: Wed, 03 Sep 2014 12:12:54 +0300
Message-ID: <5406DB96.20904@compulab.co.il>
References: <alpine.DEB.2.02.1409022346440.1546@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:54740 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbaICJM7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 05:12:59 -0400
In-Reply-To: <alpine.DEB.2.02.1409022346440.1546@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hi Paul,

On 09/03/14 02:52, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.17-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.17-rc3/20140902165525/
> 
> 
> Test summary
> ------------

[...]

> Boot to userspace:
>     FAIL ( 2/15): 2430sdp, 5430es2sbct54
>     skip ( 1/15): 5912osk
>     Pass (12/15): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
> 		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
> 		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

[...]

> A Compulab SBC-T54 (OMAP5432) has been added to the testbed, graciously 
> donated by Compulab and Igor Grinberg.  It currently isn't booting to 
> userspace in the current mainline kernel, but if the 'ldo8' regulator is 
> modified to be always-on in the omap5-sbc-t54.dts file, it will.

Thanks for the heads up!
Yes, indeed ldo8 powers the serial port transceiver,
led and touch screen controller.
We intend to send fixes in a short while.


-- 
Regards,
Igor.
