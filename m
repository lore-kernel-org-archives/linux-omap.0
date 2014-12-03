From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.18-rc7
Date: Wed, 3 Dec 2014 16:56:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412031655140.8865@utopia.booyaka.com>
References: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com> <547EB63B.5070200@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47846 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaLCQ4e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2014 11:56:34 -0500
In-Reply-To: <547EB63B.5070200@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hi Igor,

On Wed, 3 Dec 2014, Igor Grinberg wrote:

> On 12/02/14 20:39, Paul Walmsley wrote:
> > 
> > Here are some basic OMAP test results for Linux v3.18-rc7.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.18-rc7/20141201203859/
> 
> [...]
> 
> > Boot to userspace:
> >     FAIL ( 1/16): 2430sdp
> >     skip ( 2/16): 5912osk, 3517evm
> >     Pass (13/16): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
> > 		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
> > 		  3730beaglexm, 3730es12beaglexm, 5430es2uevm,
> > 		  5430es2sbct54, 2420n800
> 
> I've looked at the boot log and it seems cm-t3517 is booting just fine...

Thanks for the note.  I will look into this - CM-T3517 should be listed 
there.  

> A problem with the test/report collecting script?

Most likely...

- Paul
