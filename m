From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 16:54:27 +0400
Message-ID: <500E9B03.20706@mvista.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3> <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44278 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab2GXMzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 08:55:23 -0400
Received: by lbbgm6 with SMTP id gm6so9038393lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 05:55:22 -0700 (PDT)
In-Reply-To: <500DC255.40900@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hello.

On 24-07-2012 1:29, Stephen Warren wrote:

>> I think we're basically on the same page. Let's see if I have covered
>> all the cases we discussed so far. I've tried to update the binding that
>> Jon sent out initially with everything we've discussed, so please review
>> this to see if I understood you correctly.
> ...
>> * DMA client
> ...
>> Examples:
> ...
>> 3. A device with three channels, one of which has two alternatives:

> s/three/four/   s/one of which/both of which/

    You can't say "both" of 4 channels, only "all". :-)

WBR, Sergei

