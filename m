From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: OMAP2+: some more hwmod & clock patches for
 v3.19
Date: Fri, 21 Nov 2014 15:23:07 -0800
Message-ID: <20141121232307.GY7046@atomide.com>
References: <alpine.DEB.2.02.1411211917280.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45442 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbaKUXXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 18:23:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1411211917280.9204@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [141121 11:19]:
> Hi Tony
> 
> The following changes since commit 79005fbd3e1d671d08c45c9140ee9826efdc367c:
> 
>   ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-b2
> 
> for you to fetch changes up to 1f074f996482220f90fbe3dcfafeb3db46ec748a:
> 
>   Merge branch 'adc-support-v3.19' into omap-b-for-v3.19 (2014-11-21 11:05:05 -0700)
> 
> ----------------------------------------------------------------
> Several more OMAP patches targeted for v3.19. They include:
> 
> - OMAP4/5: DSS hwmod cleanup patches from Tomi Valkeinen.
> - DRA7xx: hwmod data support for UARTs 7 through 10.
> - AM43xx: hwmod data support for the onboard ADC.
> 
> Basic build, boot, and PM test reports are here:
> 
> http://www.pwsan.com/omap/testlogs/omap-b-for-v3.19/20141121110550/
> 
> Note that I cannot test the DRA7xx or AM43xx patches, since I do not have
> these boards.

Pulling into omap-for-v3.19/soc thanks.

Tony
