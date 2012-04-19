From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 12/12] ARM: OMAP2xxx: hwmod data: start to fix the IVA1,
 IVA2 and DSP
Date: Thu, 19 Apr 2012 03:38:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204190338020.29048@utopia.booyaka.com>
References: <20120308023614.8205.78768.stgit@dusk> <20120308023840.8205.51532.stgit@dusk> <alpine.DEB.2.00.1204190317030.29048@utopia.booyaka.com> <20120419092823.GW25053@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1204190331560.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56199 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2DSJiZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 05:38:25 -0400
In-Reply-To: <alpine.DEB.2.00.1204190331560.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 19 Apr 2012, Paul Walmsley wrote:

> Thanks for the report.  Those should be resolved by:
> 
> ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset 
> wait for reset status"
> 
> which was sent upstream to Tony as part of
> 
> http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=commit;h=3c55c1baffa5f719eb2ae9729088bc867f972f53

Sorry about that, meant to send a link to the tag:

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=tag;h=bb3fbe167596650383f423e0a495971086e5c069


- Paul
