From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 06:24:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210200614390.9865@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2JTGYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 02:24:04 -0400
In-Reply-To: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin

On Fri, 19 Oct 2012, Paul Walmsley wrote:

> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/

...

> > Failing tests: needing investigation
> > ------------------------------------
> > 

...

> > PM tests:
>
> * 3730 Beagle XM: OPPs do not initialize
>   - Several "find_device_opp: Invalid parameters" messages appear on boot; 
>     related warnings follow
>   - Cause unknown

This one seems to be caused by this commit:

commit 24d7b40a60cf19008334bcbcbd98da374d4d9c64
Author: Kevin Hilman <khilman@ti.com>
Date:   Thu Sep 6 14:03:08 2012 -0700

    ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS
    
Care to take a look at it and fix it?


- Paul
