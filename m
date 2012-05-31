From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one
Date: Thu, 31 May 2012 16:15:38 -0700
Message-ID: <87d35kx7qd.fsf@ti.com>
References: <1337361979-19052-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44812 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758594Ab2EaXPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 19:15:42 -0400
Received: by dalh21 with SMTP id h21so1933221dal.34
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 16:15:38 -0700 (PDT)
In-Reply-To: <1337361979-19052-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 18 May 2012 12:26:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
> (ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present)
> makes the logic:
> for (i = 0; i < opp_def_size; i++) {
> 	<snip>
> 	if (!oh || !oh->od) {
> 		<snip>
> 		continue;
> 	}
> <snip>
> opp_def++;
> }
>
> In short, the moment we hit a "Bad OPP", we end up looping the list
> comparing against the bad opp definition pointer for the rest of the
> iteration count. Instead, increment opp_def in the for loop itself
> and allow continue to be used in code without much thought so that
> we check the next set of OPP definition pointers :)
>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Steve Sakoman <steve@sakoman.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Good catch.

Queuing for my next set of PM fixes for v3.5-rc (branch: for_3.5/fixes/pm-2)

Thanks for the fix!

Kevin
