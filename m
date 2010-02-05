From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP3 PM: Defining .pwrsts_logic_ret field for core
 power domain structure
Date: Fri, 5 Feb 2010 01:22:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002050122080.26033@utopia.booyaka.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com> <1265302071-7624-2-git-send-email-thara@ti.com> <1265302071-7624-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60685 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0BEIWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:22:34 -0500
In-Reply-To: <1265302071-7624-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 4 Feb 2010, Thara Gopinath wrote:

> This patch adds the flag .pwrsts_logic_ret info for the core power domain
> in the associated powerdomain structure. This flag specifies the states
> core domain logic can hit in event of the domain entering retention.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Also queued for 2.6.34.


- Paul
