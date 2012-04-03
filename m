From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: powerdomain: Get rid off duplicate
 pwrdm_clkdm_state_switch() API
Date: Tue, 3 Apr 2012 17:58:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204031758340.8000@utopia.booyaka.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com> <1331562873-29535-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41238 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2DCX6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 19:58:46 -0400
In-Reply-To: <1331562873-29535-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

On Mon, 12 Mar 2012, Santosh Shilimkar wrote:

> With patch 'ARM: OMAP: powerdomain: Wait for powerdomain transition
> in pwrdm_state_switch()', the pwrdm_clkdm_state_switch() API becomes
> duplicate of pwrdm_state_switch().
> 
> Get rid off duplicate pwrdm_clkdm_state_switch() and update the
> users of it with pwrdm_state_switch()
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Rajendra Nayak <rnayak@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 3.5.


- Paul
