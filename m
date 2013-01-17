From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
Date: Thu, 17 Jan 2013 22:31:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301172230250.14118@utopia.booyaka.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com> <50F85087.3060507@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43320 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab3AQWbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 17:31:21 -0500
In-Reply-To: <50F85087.3060507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Thu, 17 Jan 2013, Jon Hunter wrote:

> Yes I still see it. You don't see it on reboot?

Ah that's probably explains the discrepancy - I missed the part about the 
reboot.

> The reason why there is such a large number is because
> omap2_round_to_table_rate() is returning the value -EINVAL. You could
> add a print to omap2_round_to_table_rate() to see what it returns on
> reboot. Or we could add a WARN to the function is sys_ck_rate is 0 for
> testing.
> 
> > Also, there's already a call to omap2xxx_clkt_vps_check_bootloader_rates() 
> > -- is it necessary to add another one?
> 
> Thanks. I see that now and so that is not needed then.

OK, I'll queue your patch for 3.8-rc fixes, dropping the 
omap2xxx_clkt_vps_check_bootloader_rates() calls.


- Paul
