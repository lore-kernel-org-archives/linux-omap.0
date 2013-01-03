From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: fix USB configuration use-after-release
Date: Thu, 3 Jan 2013 11:33:29 -0800
Message-ID: <20130103193329.GF25633@atomide.com>
References: <1356123392-6172-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41556 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753017Ab3ACTdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 14:33:32 -0500
Content-Disposition: inline
In-Reply-To: <1356123392-6172-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [121221 12:59]:
> All boards, except Amstrad E3, mark USB config with __initdata.
> 
> As a result, when you compile USB into modules, they will try to refer
> already released platform data and the behaviour is undefined. For example
> on Nokia 770, I get the following kernel panic when modprobing ohci-hcd:

Thanks applying into omap-for-v3.8-rc2/fixes.

Tony
