From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/26] ARM: OMAP3: clock: Add 3xxx data using common
 struct clk
Date: Fri, 9 Nov 2012 00:49:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211090047250.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <1352337181-29427-15-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com> <alpine.DEB.2.00.1211082158310.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211090002380.20703@utopia.booyaka.com> <alpine.DEB.2.00.1211090028250.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55466 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264Ab2KIAtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 19:49:17 -0500
In-Reply-To: <alpine.DEB.2.00.1211090028250.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, 9 Nov 2012, Paul Walmsley wrote:

> The enables and disables of dpll4_m2x2_ck from the entire log appear to be balanced:

Looks like this is an artifact of the disable-unused-clocks problem.  The 
disable of dpll4_m6x2_ck during that phase removes the usecount that was 
previously added by the enable of dpll4_m2x2_ck.  So fixing that problem 
should clean this one up.

- Paul
