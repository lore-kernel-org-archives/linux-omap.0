From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] MTD: NAND: ams-delta: convert to platform driver
Date: Tue, 14 Dec 2010 14:28:21 -0800
Message-ID: <20101214222821.GA14990@atomide.com>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
 <1292346023.2538.103.camel@localhost>
 <201012142109.42784.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab0LNW2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 17:28:37 -0500
Content-Disposition: inline
In-Reply-To: <201012142109.42784.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101214 12:31]:
> In its current form, the driver may interfere with different hardware on 
> different boards if built into the kernel, hence is not suitable for 
> inclusion into a defconfig, inteded to be usable with multiple OMAP1 cpu and 
> machine types.
> 
> Convert it to a platform driver, that should be free from this issue.
> 
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.

Good to see this happen, I assume this is for MTD. If not and you
want me to merge it instead, let me know.

Acked-by: Tony Lindgren <tony@atomide.com>
