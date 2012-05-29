From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: dmtimer: set non-posted mode if iclk less than 4*fck
Date: Tue, 29 May 2012 14:21:29 -0700
Message-ID: <87pq9mel9i.fsf@ti.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
	<1336744398-23803-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:44673 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754769Ab2E2VVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 17:21:32 -0400
Received: by pbcwz7 with SMTP id wz7so7245404pbc.30
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 14:21:30 -0700 (PDT)
In-Reply-To: <1336744398-23803-3-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 11 May 2012 19:23:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, b-cousson@ti.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Timers in PER domain periodically report old time from TCRR in
> posted mode if ick < 4*fck. Therefore, set timer to non-posted
> whenever ick < 4*fck for all timers.

Is there an erratum assocaited with this?

Does this problem affect every SoC?

Kevin
