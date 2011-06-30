From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP4: powerdomain data: Fix core mem states and
 missing cefuse flag
Date: Thu, 30 Jun 2011 17:48:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106301730340.2874@utopia.booyaka.com>
References: <1308847544-2322-1-git-send-email-b-cousson@ti.com> <1308847544-2322-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44479 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1F3Xsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 19:48:30 -0400
In-Reply-To: <1308847544-2322-4-git-send-email-b-cousson@ti.com>
Content-ID: <alpine.DEB.2.00.1106301743511.2874@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, 23 Jun 2011, Benoit Cousson wrote:

> Since ES2.0, the core ocmram does not support a different state
> than the main power domain anymore during both ON and RET power
> domain state.
> Since PM is not supported at all in ES1.0, update the common
> structure.
> 
> LOWPOWERSTATECHANGE is supported by the cefuse power domain but
> the flag was missing.
> Add the PWRDM_HAS_LOWPOWERSTATECHANGE in flags field.
> 
> Indent all previous flags to be aligned with other fields.
> 
> Update the TI copyright date to 2011.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

I guess the CEFUSE LOWPOWERSTATECHANGE bit is in the Security TRM?


- Paul
