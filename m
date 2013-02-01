From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] omap: craneboard: support the TPS65910 PMU
Date: Fri, 1 Feb 2013 10:22:17 -0800
Message-ID: <20130201182216.GI22517@atomide.com>
References: <A874F61F95741C4A9BA573A70FE3998F6418F140@DQHE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753140Ab3BASWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 13:22:20 -0500
Content-Disposition: inline
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F6418F140@DQHE02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

* Kim, Milo <Milo.Kim@ti.com> [121128 22:44]:
>  This patch supports the TPS65910 PMU function on the AM3517 Craneboard.
>  The IRQ pin, SYS_NIRQ is dedicated connection between the AM3517 and
>  the TPS65910 PMU.
>  To handle the PMU IRQs, mux configuration is required.
> 
>  Platform data configuration:
>  .IRQ number : SYS_NIRQ (M_IRQ_7)
>  .External clock source : external 32KHz clock is connected

Thanks applying 1 and 2 into omap-for-v3.9/board. Did not
see patch 3 of this anywhere?

Anyways, let's plan on making this work with device tree and
keep the changes to the board-*.c files to minimum.

Regards,

Tony
