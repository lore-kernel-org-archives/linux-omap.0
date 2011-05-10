From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/13] ARM: omap1: delete useless interrupt handler
Date: Tue, 10 May 2011 14:49:40 +0200
Message-ID: <87boza4t5n.fsf@ti.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45212 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070Ab1EJMtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 08:49:46 -0400
Received: by mail-fx0-f50.google.com with SMTP id 16so5492458fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 05:49:44 -0700 (PDT)
In-Reply-To: <E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Tue, 10 May 2011 08:28:17 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> The OMAP1 clocksource interrupt handler just increments a variable
> which otherwise isn't used, so this seems to be unnecessary.  Tony
> Lindgren confirms, so lets remove it.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Yes, this is left over legacy code from an earlier implementation.

Acked-by: Kevin Hilman <khilman@ti.com>
