From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Wed, 12 Jun 2013 10:48:42 -0700
Message-ID: <20130612174842.GQ8164@atomide.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21523 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754906Ab3FLRsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 13:48:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130610 00:27]:
> 
> Hi folks -- particularly TIers working on mainline,
> 
> There are several regressions that started with v3.10-rc that no one's 
> fixed for over a month.  Some of them should be quite easy:
> 
> * 37xx EVM: boot fails
>   - as of v3.10-rc1
>   - Cause unknown

This one is probably because of broken GPIO numbering in
the board file that uses hardcoded GPIOs for what are probably
twl GPIOs.

Does commenting out omap3_evm_display_init() in the board file
fix the booting for you?

If so, we should probably mark omap3_evm_display_init() with
CONFIG_BROKEN for now rather than add more late init callback
functions for the twl code.

Regards,

Tony
