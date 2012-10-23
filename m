From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources pdata function pointer (fwd)
Date: Tue, 23 Oct 2012 10:05:33 +0200
Message-ID: <20121023080533.GA16482@spo001.leaseweb.com>
References: <alpine.DEB.2.00.1210180125140.30902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:37330 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728Ab2JWIFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 04:05:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210180125140.30902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org

Hi Paul,

> When you have the opportunity, could you take a look at this patch, and 
> the subsequent patch 6/7, and ack them if you're okay with them?

Signed them off, Acked-by would probably have been better :-).

> We'd like to merge thse as part of a larger cleanup series through the 
> arm-soc tree.  They like cleanup patches to arrive at the beginning of the 
> -rc series, which means that we need to have the pull request sent pretty 
> soon.

Please go ahead. The sooner those ifdefs are gone the better.

Kind regards,
Wim.
