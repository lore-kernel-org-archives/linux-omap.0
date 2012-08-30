From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: cleanup plat/board.h file
Date: Thu, 30 Aug 2012 11:55:56 -0700
Message-ID: <20120830185556.GT1303@atomide.com>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11387 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823Ab2H3S4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 14:56:05 -0400
Content-Disposition: inline
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120828 16:19]:
> This patch series cleans up the plat/board.h and related files.

Great, thanks for doing this! Nice that we can finally remove
all of that. I've also tested that 770 boots after this, so
looks like we've already fixed up whatever it was depending on.

I'll be applying this into the cleanup branch as soon as I'll
have an immutable commit for Arnd's treewide changes to move
the obvious things into include/linux/platform_data.

Regards,

Tony
