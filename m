From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] OMAP3+: OPP: Replace voltage values with Macros
Date: Mon, 07 Mar 2011 14:15:41 -0800
Message-ID: <874o7e1ss2.fsf@ti.com>
References: <1299320842-2503-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42409 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754608Ab1CGWPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 17:15:46 -0500
Received: by mail-gw0-f49.google.com with SMTP id 15so1868351gwj.22
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 14:15:44 -0800 (PST)
In-Reply-To: <1299320842-2503-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 15:57:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Vishwanath BS <vishwanath.bs@ti.com>

Nishanth Menon <nm@ti.com> writes:

> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> Since all voltage data is now centralized in oppxxx_data.c, we can replace
> the values in the opp table with the macros used for voltage values.
>
> This will avoid opp table and voltage layer having conflicting values.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

As you are now on the delivery path too, this should have your sign-off.

Assuming this is a simple oversight, I added your signoff and queued for
2.6.39 (branch: for_2.6.39/pm-misc)

Thanks,

Kevin
