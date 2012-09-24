From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Mon, 24 Sep 2012 19:51:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209241950370.25811@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com> <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com> <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com> <20120922002111.GP28835@atomide.com>
 <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com> <20120923190933.GS28835@atomide.com> <20120923210638.GT28835@atomide.com> <alpine.DEB.2.00.1209240102290.31370@utopia.booyaka.com> <20120924023031.GW28835@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39631 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab2IXTv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 15:51:58 -0400
In-Reply-To: <20120924023031.GW28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, 23 Sep 2012, Tony Lindgren wrote:

> OK thanks, that should work. The nasty merge conflicts seem to have been
> caused by mostly commit df3d17e0 (ARM: pmu: remove arm_pmu_type enumeration)
> that easily causes a nasty mis-merge of omap_init_pmu() and omap_init_rng()
> without removing omap_init_pmu() which your patches move to a different
> location.

OK thanks.  From now on, will make sure that merge window pull requests 
are based on any upstream cleanup series that affect the same code.


- Paul
