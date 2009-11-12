From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC related patches
Date: Wed, 11 Nov 2009 18:29:31 -0800
Message-ID: <20091112022931.GV24837@atomide.com>
References: <00b401ca632b$8c84d6e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64013 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759936AbZKLC31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 21:29:27 -0500
Content-Disposition: inline
In-Reply-To: <00b401ca632b$8c84d6e0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan <madhu.cr@ti.com> [091111 16:02]:
> Hi Tony,
> 
> Just a ping on the below patches. I did not see any comments on them. Are
> you planning to push them?
> 
> Regards,
> Madhu
> 
> http://marc.info/?l=linux-omap&m=125668573422479&w=2
> http://marc.info/?l=linux-omap&m=125624185318767&w=2

OK, adding.

> http://marc.info/?l=linux-omap&m=125623349405262&w=2

This needs to be refreshed against board-zoom-peripherals.c now
in omap for-next. But if it depends on 3630 mux patch,
let's wait on that until we have the new mux framework.

> http://marc.info/?l=linux-omap&m=125623339105103&w=2
> http://marc.info/?l=linux-omap&m=125623327504912&w=2

Adding.

Also, this needs to be refreshed:

http://patchwork.kernel.org/patch/45196/

Thanks for summarizing the patches, that always helps.
Maybe use patchwork.kernel.org links the next time,
as I can directly apply from those?

Or even better, just set a git branch against some static
commit :) (Not against for-next as that's still changing)

BTW, some of these patches I had to unwrap manually again..

Regards,

Tony
