From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Revert "ARM: OMAP3530evm: set pendown_state and
 debounce time for ads7846"
Date: Tue, 7 Aug 2012 03:58:47 -0700
Message-ID: <20120807105847.GX11011@atomide.com>
References: <876298iv9s.fsf@ti.com>
 <1344284535-16717-1-git-send-email-grinberg@compulab.co.il>
 <871ujj7ngd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2HGK6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:58:52 -0400
Content-Disposition: inline
In-Reply-To: <871ujj7ngd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Arnd Bergmann <arnd@arndb.de>

* Kevin Hilman <khilman@ti.com> [120806 13:52]:
> 
> The Overo boards were the ones that were crashing due to this bug since
> the pendown GPIO was the only one used in the bank.
> 
> Tony, can you queue this up for v3.6-rc?  I have a version in my
> for_3.6/fixes/ads7846-2 branch with the tags above applied, based on v3.6-rc1.

Yes thanks pulling into fixes.

Tony
