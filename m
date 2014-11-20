From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some clock/hwmod patches for v3.19
Date: Thu, 20 Nov 2014 17:29:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411201727550.9204@utopia.booyaka.com>
References: <alpine.DEB.2.02.1411132249550.17030@utopia.booyaka.com> <20141114184719.GA7046@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38895 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbaKTR3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 12:29:54 -0500
In-Reply-To: <20141114184719.GA7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 14 Nov 2014, Tony Lindgren wrote:

> Pulling into omap-for-v3.19/soc thanks. FYI, looks like there are
> few more open hwmod related threads you may want to look at:

Thanks for the ping...

> [PATCH v2 0/3] Add support for ADC on am437x-gp and am43x-epos-evm

Just posted some comments about this ADC one.

> [RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
> [PATCH] ARM: DRA7: hwmod data: Add missing UART hwmod data

Reviewed & pulled these into a branch and just sent the pull request; 
thanks.

Looks like Lokesh has another DRA7xx hwmod data patch for RTC that seems 
to be a fix.  Have sent some comments.  That one might come in late for 
v3.18-rc if it turns out to pertain to those kernels.


- Paul
