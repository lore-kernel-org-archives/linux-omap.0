From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2: io: fix clk_get() error check
Date: Thu, 2 Dec 2010 17:10:57 -0800
Message-ID: <20101203011057.GD17222@atomide.com>
References: <1291126678-2782-1-git-send-email-aaro.koskinen@nokia.com>
 <87vd3c4h8p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54356 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab0LCBLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 20:11:10 -0500
Content-Disposition: inline
In-Reply-To: <87vd3c4h8p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101202 02:01]:
> Aaro Koskinen <aaro.koskinen@nokia.com> writes:
> 
> > clk_get() return value should be checked with IS_ERR().
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, will queue.

Tony
