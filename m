From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP3+: fix oops triggered in omap_prcm_register_chain_handler(v1)
Date: Thu, 22 Mar 2012 16:12:21 -0700
Message-ID: <87mx7844dm.fsf@ti.com>
References: <1332379417-7408-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:48283 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757444Ab2CVXMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 19:12:23 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so2777752yhm.5
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 16:12:22 -0700 (PDT)
In-Reply-To: <1332379417-7408-1-git-send-email-tom.leiming@gmail.com> (Ming
	Lei's message of "Thu, 22 Mar 2012 09:23:37 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:

> This patch fixes the oops below[1].
>
> Obviously, the count of "struct irq_chip_generic" instances to be
> allocated and setup should be irq_setup->nr_regs instead of
> irq_setup->nr_regs plus one, so just fix the iterator to avoid
> the oops. 

[...]

> ---
> v1:
> 	-add a bit more description to the changelog as suggested by
> 	Tero and Kevin.

Thanks for the updated version.

Queuing as a fix for v3.4-rc (branch: for_3.4/fixes/pm)

Kevin
