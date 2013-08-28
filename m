From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Wed, 28 Aug 2013 17:33:00 +0530
Message-ID: <521DE6F4.9060804@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <alpine.DEB.2.02.1308210249260.6426@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab3H1MDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 08:03:32 -0400
In-Reply-To: <alpine.DEB.2.02.1308210249260.6426@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com

Hi Paul,

On Wednesday 21 August 2013 08:23 AM, Paul Walmsley wrote:

>> Currently there is no public TRM available for AM43x.
> 
> Can you think of any way that the data can be doublechecked against some 
> reference or against the reality of the chip?

This series has been tested on a pre-silicon platform, and boots to
prompt (along with DT clocks from Tero).

> Can development boards be made available to the OMAP maintainers so we can 
> ensure that the code, once merged, continues to work?

Silicon & boards are not yet ready. I checked internally about your
request, I had been told that once boards are ready, it can be made
available to the maintainers.

>> Powerdomain & Clockdomain data has been added separately as it was not
>> giving much advantage reusing AM335x ones (runtime updates required
>> was getting too ugly). But as AM43x PRCM functionality is similar to
>> OMAP4, power domain, clock domain & hwmod operations are reused from
>> OMAP4.
> 
> Is the AM43xx PRCM design and IP derived from AM33xx, or from OMAP4, or 
> from something else?

PRCM is derived from AM335x, but modified such that it is more aligned
with OMAP4 (especially w.r.t register offsets)

Regards
Afzal

