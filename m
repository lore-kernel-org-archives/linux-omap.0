From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
Date: Tue, 8 Oct 2013 11:34:10 -0700
Message-ID: <20131008183410.GJ8313@atomide.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38417 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752473Ab3JHSeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 14:34:14 -0400
Content-Disposition: inline
In-Reply-To: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com

* Rajendra Nayak <rnayak@ti.com> [130827 03:19]:
> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
> use drivers/misc/sram.c driver instead of the omap internal
> implementation for SRAM handling.

Sounds like this series has some dependencies that we need
to clear, so marking this thread as read and assuming a new
series will be posted.

Regards,

Tony
