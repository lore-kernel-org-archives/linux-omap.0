From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 2/2] mcx: support for HTKW mcx board
Date: Mon, 5 Mar 2012 11:55:18 -0800
Message-ID: <20120305195518.GQ12083@atomide.com>
References: <1324482822-24221-1-git-send-email-yanok@emcraft.com>
 <1324482822-24221-3-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515Ab2CETzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:55:20 -0500
Content-Disposition: inline
In-Reply-To: <1324482822-24221-3-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Ilya Yanok <yanok@emcraft.com> [111221 07:21]:
> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.

This one I can carry in testing-board until device tree works
for us in a usable way. But probably some rebasing is needed
for this after the hsmmc stuff is cleared out of the way.

Regards,

Tony
