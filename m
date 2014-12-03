From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.18-rc7
Date: Wed, 3 Dec 2014 22:25:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412032224240.8865@utopia.booyaka.com>
References: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com> <547EB63B.5070200@compulab.co.il> <alpine.DEB.2.02.1412031655140.8865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51292 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaLCWZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2014 17:25:49 -0500
In-Reply-To: <alpine.DEB.2.02.1412031655140.8865@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hi Igor,

On Wed, 3 Dec 2014, Paul Walmsley wrote:

> On Wed, 3 Dec 2014, Igor Grinberg wrote:
> 
> > I've looked at the boot log and it seems cm-t3517 is booting just fine...
> 
> Thanks for the note.  I will look into this - CM-T3517 should be listed 
> there.  
> 
> > A problem with the test/report collecting script?
> 
> Most likely...

Well this one turned out to be due to my own stupidity.  It's been fixed 
and this particular issue should not recur.  

I've reuploaded a new test summary and will reply appropriately to the 
original message.

Thanks again for pointing it out,


- Paul
