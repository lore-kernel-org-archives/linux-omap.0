From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 0/8] omap3: pm: TWL4030 power scripts and workaround for TWL errata 27
Date: Mon, 07 Mar 2011 13:25:09 -0800
Message-ID: <87lj0q39oq.fsf@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59171 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756288Ab1CGVZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 16:25:13 -0500
Received: by mail-yi0-f41.google.com with SMTP id 2so2309324yib.14
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 13:25:12 -0800 (PST)
In-Reply-To: <1299072653-13414-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Wed, 2 Mar 2011 19:00:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Patch series for TWL4030 power scripts and workaround for TWL errata 27.
>
> Changes for implementing TWL4030 power scripts recommended by hardware team.
> Introduced a new TWL4030 power script file, which can be used by different
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, and modified the
> TWL4030 power script.
> Workaround for TWL4030 errata 27 & 28 is required for
> Si version less than or equal to TWL5030 ES1.1.
>
> TWL4030 script changes rebased on Kevin's PM tree in pm branch.

This doesn't apply to the current PM branch.  I dropped the old scripts
from the PM branch some time back.  It should be a simple rebase, and
only affects PATCH 6/8.  After the rebase, it will only add the new
stuff to the 3430SDP board file instead of also delete the old scripts.

Also, minor nit: please consistenly capitlize acronyms: API, OMAP, etc,
and the singular for errata is erattum.  This affects subjects,
changelogs comments etc.

> Changes in v7:
> 	changes to fix Nishanth Menon's comments
> 		i) Added the TWL4030 Errata 27 fix
>   
> 	split the first patch in v6
> 		i)  fix for twl4030 script load
> 		ii) correct the warning print during script loading
>
> 	Added new patch files
> 		i) changing sys_off signal polarity
>
> Changes in v8:
> 	updated the change logs
> 	moving the TWL IDCODE checking to twl-core.c
>
> Since the voltage layer is evolving to a new design, the voltage dependant
> changes required for the TRITON script are not incorporated in the patch series.
> So this TRITON script patch series can be tested with a separate patch for
> voltage layer changes.
>
> 	lnk: http://pastebin.mozilla.org/1118306

I'm OK with leaving the voltage layer changes for a separate series, but
in order to test this should also be rebased against my current PM branch.

For future reference, my pm-core branch includes only patches/series
that are already queued for upstream, or will be queued for the next
merge window.

Kevin
