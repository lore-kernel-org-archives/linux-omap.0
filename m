From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: PM: register notifiers with generic clock ops
 even when !PM_RUNTIME
Date: Tue, 14 Jun 2011 05:41:38 -0700
Message-ID: <20110614124137.GD23145@atomide.com>
References: <1307491502-28883-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304Ab1FNMlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:41:42 -0400
Content-Disposition: inline
In-Reply-To: <1307491502-28883-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110607 17:00]:
> When runtime PM is disabled, device clocks need to be enabled on
> device add and disabled on device remove.  This currently is not
> happening because in the !PM_RUNTIME case, no notifiers are registered
> for OMAP1 devices.
> 
> Fix this by ensuring notifiers are registered, even in the !PM_RUNTIME case.
> 
> Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this fix should go in for v3.0-rc as well.

Adding to devel-fixes.

Tony
