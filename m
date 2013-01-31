From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/5] ARM: OMAP2+: Simplify system timers definitions
Date: Thu, 31 Jan 2013 11:09:45 +0200
Message-ID: <510A34D9.1000407@compulab.co.il>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52870 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab3AaJJv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 04:09:51 -0500
In-Reply-To: <1359565471-30721-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>



On 01/30/13 19:04, Jon Hunter wrote:
> There is a lot of redundancy in the definitions for the various system
> timers for OMAP2+ devices. For example, the omap3_am33xx_gptimer_timer_init()
> function is the same as the omap3_gp_gptimer_timer_init() function and the
> function omap2_sync32k_timer_init() can be re-used for OMAP4/5 devices.
> Therefore, consolidate the definitions to simplify the code.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
