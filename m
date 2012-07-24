From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 10:04:53 -0600
Message-ID: <500EC7A5.6020907@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org> <201207240719.03601.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:53470 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab2GXQE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 12:04:58 -0400
In-Reply-To: <201207240719.03601.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On 07/24/2012 01:19 AM, Arnd Bergmann wrote:
> On Monday 23 July 2012, Stephen Warren wrote:
>>> 3. A device with three channels, one of which has two alternatives:
>>
>> s/three/four/   s/one of which/both of which/
>>
>> This binding doc seems reasonable to me.
> 
> I asked a linguist about it who said that you can't have "both" together
> with "four". She also mentioned that my text is rather confusing, so maybe
> you also got it wrong. I'll try adding some explanation:

Oops, I guess I meant s/three/two/ :-)

It seems that given there are two values for dma-names, there really are
two channels; it's just that one channel is bi-directional, and the
second has two alternatives.

Still, I guess you could also view this as three separate channels
instead. In which case, the text below makes sense.

> 3. A device with three channels, one of which has two alternatives:
> 
>         dmas = <&dma0 1 4   /* first channel,  data read */
>                 &dma0 2 6   /* second channel, data write */
>                 &dma1 1 0   /* third channel,  error read */
>                 &dma2 1 0>; /* third channel,  ernative error read */
>         dma-names = "data", "data", "error", "error";
> 
>    The first two channels are identified by having a unique direction
>    flag in combination with the "data" string. For the third channel,
>    there are two dma specifiers with identical flags (1) and strings
>    ("error"), so only one specifier may be used at a time.
