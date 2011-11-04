From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for
 ads7846
Date: Fri, 4 Nov 2011 16:57:20 -0700
Message-ID: <20111104235720.GG31337@atomide.com>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
 <1319017160-20391-2-git-send-email-grinberg@compulab.co.il>
 <20111104233938.GF31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61527 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751537Ab1KDX5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 19:57:24 -0400
Content-Disposition: inline
In-Reply-To: <20111104233938.GF31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111104 16:05]:
> * Igor Grinberg <grinberg@compulab.co.il> [111019 02:05]:
> 
> Applying to board branch for v3.3 merge window.

Hmm, actually I suggest you respin patches 2 and 3 so they apply
on their own to current fixes branch. Then update 1 and 4 to
apply on top of those.

This way we can apply 2 and 3 during the -rc cycle, and then
queue 1 and 4 for the next merge window.

Regards,

Tony
