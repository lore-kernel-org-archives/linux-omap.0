From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
Date: Fri, 21 Aug 2009 18:00:27 +0200
Message-ID: <878whdma1w.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BE14@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:59202 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbZHUQAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 12:00:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so475971qwh.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 09:00:33 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BE14@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Fri\, 21 Aug 2009 14\:40\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> Russell,
>
> On the mainline 2.6.31-rc6, OMAP4 boot is crashing. Also serial code in the linux-next branch isn't merge correctly and needs reworked patches. 
>
> Can you please see if they are ok? 

After the fix I suggested on patch 2/2, I'm OK with these.

Tony, should I pull these into my fixes queue, or do you want to merge
them directly.  We will need them in your for-next branch to resolve
the problems in linux-next.

Kevin

> This patch series addresses the OMAP4430 boot up crash issues on the latest 2.6.31-rc6 kernel release. They are generated against 2.6.31-rc6 
> (commit= 6c30c53fd5ae6a99a23ad78e90c428d2c8ffb07f)
> OMAP4 was broken after "[PATCH 00/14] OMAP PM fixes for .31-rc series" series got merged in.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14527.html
>  
> Two issues -
> 1. NULL pointer dereference in omap_serial_init()-
> static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS], has three instances populated and for OMAP4 macro OMAP_MAX_NR_PORTS=4. So at the fourth iteration, there is NULL pointer oops.
> This was also related to the merge issue in the linux-next branch. 
> http://lkml.org/lkml/2009/8/20/192
>
> 	[PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.
>
> 2. Console is not working because the uart platform data is not getting registered to kernel. Registration fails because of clock check failure in omap_serial_init(). As you aware the clock framework is still under review on mailing list. Hence below patch is necessary to fix the same.
>
> 	[PATCH 2/2] ARM: OMAP4: Bypass the clock check.
>
> Thanks !!
>
> Regards,
> Santosh
