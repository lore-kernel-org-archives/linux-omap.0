From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: OMAP4 DTS updates
Date: Wed, 9 May 2012 17:19:16 -0700
Message-ID: <20120510001915.GA21851@atomide.com>
References: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17517 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab2EJATU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 20:19:20 -0400
Content-Disposition: inline
In-Reply-To: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Benoit Cousson <b-cousson@ti.com> [120508 09:41]:
> Hi Tony,
> 
> Here is a small series I have done for 3.4 but never posted before.
> It adds GPIO node for twl4030 embedded gpio controller and some LEDs data
> to be able to get rid of the static init done in board file right now.
> 
> It is based on arm-soc/omap/dt-missed-3.4 to get the previous patches not yet
> in linus/master.

Thanks I'll apply these into dt branch.

Regards,

Tony
