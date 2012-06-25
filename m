From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PRCM/hwmod: reimplement the OMAP PRCM
 I/O chain code for 3.6
Date: Mon, 25 Jun 2012 08:36:23 -0700
Message-ID: <20120625153623.GF12766@atomide.com>
References: <alpine.DEB.2.00.1206220935000.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab2FYPg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 11:36:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206220935000.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, vishwanath.bs@ti.com, t-kristo@ti.com, rnayak@ti.com, mohanv@ti.com

* Paul Walmsley <paul@pwsan.com> [120622 08:41]:
> Hi Tony
> 
> The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:
> 
>   Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.6
> 
> for you to fetch changes up to fafcdd53220f44d7ae2f06a9ce20c8d550df2d9b:
> 
>   ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle (2012-06-22 08:40:36 -0600)
> 
> ----------------------------------------------------------------
> Reimplement the OMAP PRCM I/O chain code.  Needed for I/O wakeups to
> work correctly.

Thanks pulling into devel-pm branch.

Tony
