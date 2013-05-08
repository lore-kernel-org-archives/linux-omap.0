From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Wed, 8 May 2013 12:45:04 -0700
Message-ID: <20130508194504.GD32546@atomide.com>
References: <cover.1368038129.git.jason@lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61369 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3EHTpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:45:08 -0400
Content-Disposition: inline
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> 
> Tony has been helping me out offline with this, and he suggested trying the
> gpmc against Linus' ToT.  Which locks up before it even has a chance to get
> going.  So this series is against v3.9.

You may have better luck with today's mainline treeand the following fix:

http://lkml.org/lkml/2013/5/8/374#

Regards,

Tony
