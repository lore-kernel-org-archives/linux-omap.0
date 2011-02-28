From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu: Fix nested IRQ handling
Date: Mon, 28 Feb 2011 10:36:29 +0200
Message-ID: <20110228083629.GI2459@legolas.emea.dhcp.ti.com>
References: <1298827021.30857.16.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33259 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463Ab1B1Ige (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:36:34 -0500
Received: by bwz12 with SMTP id 12so4089394bwz.41
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:36:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298827021.30857.16.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Sun, Feb 27, 2011 at 06:17:01PM +0100, Michael Buesch wrote:
> handle_nested_irq() expects a global IRQ number, so
> the irq_base has to be added to the RETU irq number.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Good catch, while at that, could you also cook another patch to add
locking on retu_irq_handler ? We are using the internal lockless
version of the read/write functions, so we need to hold the mutex before
reading/writing to avoid problems.

-- 
balbi
