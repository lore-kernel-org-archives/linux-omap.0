From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
Date: Wed, 10 Apr 2013 14:48:17 -0500
Message-ID: <5165C201.8010500@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com> <1365106576-31816-2-git-send-email-jon-hunter@ti.com> <CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab3DJTsZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 15:48:25 -0400
In-Reply-To: <CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 04/10/2013 02:33 PM, Linus Walleij wrote:
> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> 
>> Currently the IRQ domain is not freed once allocated, in the case where
>> omap_gpio_probe() fails. Therefore, ensure we free the domain if the
>> probe does fail. Furthermore, the local variable "ret" is not needed
>> and so remove this.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Hm Kevin is still listed as maintainer on this driver but on a mail
> address that bounces, can you send a patch replacing him in MAINTAINERS
> with yourself if you're willing to pick it up?
> 
> Anyway, patch applied.

Thanks. There is a patch to fix this queued for v3.10 [1].

Cheers
Jon

[1]
http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/MAINTAINERS?h=for-next&id=c69d72aec52eb5234f433259ac5dcc3b68f1480d
