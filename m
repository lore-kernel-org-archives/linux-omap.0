From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: gpmc-onenand: fix sync mode setup with DT
Date: Thu, 3 Oct 2013 11:00:43 -0700
Message-ID: <20131003180043.GN8949@atomide.com>
References: <1379707266-2301-1-git-send-email-aaro.koskinen@iki.fi>
 <20131001213318.GA29989@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55285 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754692Ab3JCSAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 14:00:55 -0400
Content-Disposition: inline
In-Reply-To: <20131001213318.GA29989@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [131001 14:41]:
> Hi,
> 
> Any comments about the below patch? If my analysis is correct, this issue
> needs to be fixed before any boards that set ONENAND_SYNC_READWRITE can
> be converted to DT. So the fix should be applied preferably during the
> current rc-cycle.

Thanks I'll apply it into omap-for-v3.12/fixes.

Regards,

Tony
