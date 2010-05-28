From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM][PATCH] omap3: cpufreq: allow default opp table init
Date: Fri, 28 May 2010 11:38:00 -0700
Message-ID: <878w73dg8n.fsf@deeprootsystems.com>
References: <1274318093-29010-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65388 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0E1SqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 14:46:09 -0400
Received: by pvg11 with SMTP id 11so530587pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 11:46:08 -0700 (PDT)
In-Reply-To: <1274318093-29010-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Wed\, 19 May 2010 20\:14\:53 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Cliff Brake <cliff.brake@gmail.com>

Nishanth Menon <nm@ti.com> writes:

> For board files which choose to override the defaults, the existing
> mechanism will work, for boards that would like to work with defaults,
> allow init_common_hw to call init_opp_table to initialize if not
> already initialized. this will allow all omap boards which have opp
> tables predefined for a silicon to use the same.
>
> Originally reported for overo: 
> http://marc.info/?t=127265269400004&r=1&w=2
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reported-by: Peter Tseng <tsenpet09@gmail.com>
> Cc: Cliff Brake <cliff.brake@gmail.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

I like this better than having all the board files having to
explicitly call this.

Adding it to the pm-cpufreq branch, to be posted after the OPP
series (hopefully later today, or Monday.)

Kevin
