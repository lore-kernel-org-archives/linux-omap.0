From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Move DT wake-up event handling over to
 use pinctrl-single-omap
Date: Fri, 7 Jun 2013 13:52:19 -0700
Message-ID: <20130607205219.GG3331@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205046.16513.2802.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57696 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756177Ab3FGUwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 16:52:23 -0400
Content-Disposition: inline
In-Reply-To: <20130607205046.16513.2802.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [130607 13:56]:
> Now pinctrl-single-omap can handle the wake-up events for us now
> as long as the events are configured in the .dts files.

This patch I should queue separately, the rest should go via
the pinctrl tree.

Regards,

Tony
