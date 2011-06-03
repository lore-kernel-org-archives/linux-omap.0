From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v10 0/7] MFD: TWL4030: power script and workaround for erratum 27
Date: Thu, 02 Jun 2011 17:31:28 -0700
Message-ID: <87lixjlpr3.fsf@ti.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50635 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753881Ab1FCAbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 20:31:31 -0400
Received: by pwj9 with SMTP id 9so804044pwj.6
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 17:31:30 -0700 (PDT)
In-Reply-To: <1304687833-4578-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Fri, 6 May 2011 18:47:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Patch series for TWL4030 power scripts for OMAP3 boards and
> workaround for TWL erratum 27.
>
> Changes for implementing TWL4030 power scripts recommended by hardware team.
> Introduced a new TWL4030 power script file, which can be used by different
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, and modified
> the TWL4030 power script.
> Workaround for TWL4030 erratum 27 is required for Si version less than or
> equal to TWL5030 ES1.1.
>
> TWL4030 script changes re-based on Kevin's PM tree in pm branch.

Please update and rebase against mainline.   There should be no
dependencies on my tree.  I see Samuel has merged many of these already,
so the remaining ones need a refresh and retest.

Kevin
