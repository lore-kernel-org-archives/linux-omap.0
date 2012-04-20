From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod cleanup series for 3.5
Date: Thu, 19 Apr 2012 17:53:32 -0700
Message-ID: <20120420005332.GY21106@atomide.com>
References: <alpine.DEB.2.00.1204191157180.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55603 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab2DTAxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 20:53:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204191157180.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120419 11:02]:
> Hi Tony,
> 
> The following changes since commit 1f5e6247ca99287bac87aff4971a7eee9c2b223a:
> 
>   ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface (2012-04-13 05:28:34 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-cleanup-b-for-3.5
> 
> for you to fetch changes up to 3af35fbcd088e0b675fa423a879c596384894180:
> 
>   ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-04-19 04:25:08 -0600)
> 
> ----------------------------------------------------------------
> Clean up various aspects of the OMAP hwmod code, which is the IP block
> control code for OMAP SoCs.  In particular, this series results in
> a considerable diffstat savings by changing the way that IP block
> interconnections are defined.

Thanks pulling this into cleanup-hwmod and merging into linux-omap
master.

Tony
