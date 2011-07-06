From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clockdomain: Remove redundant call to
 pwrdm_wait_transition()
Date: Tue, 5 Jul 2011 23:35:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052334560.4217@utopia.booyaka.com>
References: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49721 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1GFFf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:35:58 -0400
In-Reply-To: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Thu, 26 May 2011, Vaibhav Bedia wrote:

> The call to pwrdm_wait_transition() in clkdm_clk_enable()
> is redundant since the function pwrdm_clkdm_state_switch()
> which is called next also does the same thing.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'clockdomain_a_3.1' branch.


- Paul
