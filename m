From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2: clock data migration to DT for 3.17 merge
 window
Date: Wed, 9 Jul 2014 08:43:52 -0700
Message-ID: <20140709154352.GB28884@atomide.com>
References: <53B59E73.1020709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52833 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbaGIPnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 11:43:52 -0400
Content-Disposition: inline
In-Reply-To: <53B59E73.1020709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, aaro.koskinen@iki.fi

* Tero Kristo <t-kristo@ti.com> [140703 11:19]:
> Hi Tony,
> 
> Posting this pull-request also early due to my holidays. Anyway, these
> patches were supposed to go in already during 3.16 merge window, but they
> missed it due to pending dependencies. Finalizes the move of OMAP24xx clock
> data to the DT, and also removes the legacy clock data. Might be good to try
> this branch out with n800 / 2420 hardware also as I don't have access to
> those.
> 
> ---------------------------------------------------------------
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git@github.com:t-kristo/linux-pm.git for-v3.17/omap2-use-dt-clks
> 
> for you to fetch changes up to 6a194a6e2a8fa55e133936a124ed500aea434116:
> 
>   ARM: OMAP24xx: clock: remove legacy clock data (2014-07-02 15:59:03 +0300)

OK thanks pulling this into omap-for-v3.17/dt.

Tony
