From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 14 Jun 2012 10:15:49 +0530
Message-ID: <CAJe_ZhfVu46pOfAQMgj-MxHyZFP6th9XmWNDE_bQc9MbLsFzEA@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FBAA64A.200@wwwdotorg.org>
	<4FD24CC3.50700@ti.com>
	<201206090004.10086.arnd@arndb.de>
	<4FD914F6.6000402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41978 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2FNEpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 00:45:51 -0400
Received: by lbbgm6 with SMTP id gm6so1743739lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 21:45:49 -0700 (PDT)
In-Reply-To: <4FD914F6.6000402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 14 June 2012 04:02, Jon Hunter <jon-hunter@ti.com> wrote:
> On 06/08/2012 07:04 PM, Arnd Bergmann wrote:
>
>> As I said previously, I think just encoding the direction but not
>> the client specific ID (meaning we would have to disambiguate
>> the more complex cases that Stephen mentioned using a dma-names
>> property) would be the best because it keeps the common case simple,
>> but I could live with other things going in there too.
>
> Ok, so you are saying that there are some DMA controllers where there is
> no channel/request ID and only a direction is needed? So an even simpler
> case than what I had imagined.
>
I am curious to know which DMA controllers don't need any client ID ?
unless it is Mem->Mem (for which even specifying direction is
meaningless).
Rather, I think specifying direction is even lesser useful, since
usually the client's ID imply the (bi/uni)direction.
