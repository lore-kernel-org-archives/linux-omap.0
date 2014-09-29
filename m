From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.17-rc7
Date: Mon, 29 Sep 2014 10:20:50 -0700
Message-ID: <20140929172049.GD3122@atomide.com>
References: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20418 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaI2RUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 13:20:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140929 10:14]:
>
> PM: chip off except CORE via suspend:
>     Pass ( 1/ 1): 3730beaglexm
> 
> PM: chip off except CORE via dynamic idle:
>     Pass ( 1/ 1): 3730beaglexm

Most likely the two tests above should now also work also for 37xxevm,
3530es3beagle and 3530es31beagle in case you want to enable that.
 
> PM: chip off via suspend:
>     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> 		  3730es12beaglexm
> 
> PM: chip off via dynamic idle:
>     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> 		  3730es12beaglexm

Since looks like these are working finally :)

Regards,

Tony
