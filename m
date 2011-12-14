From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/7] HACK: omap: convert 44xx data to common struct clk
Date: Tue, 13 Dec 2011 21:27:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com> <1323835918-2371-4-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48505 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab1LNE1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 23:27:33 -0500
In-Reply-To: <1323835918-2371-4-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, andrew@lunn.ch

Hi

On Tue, 13 Dec 2011, Mike Turquette wrote:

> omap_clk_get_by_name must die.

You do realize that it exists for a reason?  That hardware clock names 
don't have anything to do with the Linux device model?


- Paul
