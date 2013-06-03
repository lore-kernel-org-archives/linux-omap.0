From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 13:03:40 +0530
Message-ID: <51AC46D4.9020503@ti.com>
References: <20130602165019.655da2eb@notabene.brown> <51AC44A2.8050605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3FCHd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 03:33:57 -0400
In-Reply-To: <51AC44A2.8050605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Tomi,

> 
> Odd, indeed. Without reverting the patch, the DSS uses a clock from the
> PRCM as func clock and for pixel clock. As the common clock framework is
> somehow involved in the breakage, maybe (pure guess) something related
> to the PRCM clock is configured wrong.

So whats the specific PRCM clock thats used here? I can go check if there is
something different in the way its modeled with/without common clk.

regards,
Rajendra

> 
> And with reverting the above patch, DSS uses DSI PLL for fclk and pclk,
> and DSI PLL in turn only needs sysclk, so maybe the possible problem
> with PRCM doesn't affect this case.
> 
>  Tomi
> 
> 

