From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Tue, 12 Mar 2013 16:51:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303121650090.2723@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34750 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab3CLQvv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 12:51:51 -0400
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On Tue, 12 Mar 2013, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.9-rc1.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/

...

> Boot to userspace:
>     FAIL ( 4/11): 2430sdp, 37xxevm, am335xbone, cmt3517
>     Pass ( 7/11): 2420n800, 3517evm, 3530es3beagle,
>   	   	  3730beaglexm, 4430es2panda, 5912osk,
> 		  4460pandaes

It's not correct that 5912osk booted to userspace, given that the kernel 
didn't build.  Looking at the testlogs, it seems to have inadvertently 
booted a 3.8 kernel.  Something else to fix in the scripts.

This has been fixed in the README copy on the web.


- Paul
