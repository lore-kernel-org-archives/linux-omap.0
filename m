From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 08/18] OMAP4: clock data: Rename clock flags from 443X
 to 44XX
Date: Sat, 9 Jul 2011 20:03:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107092000370.15984@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <1309552901-8944-9-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60039 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1GJCDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 22:03:21 -0400
In-Reply-To: <1309552901-8944-9-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Rename current 4430 definitions to 44XX in oder to make this file
> applicable for the next revision (OMAP4460).
> 
> Create new flags for 44XX. They will be extented when OMAP4460
> will be introduced.
> 
> Fix as well the clkdev indentation that were previously broken.
> 
> Replace a couple of spaces by tabs.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

I've dropped this patch because Tony has indicated he doesn't want to
merge rename patches like this.


- Paul
