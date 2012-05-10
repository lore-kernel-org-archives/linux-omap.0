From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/8] gpio/omap: remaining cleanups and fix
Date: Thu, 10 May 2012 15:13:36 -0700
Message-ID: <87y5ozu1kf.fsf@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
	<CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52204 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757052Ab2EJWNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 18:13:40 -0400
Received: by pbbrp8 with SMTP id rp8so2454086pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 15:13:38 -0700 (PDT)
In-Reply-To: <CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
	(Govindraj Raja's message of "Thu, 10 May 2012 12:08:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Govindraj,

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

[...]

> I tested this series from your tree on Beagle-XM retention, offmode,
> suspend to mem and resume with and and without enabling offmode
> from sysfs was checked and found retention count and off mode
> count was getting incremented.
>
> Also ran few test cases available from here[1] to request and release gpio,
> test cases passed.
>
> Feel Free to add:
>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

Awesome!

Many thanks for the testing.  It *greatly* helps when maintainers can
see more testing by folks other than the author.

Thank you!

Kevin
