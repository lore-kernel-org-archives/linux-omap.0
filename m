From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: OPP: allow OPP enumeration to continue if device is not present
Date: Mon, 19 Mar 2012 14:48:31 -0700
Message-ID: <8739945kk0.fsf@ti.com>
References: <1331914749-23171-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41112 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631Ab2CSVsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 17:48:13 -0400
Received: by mail-pz0-f42.google.com with SMTP id g27so14344754dan.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 14:48:11 -0700 (PDT)
In-Reply-To: <1331914749-23171-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 16 Mar 2012 11:19:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, Maximilian Schwerin <mvs@tigris.de>

Nishanth Menon <nm@ti.com> writes:

> On platforms such as OMAP3, certain variants may not have IVA, SGX
> or some specific component. We currently have a check to aid fixing
> wrong population of OPP entries for issues such as typos. This however
> causes a conflict with valid requirement where the SoC variant does
> not actually have the module present.
>
> So, reduce the severity of the print to a debug statement and skip
> registering that specific OPP, but continue down the list.
>
> Reported-by: Steve Sakoman <steve@sakoman.com>
> Reported-by: Maximilian Schwerin <mvs@tigris.de>
> Acked-by: Steve Sakoman <steve@sakoman.com>
> Tested-by: Maximilian Schwerin <mvs@tigris.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing as a fix for for v3.4-rc (branch: for_3.4/fixes/pm)

Kevin
