From: Anand Gadiyar <gadiyar@ti.com>
Subject: Dropping omap3430 ES1.0 support in mainline
Date: Sat, 2 Oct 2010 03:16:46 +0530
Message-ID: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55825 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754430Ab0JAVqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:46:47 -0400
Received: by mail-wy0-f177.google.com with SMTP id 38so4212247wyb.22
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:46:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Tony, all,

The OMAP3430 ES1.0 was pretty much a test chip, with the only known board
being the 3430ES1.0 SDP. There are only a small number of these boards
outside TI and within TI, they've likely never been used in over 2 years.
It's unlikely that these boards still work on mainline, and likely have
been broken in linux-omap since the very beginning.

Between ES1.0 and ES2.0 we've had several major changes in the clock
nodes,
and IPs. However we're still keeping code/data on these in the kernel
today.

Since all later OMAP3 chips have been very similar to ES2.0, it probably
makes sense to drop support for the ES1.0. This would result in a small
but probably significant reduction in the current code. If you're okay
with dropping this support, we can slowly start working on this.

What do you think?

- Anand
