From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/4] initialize omap SRAM later on with __arm_ioremap_exec()
Date: Wed, 05 Oct 2011 12:33:01 +0530
Message-ID: <4E8C0125.1060300@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:54410 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754243Ab1JEHDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 03:03:07 -0400
Received: by mail-yw0-f45.google.com with SMTP id 39so1500812ywm.32
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 00:03:06 -0700 (PDT)
In-Reply-To: <20111005004339.26980.31149.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony,

On Wednesday 05 October 2011 06:15 AM, Tony Lindgren wrote:
> Hi all,
> 
> Related to the omap static mapping, here's a first take on moving the
> SRAM init to happen later so we can do generic map_io.
> 
> Still working on a similar patch for omap1, will send it a bit later.
> 
> Regards,
> 
> Tony
> 
> ---
> 
> Tony Lindgren (4):
>       ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
>       ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
>       ARM: OMAP: Remove calls to SRAM allocations for framebuffer
>       ARM: OMAP: Map SRAM later on with ioremap_exec()
> 
>
Nice work.

With quick scan, looks like the series will work since
you have already taken care of SRAM is being ready before
SDRC has been initialised which was the only corner case
I was worried.

Will look at this series in next couple of days and do some testing.
Looks like you wanted to inlcude below patch also part of this
series though [PATCH 5/4] numbering is bit confusing.
[PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen in
init_early

Regards
Santosh


