From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 REPOST 21/24] gpio/omap: save and restore debounce registers
Date: Fri, 04 Nov 2011 09:57:49 -0700
Message-ID: <87zkgbbzaq.fsf@ti.com>
References: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41003 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932807Ab1KDQ55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 12:57:57 -0400
Received: by qam2 with SMTP id 2so2491729qam.20
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 09:57:55 -0700 (PDT)
In-Reply-To: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 12 Oct 2011 18:02:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> GPIO debounce registers need to be saved and restored for proper functioning
> of driver. 

OK.

> To save the registers, we cannot cut the clock before the save,
> hence move the clk disable after the save.

This patch doesn't move any clk disable.

I suspect you made some changes to the original patch from Nishanth.
Please note that in the changelog.  This is typically done by adding
something like:

[my@email.addr: describe changes made]

just before your signoff.

Kevin
