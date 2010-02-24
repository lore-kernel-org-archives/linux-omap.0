From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] Second set of OMAP clock/hwmod patches for 2.6.34
Date: Wed, 24 Feb 2010 11:02:12 -0800
Message-ID: <20100224190211.GS28173@atomide.com>
References: <alpine.DEB.2.00.1002241116000.2701@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64178 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab0BXTBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 14:01:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002241116000.2701@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [100224 10:15]:
> 
> Hi Tony,
> 
> The following changes since commit 0482e3c6f704d25b6a4e3c940caeeacece4e6d74:
>   Tony Lindgren (1):
>         Merge branch 'omap-fixes-for-linus' into omap-for-linus
> 
> are available in the git repository at:
> 
>   git://git.pwsan.com/linux-2.6 for_2.6.34_b

Hmm this does not seem to merge without conflicts to omap-for-linus,
maybe take a look if you can merge/rebase it?

I'd assume rebasing or merging your branch with
80c20d543d142ee54ec85259b77aaf0b83c32db5 will do the trick.

Regards,

Tony
