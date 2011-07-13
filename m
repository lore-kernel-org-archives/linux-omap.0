From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] OMAP: SoC data/core: cleanups for 3.1
Date: Wed, 13 Jul 2011 00:38:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107130037140.30229@utopia.booyaka.com>
References: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com> <20110711083225.GO5783@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44645 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928Ab1GMGii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 02:38:38 -0400
In-Reply-To: <20110711083225.GO5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Mon, 11 Jul 2011, Tony Lindgren wrote:

> Paul, please use the mainline tags or linux-omap static branches
> instead of the arm-soc branches. In this case there's only the extra
> merge commit there, so not a problem. Now it just makes it a bit
> harder for me to do pull requests and diffs to other branches.
> 
> In general, we want to keep the dependencies between branches and
> other trees to minimum.

Sorry about that.  It was a misunderstanding on my part.

Would you like me to rebase the prcm-fixes-3.1 and prcm-devel-3.1 branches 
on a different branch/commit?


- Paul
