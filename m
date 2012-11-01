From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] ARM: dts: OMAP4/5 device-tree timer updates
Date: Thu, 1 Nov 2012 17:14:26 +0100
Message-ID: <50929FE2.9090602@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54061 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936013Ab2KAQOj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 12:14:39 -0400
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 11/01/2012 04:49 PM, Jon Hunter wrote:
> A few device tree timer updates for OMAP4/5 devices.
> 
> This series adds ...
> 1. MPU private addresses for OMAP4 timers
> 2. Timer nodes for OMAP5
> 3. 32kHz counter node for OMAP5

Great, thanks for that update. Just in time before the pull request.

> This is based upon of Benoit Cousson's OMAP device-tree branch for v3.8.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts
> 
> Jon Hunter (3):
>   ARM: dts: Update OMAP4 timer addresses
>   ARM: dts: Add OMAP5 timer nodes
>   ARM: dts: Add OMAP5 counter node

I've just updated slightly the subjects:

3b3132f ARM: dts: OMAP5: Add counter node
df692a9 ARM: dts: OMAP5: Add timer nodes
d03a93b ARM: dts: OMAP4: Update timer addresses

There are now in my for_3.8/dts branch.

Thanks,
Benoit
