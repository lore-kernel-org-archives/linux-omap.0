From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] [RESEND] ARM: OMAP3+: dpll: Configure autoidle mode
 only if it's supported
Date: Wed, 2 May 2012 01:33:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020133080.19695@utopia.booyaka.com>
References: <1335774722-6728-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51002 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab2EBHdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 03:33:20 -0400
In-Reply-To: <1335774722-6728-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pswan.com, b-cousson@ti.com

On Mon, 30 Apr 2012, Vaibhav Bedia wrote:

> The current DPLL code enables and disables autoidle features
> without checking whether the autoidle register is available.
> Fix this by putting a check for the existence of the autoidle
> register in the DPLL data.
> 
> With such a check in place, for DPLLs which do not support this
> feature, simply skipping the autoidle_reg entry in the DPLL data
> is sufficient.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
> This change is needed for AM33xx, which does not support
> autoidle mode for the DPLLs.

Thanks, queued for 3.5.


- Paul
