From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
 end
Date: Thu, 21 Apr 2011 09:22:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org> <20110420072156.GA28679@atomide.com> <alpine.LFD.2.00.1104200850030.24613@xanadu.home> <20110420165514.GE10402@atomide.com> <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com> <20110421104954.GH13688@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43983 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1DUNWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 09:22:10 -0400
Received: by qwk3 with SMTP id 3so848505qwk.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:22:09 -0700 (PDT)
In-Reply-To: <20110421104954.GH13688@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

On Thu, 21 Apr 2011, Tony Lindgren wrote:

> Otherwise we end up overwriting ourselves. This fixes booting
> on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> (ARM: 6750/1: improvements to compressed/head.S).
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I don't understand why this is needed.  The copy loop is explicitly 
copying from the end going backward exactly to cope with this 
possibility.

Hmmm...


Nicolas
