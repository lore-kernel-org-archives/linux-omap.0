From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] plat-omap: mcbsp: Configure wakeup in later phase
Date: Mon, 5 Mar 2012 11:50:33 -0800
Message-ID: <20120305195032.GO12083@atomide.com>
References: <1323941697-7902-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab2CETui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:50:38 -0500
Content-Disposition: inline
In-Reply-To: <1323941697-7902-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Peter,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111215 01:03]:
> Configure the WAKEUPEN register at the same time we configure the rest of
> the McBSP registers.
> In case of OMAP3+, if the sysclock has been reconfigured we are going to
> disable McBSP for the duration of the clock change, which will reset the
> McBSP registers. The WAKEUPEN register need to be configured later, so
> the changes will be effective during runtime.

Just checking.. I assume this one is already taken care of with your
other McBSP changes?

Tony
