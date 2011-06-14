From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/2] omap: mcbsp: Drop SPI mode support
Date: Tue, 14 Jun 2011 04:36:09 -0700
Message-ID: <20110614113608.GP3352@atomide.com>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53969 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756410Ab1FNLgN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:36:13 -0400
Content-Disposition: inline
In-Reply-To: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110614 04:18]:
> We haven't seen any use for the SPI API in McBSP driver over the years. More
> over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode is not
> even supported since OMAP2430 so it's very unlikely that we'll see any use
> for it in the future either.

Sounds fair to me, our first priority should be to get this
code moved to live under drivers. If the SPI support is needed,
it can be added back later on.

Regards,

Tony
