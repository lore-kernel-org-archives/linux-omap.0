From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Mon, 8 Oct 2012 20:01:27 -0700
Message-ID: <20121009030126.GB12552@atomide.com>
References: <cover.1349450723.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17125 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754517Ab2JIDBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 23:01:31 -0400
Content-Disposition: inline
In-Reply-To: <cover.1349450723.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [121005 09:02]:
> 
> Proposed generic routine has been tested on OneNAND (async) on
> OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
> local patch were used to test). For other cases of custom timing
> calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
> calculation routine was verified by simulating on OMAP3EVM.

Have you tested to make sure this works if you change the
L3 frequency?

That should probably be tested as a sanity check. Maybe you
can force the L3 for some test boots for this, I don't think
we scale it by default.

Regards,

Tony
