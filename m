From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 23 Jul 2012 15:29:57 -0600
Message-ID: <500DC255.40900@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3> <201207171924.33756.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36494 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab2GWVaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 17:30:02 -0400
In-Reply-To: <201207171924.33756.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On 07/17/2012 01:24 PM, Arnd Bergmann wrote:
...
> I think we're basically on the same page. Let's see if I have covered
> all the cases we discussed so far. I've tried to update the binding that
> Jon sent out initially with everything we've discussed, so please review
> this to see if I understood you correctly.
...
> * DMA client
...
> Examples:
...
> 3. A device with three channels, one of which has two alternatives:

s/three/four/   s/one of which/both of which/

This binding doc seems reasonable to me.
