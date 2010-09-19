From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/5] omap3: Introduce CompuLab CM-T3517 module.
Date: Sun, 19 Sep 2010 10:58:35 +0200
Message-ID: <4C95D0BB.4010304@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il> <1284627281-26059-2-git-send-email-grinberg@compulab.co.il> <20100916175317.GF29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:46559 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab0ISI6l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Sep 2010 04:58:41 -0400
In-Reply-To: <20100916175317.GF29610@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

 On 09/16/10 19:53, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [100916 01:46]:
>> Add basic suppot, enable uart and led.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/Kconfig          |    7 ++
>>  arch/arm/mach-omap2/Makefile         |    1 +
>>  arch/arm/mach-omap2/board-cm-t3517.c |  109 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 117 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/board-cm-t3517.c
> Looks like you're missing the debug uart entry for
> arch/arm/plat-omap/include/plat/uncompress.h?
>
> You can test this by enabling DEBUG_LL and EARLY_PRINTK
> in your .config, then pass earlyprintk in the kernel
> cmdline. Might become handy for debugging the early
> init process for your board.

Indeed can be useful.

Thanks.

> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.

