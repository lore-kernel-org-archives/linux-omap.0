From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clock: Support divider selection for auxclks
Date: Thu, 24 Feb 2011 11:06:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102241105540.6198@utopia.booyaka.com>
References: <1298557696-1726-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33454 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab1BXSGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 13:06:38 -0500
In-Reply-To: <1298557696-1726-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, gadiyar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Thu, 24 Feb 2011, Rajendra Nayak wrote:

> On OMAP4 the auxclk nodes (part of SCRM) support both
> divider as well as parent selection.
> Supporting this requires splitting the existing nodes
> (which support only parent selection) into
> two nodes, one for parent and another for
> divider selection.
> The nodes for parent selection are named
> auxclk*_src_ck and the ones for divider
> selection as auxclk*_ck
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Tested-by: Anand Gadiyar <gadiyar@ti.com>

Thanks.  Has the autogeneration script been updated?


- Paul
