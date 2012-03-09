From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Fri, 9 Mar 2012 11:04:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com> <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com> <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49023 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2CISEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:04:09 -0500
In-Reply-To: <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, 9 Mar 2012, Paul Walmsley wrote:

> Please let's not merge this one yet.  It should not be necessary to change 
> the clkdev aliases, this change should occur in the hwmod code.

Sorry, sent this too quickly.  Not the hwmod code, but the opt_clks 
aliases in the hwmod data.


- Paul
