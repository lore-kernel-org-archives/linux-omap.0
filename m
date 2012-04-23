From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] staging: tidspbridge: fix build errors for
	OMAP2_L4_IO_ADDRESS
Date: Mon, 23 Apr 2012 15:39:17 +0100
Message-ID: <20120423143917.GD24299@n2100.arm.linux.org.uk>
References: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530Ab2DWOj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 10:39:26 -0400
Content-Disposition: inline
In-Reply-To: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

On Mon, Apr 23, 2012 at 05:34:14PM +0300, Felipe Contreras wrote:
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
> drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> 
> The proper fix will come later.

Hmm.  Given that this is staging stuff, which hasn't been making much
progress out of staging, I'd suggest not doing the quick fix on it, but
spending the time to implement the proper fix now and move the code
closer to the point where it can move out of staging.  You might get
a gold star from Greg for moving this forward...
