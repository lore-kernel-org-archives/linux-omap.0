From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 07:19:03 +0000
Message-ID: <201207240719.03601.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977Ab2GXHTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 03:19:12 -0400
In-Reply-To: <500DC255.40900@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Monday 23 July 2012, Stephen Warren wrote:
> > 3. A device with three channels, one of which has two alternatives:
> 
> s/three/four/   s/one of which/both of which/
> 
> This binding doc seems reasonable to me.

I asked a linguist about it who said that you can't have "both" together
with "four". She also mentioned that my text is rather confusing, so maybe
you also got it wrong. I'll try adding some explanation:

3. A device with three channels, one of which has two alternatives:

        dmas = <&dma0 1 4   /* first channel,  data read */
                &dma0 2 6   /* second channel, data write */
                &dma1 1 0   /* third channel,  error read */
                &dma2 1 0>; /* third channel,  ernative error read */
        dma-names = "data", "data", "error", "error";

   The first two channels are identified by having a unique direction
   flag in combination with the "data" string. For the third channel,
   there are two dma specifiers with identical flags (1) and strings
   ("error"), so only one specifier may be used at a time.

	Arnd
