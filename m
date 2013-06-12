From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/3] arm: gpmc: Low power transition support
Date: Wed, 12 Jun 2013 10:01:27 -0700
Message-ID: <20130612170126.GI8164@atomide.com>
References: <1371034858-19984-1-git-send-email-pekon@ti.com>
 <1371034858-19984-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12843 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754631Ab3FLRBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 13:01:32 -0400
Content-Disposition: inline
In-Reply-To: <1371034858-19984-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, avinash philip <avinashphilip@ti.com>

* Pekon Gupta <pekon@ti.com> [130612 04:07]:
> From: avinash philip <avinashphilip@ti.com>
> 
> With GPMC converted to platform driver recently, adds low power
> transition support in driver itself.

Applying the first two patches of this series into omap-for-v3.11/gpmc.
Not taking the MTD patch, if it has dependencies to the first two
patches please let me know and also get an ack from Artem if you
want me to take it.

Regards,

Tony
