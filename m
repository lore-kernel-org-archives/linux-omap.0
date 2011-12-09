From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 05/14] OMAP2+: mux: add support for PAD wakeup interrupts
Date: Fri, 09 Dec 2011 15:13:19 -0800
Message-ID: <87sjktjq40.fsf@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	<1323440857-385-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51949 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301Ab1LIXNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 18:13:21 -0500
Received: by mail-iy0-f172.google.com with SMTP id k3so4956002iae.3
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 15:13:20 -0800 (PST)
In-Reply-To: <1323440857-385-6-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 9 Dec 2011 16:27:28 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> OMAP mux now provides a service routine to parse pending wakeup events
> and to call registered ISR whenever active wakeups are detected. 

Good.

> This routine is called directly from PRCM interrupt handler.

I think this comment is out of date with the code, since you're now
using a shared IRQ and the interrupt is directly called from the IRQ
core.

I'd update the changelog here just commenting on what this IRQ is shared
with, and how the interrupts are shared.

Also, a question on optimization.  For every IO wakeup, this will go
through the list of *all* enabled hwmods.  This could be pretty expensive
with lots of wakeups.  Maybe we should have another flag for hwmods that
have wakeups enabled so walking the list of potential wakeup-capable
hwmods will be as fast as possible.

Kevin

