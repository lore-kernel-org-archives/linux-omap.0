From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
 !CONFIG_RUNTIME_PM
Date: Thu, 10 Mar 2011 01:54:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100148530.15132@utopia.booyaka.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101061120480.31961@utopia.booyaka.com> <007049e3361a3c4d0e7d2cfa105e2e67@mail.gmail.com> <f0b57f3b0e11566d8c1864d3388ce5e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53157 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1CJIyL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:54:11 -0500
In-Reply-To: <f0b57f3b0e11566d8c1864d3388ce5e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, paul@pwsan.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 24 Feb 2011, Sricharan R wrote:

> In the case of !CONFIG_PM_RUNTIME and !CONFIG_OMAP_WATCHDOG, if
> the boot loader or hwmod enables the watchdog, then it generates
> an un wanted reset.
> 
> So to avoid this in the case of !CONFIG_OMAP_WATCHDOG then the
> watchdog should always be disabled.
> 
> So there are two cases:
>    Case 1: (!CONFIG_OMAP_WATCHDOG and !CONFIG_PM_RUNTIME)
>              Watchdog should be disabled.
> 
>    Case 2: (!CONFIG_PM_RUNTIME) and ( driver is present and board file
> enables it)
> 		 Watchdog should run.
> 
>    Solution1:
>           Introduce a new hwmod watchdog reset function, by populating
>           the .reset entry of the hwmod.
>           This function is called during the hwmod init.
>           This function resets the watchdog always and also
>           disables it if !CONFIG_OMAP_WATCHDOG.
> 
>         ( or )
> 
>   Solution2:
>           Introduce a state variable to differentiate if
>           hwmod post_setup_state is set to enabled by
>           by board file or io.c file.
> 
>           Use this state variable in the reset function as
> 
>           If it is enabled by io.c then disable watchdog
>           Otherwise if it is set to enabled by board file
>           then enable watchdog.
> 
> The below is the patch for solution1, that I have mentioned.
> Please suggest which would be the right approach ?

I don't think either of these seem right.  At this point, I think the best 
way is to add a function pointer that can be used to quiesce IP blocks 
that become active after being reset, and to add a flag that board files 
can set to skip that quiescing process.  We're so close to the merge 
window opening, though, that I think the best time to deal with this will 
be after 2.6.40 is released.


- Paul
