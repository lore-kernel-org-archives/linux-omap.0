From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] Modified: Introduce seperate IRQs for the TWL4030
	power block
Date: Fri, 28 Mar 2008 10:16:45 +0200
Message-ID: <20080328081645.GH24896@atomide.com>
References: <20080214152106.GG12233@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55879 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYC1IQr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 04:16:47 -0400
Content-Disposition: inline
In-Reply-To: <20080214152106.GG12233@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080214 17:30]:
> Please ignore the previous version of this patch.
> 
> This patch introduces seperate IRQs for the various interrupt sources of
> the TWL4030 power block. This is similar in spirit to the IRQs of the
> TWL4030 GPIO block.

Peter, can you please refresh this series one more time so it applies on
top of Felipe's twl4030 clean up I've just pushed?

Thanks,

Tony
