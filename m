From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
Date: Thu, 2 Feb 2012 03:05:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202020302400.586@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com> <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com> <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
 <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com> <CAMQu2gw5uU4kXRWtuUuYAAUcrTJvS_nQhJ42-_hEmHM2NO8ZZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57034 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab2BBKFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 05:05:01 -0500
In-Reply-To: <CAMQu2gw5uU4kXRWtuUuYAAUcrTJvS_nQhJ42-_hEmHM2NO8ZZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2 Feb 2012, Shilimkar, Santosh wrote:

> Yes, we do have issue with below APIs for OMAP4 and onwards design
> because of the PRCM change.
> 
> pwrdm_clear_all_prev_pwrst
> pwrdm_*_mem_*
> 
> There use to be a single power state and memory state register till OMAP3
> at power domain level which can give you the logic and memory last test
> which is needed for OSWR.
> 
> On OMAP4, we have registers per modules and it becomes difficult to model
> this difference in APIs. Initially we tried to fix that with [1] and
> then later realized
> that's not going to work on OMAP4 + devices because of mentioned issue.

If the registers are per-module, it seems like the best place for those 
would be the hwmod layer.  Do you think that makes sense?  So, something 
like omap_hwmod_clear_all_prev_pwrst(), etc.?  Seems like that should be 
pretty efficient.


- Paul
