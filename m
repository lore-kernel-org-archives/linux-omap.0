From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Fix the timer fck clock naming
 convention
Date: Mon, 27 Aug 2012 17:15:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1208271715240.26953@utopia.booyaka.com>
References: <1342462158-15998-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab2H0RPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 13:15:36 -0400
In-Reply-To: <1342462158-15998-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, 16 Jul 2012, Vaibhav Hiremath wrote:

> With commit ae6df418a21f3a361c5f9b878e32a8aba4e17692
> Sub: ARM: OMAP2+: dmtimer: cleanup fclk usage)
> The Timer functional clock naming convention has changed from
> gptX_fck => timerXfck, and so as the timer init function
> in mach-omap2/timer.c.
> OMAP4 clocktree also has changed accordingly.
> 
> AM33xx Clock Tree has been merged during rc3-4 timeframe,
> before above commit got merged, so similar change is required
> for AM33xx as well (Change the gptX_fck => timerX_fck).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks, queued for v3.6-rc.


- Paul
