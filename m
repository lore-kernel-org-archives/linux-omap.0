From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Tue, 22 Mar 2011 13:13:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103221312550.11798@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45419 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1CVTNL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 15:13:11 -0400
In-Reply-To: <1300493932-17362-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Fri, 18 Mar 2011, Kevin Hilman wrote:

> The voltage domain pointer currently in struct omap_hwmod is not used
> and does not belong here.  Instead, voltage domains will be associated
> with powerdomains in forthcoming patches.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
