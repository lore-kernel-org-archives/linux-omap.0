From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
Date: Thu, 30 Aug 2012 13:20:58 -0700
Message-ID: <20120830202057.GY1303@atomide.com>
References: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
 <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
 <503E9129.9060408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24510 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2H3UVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:21:02 -0400
Content-Disposition: inline
In-Reply-To: <503E9129.9060408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120829 15:02]:
> On 08/28/12 01:43, Shilimkar, Santosh wrote:
> > On Mon, Aug 27, 2012 at 3:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >> Currently, omap2_sync32k_clocksource_init() function initializes the 32K
> >> timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
> >> setting.
> >> Fix this by providing a default implementation for
> >> !CONFIG_OMAP_32K_TIMER case.
> >>
> >> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> >> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> >> ---
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Thanks Santosh!
> 
> Tony, apparently, this bug has been there for a while,
> so probably I should have added:
> Cc: stable@vger.kernel.org

Thanks I'll apply this into fixes with Cc: stable. Note that
Cc: stable is usually added at commit time, or at least you're
not supposed to send the patch for review there.

Regards,

Tony
