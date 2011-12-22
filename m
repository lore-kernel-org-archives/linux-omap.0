From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: device PM constraints: preparatory
 support
Date: Thu, 22 Dec 2011 10:13:13 -0800
Message-ID: <20111222181313.GL24444@atomide.com>
References: <alpine.DEB.2.00.1112201251010.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14840 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1LVSNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 13:13:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112201251010.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111220 11:21]:
> Hi Tony
> 
> These patches prepare for the introduction of the powerdomain device PM 
> constraints, via the standard Linux device PM mechanism that Rafael 
> Wysocki introduced.
> 
> After the powerdomain device PM constraints go in, we should be able to 
> remove some of the OMAP PM interface (currently via platform_data function 
> pointers) currently in our tree.

Thanks pulling these into hwmod-part2, no idea if we can still get
these in as it's so close to the merge window.

Regards,

Tony
