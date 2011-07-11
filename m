From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: SoC data/core: cleanups for 3.1
Date: Mon, 11 Jul 2011 01:32:26 -0700
Message-ID: <20110711083225.GO5783@atomide.com>
References: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23192 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757371Ab1GKIc3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 04:32:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110709 19:32]:
> Hello Tony,
> 
> The following changes since commit ecba3287b4121dcf3ca7607fe71c205913edec06:
> 
>   Merge branch 'cleanup-part-2' of git+ssh://master.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 into omap/cleanup (2011-07-08 15:01:45 +0000)
> 
> are available in the git repository at:
> 
>   git://git.pwsan.com/linux-2.6 prcm-cleanup-3.1

I've merged this into linux-omap master for testing and
also merged it into cleanup-part-3 along Russell's timer
cleanup patch.

Paul, please use the mainline tags or linux-omap static branches
instead of the arm-soc branches. In this case there's only the extra
merge commit there, so not a problem. Now it just makes it a bit
harder for me to do pull requests and diffs to other branches.

In general, we want to keep the dependencies between branches and
other trees to minimum.

Regards,

Tony
