From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Wed, 21 Aug 2013 02:53:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308210249260.6426@utopia.booyaka.com>
References: <cover.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46360 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3HUCxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 22:53:13 -0400
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com

Hi

On Fri, 2 Aug 2013, Afzal Mohammed wrote:

> AM43x PRCM support (excluding clock tree) is being added with this
> series. AM43x reuses most of the IP's from AM335x, as that is the
> case, much of the AM335x hwmod data is reused.

...

> Currently there is no public TRM available for AM43x.

Can you think of any way that the data can be doublechecked against some 
reference or against the reality of the chip?

Can development boards be made available to the OMAP maintainers so we can 
ensure that the code, once merged, continues to work?

> Powerdomain & Clockdomain data has been added separately as it was not
> giving much advantage reusing AM335x ones (runtime updates required
> was getting too ugly). But as AM43x PRCM functionality is similar to
> OMAP4, power domain, clock domain & hwmod operations are reused from
> OMAP4.

Is the AM43xx PRCM design and IP derived from AM33xx, or from OMAP4, or 
from something else?



- Paul
