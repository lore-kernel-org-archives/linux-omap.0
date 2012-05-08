From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
Date: Tue, 8 May 2012 13:58:22 -0700
Message-ID: <20120508205822.GF5088@atomide.com>
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
 <87zk9j5216.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65167 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083Ab2EHU6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:58:25 -0400
Content-Disposition: inline
In-Reply-To: <87zk9j5216.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120507 10:37]:
> Tony,
> 
> Kevin Hilman <khilman@ti.com> writes:
> 
> > The detection of AM35xx SoCs is confusing and has redundancies.  Clean
> > this up so that SoC detection is only based on SoC family: AM35xx.
> 
> Since these aren't PM related, can you queue these with other cleanups
> for v3.5.  This is now independent from the similar changes made to the
> clock fwk which Paul is queuing.

OK applied now to cleanup branch and just pushed out. Had to update them
a bit for the hwmod changes done by Paul.
 
> Once both series are merged, I'll have one final patch that removes all
> users of cpu_is_omap35*.

OK can you please do that one against the current cleanup branch at
commit a75bf667d6535af66d34f8d7be0a36aa2a96c56e?

Regards,

Tony
