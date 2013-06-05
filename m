From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in
 clock36xx.c
Date: Wed, 5 Jun 2013 18:21:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34152 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab3FESVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 14:21:03 -0400
In-Reply-To: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, rnayak@ti.com, Jean-Philippe Francois <jp.francois@cynove.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, khilman@linaro.org

Hi

On Thu, 30 May 2013, Jean-Philippe Francois wrote:

> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
> have parent defined as clk_divider. Instead of using container_of to eventually get
> to the register and directly mess with the divider, change freq via clk_set_rate, 
> and let the clock framework toggle the divider value.
> Tested with  3.9 on dm3730.
> 
> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>

Tested this patch before applying, and noticed that it causes the 
retention dynamic idle power management test to fail here on the 
3730beaglexm:

http://www.pwsan.com/omap/testlogs/fixes_b_v3.10-rc/20130605113443/pm/3730beaglexm/3730beaglexm_log.txt

Not sure at this point if this is caused by the patch, or if the patch is 
just unmasking another bug.

Jean, Mike, Rajendra, care to take a look at this?


- Paul
