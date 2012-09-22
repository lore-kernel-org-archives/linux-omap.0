From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sat, 22 Sep 2012 00:03:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com> <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab2IVADs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 20:03:48 -0400
In-Reply-To: <20120921231039.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 21 Sep 2012, Tony Lindgren wrote:

> I tried merging this into tmp-merge, but ran into all kinds of
> merge conflicts with the am33xx code etc and ended up with a
> result that booted with all kinds of warnings on 2430sdp and
> did not boot at all on zoom3 :) So I probably did something
> wrong..
> 
> Care to base this on something more mergeable?

Just let me know what you want me to base it on.

> Maybe a merge of cleanup-fixes-for-v3.7 + omap-devel-am33xx-for-v3.7?

The series rebases cleanly onto cleanup-fixes-for-v3.7 + 
omap-devel-am33xx-for-v3.7, so I guess you'll probably want me to base it 
somewhere else?


- Paul
