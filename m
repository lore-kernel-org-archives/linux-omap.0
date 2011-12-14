From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Wed, 14 Dec 2011 15:50:04 +0800
Message-ID: <20111214074922.GM28768@b20223-02.ap.freescale.net>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:54709
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753216Ab1LNHuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 02:50:18 -0500
Content-Disposition: inline
In-Reply-To: <1323834838-2206-4-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux@arm.linux.org.uk, andrew@lunn.ch, linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, jeremy.kerr@canonical.com, mturquette@ti.com, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, tglx@linutronix.de, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, paul@pwsan.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com

Hi Mike,
> + *
> + * @recalc_rate	Recalculate the rate of this clock, by quering hardware
> + * 		and/or the clock's parent. It is up to the caller to insure
> + * 		that the prepare_mutex is held across this call.  Returns the
> + * 		calculated rate.  Optional, but recommended - if this op is not
> + * 		set then clock rate will be initialized to 0.
I'm still concerned, if it's NULL, why don't just retrun parent's rate if it has? 
 
Thanks
Richard

