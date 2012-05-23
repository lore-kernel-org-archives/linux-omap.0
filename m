From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup
Date: Wed, 23 May 2012 16:11:46 -0700
Message-ID: <87likize4t.fsf@ti.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
	<1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40836 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab2EWXLu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 May 2012 19:11:50 -0400
Received: by pbbrp12 with SMTP id rp12so18062306pbb.1
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 16:11:49 -0700 (PDT)
In-Reply-To: <1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 11 May 2012 15:10:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Russ Dill <russ.dill@gmail.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> The commit (bce492c0  ARM: OMAP2+: UART: Fix incorrect population of
> default uart pads) removed default uart pads that where getting populated
> and which was making rx pin wakeup capable. If uart pads were used in
> different mode by any other module then it would fail since the default
> pads took over all the uart pins forcefully. With removal of default pads
> the rx_pad wakeup for console uart while waking up from off mode is broken.
>
> Utilise the mux api available to probe the availability of mux pins
> in uart mode and probe for availability of uart pin in mux mode0
> if uart is available as uart pin itself then configure rx pin
> as wakeup capable.
>
> This patch itself doesn't cater to all boards. Boards using uart rx wakeup
> mechanism should ensure the usage of omap_serial_init_port by configuring
> required uart ports and pass necessary mux data, till then this probing of
> uart pins can cater to enabling of rx pad wakeup to most of the boards.
>
> This patch can also throw some boot warning from _omap_mux_get_by_name
> if pin is requested for availability is not present while dynamically probing
> the uart pins availability such boot warnings can be addressed only when board
> files are patched with omap_serial_init_port calls passing the right pads
> needed for a given port.
>
> Discussion Threads for reference:
> http://www.spinics.net/lists/linux-omap/msg69859.html
> http://www.spinics.net/lists/linux-omap/msg68659.html
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Russ Dill <russ.dill@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Ameya Palande <ameya.palande@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Tony, it's up to you if you're OK with this mux interface, but I can at
least confirm that this gets runtime PM + UART wakeups working again on
the boards I tried: 3530/Overo, 3430/n900, 3530/OMAP3EVM.

Kevin
