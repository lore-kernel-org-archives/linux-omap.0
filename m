From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/10] OMAP clock/SDRC patches on v2.6.30-rc5
Date: Tue, 26 May 2009 10:29:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905261025350.17019@utopia.booyaka.com>
References: <20090512235713.10349.49339.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38406 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZEZQ3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 12:29:52 -0400
In-Reply-To: <20090512235713.10349.49339.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hello Russell,

On Tue, 12 May 2009, Paul Walmsley wrote:

> This series contains OMAP clock and SDRAM controller patches against
> v2.6.30-rc5.  If you are happy with these, Tony will merge them into
> his for-next branch for you to pull.
> 
> This series includes the clk_init_one() to clk_preinit() rename that
> we've discussed recently.  Most of the patches prepare for CORE DPLL
> M2 rate changing support.

Any comments on these patches?


- Paul
