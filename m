From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] arm: mach-omap2: sdram-nokia: add 200 MHz memory
 timings info
Date: Fri, 9 Dec 2011 12:46:53 -0800
Message-ID: <20111209204653.GU31337@atomide.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
 <1323443211-3648-3-git-send-email-aaro.koskinen@nokia.com>
 <20111209180641.GS31337@atomide.com>
 <alpine.DEB.2.00.1112092136370.7393@kernel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24534 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1LIUq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 15:46:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112092136370.7393@kernel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Dmitriev <ext-dmitriev.igor@nokia.com>

* Aaro Koskinen <aaro.koskinen@nokia.com> [111209 11:11]:
> On Fri, 9 Dec 2011, Tony Lindgren wrote:
> >
> >Is that a typo above? Should it say nokia_100mhz_timings?
> 
> No, it's not a typo, same data is used. (Like 83/166 already in the table)

OK thanks, applying this into board branch.

Tony
