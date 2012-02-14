From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/6] arm: omap: clk/clkdm/pwrdm/voltdm changes to usecounting
Date: Tue, 14 Feb 2012 12:02:06 -0800
Message-ID: <87ty2t5gld.fsf@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55273 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754400Ab2BNUCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 15:02:14 -0500
Received: by mail-pw0-f54.google.com with SMTP id xa7so976922pbc.27
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 12:02:07 -0800 (PST)
In-Reply-To: <1329237402-26008-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Tue, 14 Feb 2012 18:36:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This set is split out from a larger set earlier circulated on linux-omap
> list. The main purpose of this set is to provide useful recursive
> usecounting support for clockdomains / powerdomains / voltagedomains
> which can be used for debugging purposes and also to control certain
> chip power features once a sleep condition is reached (voltdm usecount=0).
>
> This set provides only the baseline support for the usecounting, and also
> adds a pm-debug related patch that can be used to check out stuff (patch 6),
> and should later prove rather useful for debugging. Rest of the
> functionality will be posted in separate sets.
>
> This set has been tested on omap3 beagle board with suspend / resume /
> cpuidle. Also boot tested on omap4 panda (sleep is not functional yet
> on that platform.)

This is a great series, and results in pm_debug debugfs data that's
actually useful for real debug.  Thanks!

I had a minor comment on the idle path changes, but all the other stuff
is

Acked-by: Kevin Hilman <khilman@ti.com>

Paul, this should probably merge via you (when it's ready) since the
important changes are clock and powerdomain core changes.

Kevin

