From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling
 for 3.9
Date: Mon, 11 Feb 2013 17:45:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302111743520.8260@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com> <20130210170827.GK4801@atomide.com> <alpine.DEB.2.00.1302101726020.2672@utopia.booyaka.com> <20130211173731.GO4801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34306 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758274Ab3BKRpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 12:45:11 -0500
In-Reply-To: <20130211173731.GO4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 11 Feb 2013, Tony Lindgren wrote:

> This branch should probably have been based on your earlier PM branch
> based on v3.8-rc5 that was already merged as omap-for-v3.9/pm-signed into
> arm-soc for-next.
> 
> Now merging this branch based on v3.8-rc6 requires me to create a merge
> base by merging the earlier branch with v3.8-rc6 and then resolving
> the self-inflicted merge conflict in order for me to generate a pull request
> without a non-trivial merge conflict. Just a bunch of extra hassle to
> deal with with additional risk of merging things wrong. Anyways merging
> into omap-for-v3.9/pm-wfi-take2.

Sorry about that.  Will try to find better merge bases for future 
branches.  

- Paul
