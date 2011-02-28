From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu: Fix nested IRQ handling
Date: Mon, 28 Feb 2011 15:16:14 +0100
Message-ID: <1298902574.26482.8.camel@maggie>
References: <1298827021.30857.16.camel@marge>
	 <20110228083629.GI2459@legolas.emea.dhcp.ti.com>
	 (sfid-20110228_093639_404968_FFFFFFFFE1932FBC)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:48617 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab1B1OQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:16:20 -0500
In-Reply-To: <20110228083629.GI2459@legolas.emea.dhcp.ti.com> (sfid-20110228_093639_404968_FFFFFFFFE1932FBC)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 10:36 +0200, Felipe Balbi wrote: 
> On Sun, Feb 27, 2011 at 06:17:01PM +0100, Michael Buesch wrote:
> > handle_nested_irq() expects a global IRQ number, so
> > the irq_base has to be added to the RETU irq number.
> > 
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> Good catch, while at that, could you also cook another patch to add
> locking on retu_irq_handler ? We are using the internal lockless
> version of the read/write functions, so we need to hold the mutex before
> reading/writing to avoid problems.

Ok, it probably is safe without locking (due to the reads being atomic),
but I agree that it's more robust to add some locking here. I'll send
a patch.

-- 
Greetings Michael.

