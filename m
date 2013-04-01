From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Query regarding clk framework - from .set_rate api
Date: Mon, 1 Apr 2013 16:14:17 +0530
Message-ID: <51596501.1020904@ti.com>
References: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759372Ab3DAKob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:44:31 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "mturquette@linaro.org" <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

> 
> Where, the clk_set_rate() seems to be not working, and that's true
> with the current implementation of OMAP/AM33xx clock tree,
> as the CLK_SET_RATE_PARENT flag is not set to any of the clock nodes.
> 
> Please note that I am using DEFINE_STRUCT_CLK() macro for defining clocks
> And which doesn't allow you to specify the flags.

Use DEFINE_STRUCT_CLK_FLAGS() then. Its already used in AM33xx clock tree.
