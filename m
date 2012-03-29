From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] omap randconfig fixes for v3.3
Date: Thu, 29 Mar 2012 10:28:02 -0700
Message-ID: <20120329172802.GX9859@atomide.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25767 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175Ab2C2R2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 13:28:06 -0400
Content-Disposition: inline
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de

Mathieu,

* mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: "Arnd Bergmann" <arnd@arndb.de>
> 
> The following is a set of patches that have been sent
> out during the 3.1 cycle that were not acked or merged.
> 
> Sending again for completeness.  
> 
> Tony, please pull if there are no objections:
> 
> The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

Can you please drop the already fixed ones and post
a new pull request?

It seems that these should merge fine to current mainline
if based on v3.3. If not, then maybe use the linux-omap fixes
branch as the base that I've just pushed at commit 2533c2cf.

Thanks,

Tony
