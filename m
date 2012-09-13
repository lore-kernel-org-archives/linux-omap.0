From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clean up smatch warnings and unwrap
 strings, for 3.7
Date: Wed, 12 Sep 2012 22:04:32 -0700
Message-ID: <20120913050431.GB4521@atomide.com>
References: <alpine.DEB.2.00.1209121507510.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11439 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753744Ab2IMFEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 01:04:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209121507510.17903@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120912 08:09]:
> Hi Tony,
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-b-for-3.7
> 
> for you to fetch changes up to 7852ec0536ca39cefffc6301dc77f8ae55592926:
> 
>   ARM: OMAP: unwrap strings (2012-09-12 02:57:10 -0600)
> 
> ----------------------------------------------------------------
> smatch and string-wrapping cleanups for the OMAP subarch code.
> 
> These changes fix some of the more meaningful warnings that smatch
> returns for the OMAP subarch code, and unwraps strings that are
> wrapped at the 80-column boundary, to conform with the current
> practice.

Thanks pulling into cleanup-makefile-sparse branch.

Regards,

Tony
