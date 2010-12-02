From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification for MCBSP
Date: Thu, 02 Dec 2010 11:54:23 +0100
Message-ID: <87mxoo4f8g.fsf@deeprootsystems.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<1286296662-7639-6-git-send-email-kishon@ti.com>
	<4CAECB70.4030705@ti.com> <4CB2AC44.6000804@ti.com>
	<AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com>
	<AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
	<4CF52044.6040904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFD66A@dbde02.ent.ti.com>
	<4CF62E5A.2080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53512 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab0LBKyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:54:47 -0500
Received: by qwb7 with SMTP id 7so8220773qwb.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 02:54:46 -0800 (PST)
In-Reply-To: <4CF62E5A.2080004@ti.com> (Benoit Cousson's message of "Wed, 1
	Dec 2010 12:15:38 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, "Govindraj.R" <govindraj.raja@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

>
> The issue is not really for the mcbsp but for the serial that need to
> handle the 3 different states.
>
> 	if (enable) {
> 		/**
> 		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
> 		 * in Smartidle Mode When Configured for DMA Operations.
> 		 */
> 		if (uart->dma_enabled)
> 			idlemode = HWMOD_IDLEMODE_FORCE;
> 		else
> 			idlemode = HWMOD_IDLEMODE_SMART;
> 	} else {
> 		idlemode = HWMOD_IDLEMODE_NO;
> 	}
>
> You do need to explicitly set the 3 modes, hence the following 3 APIs:
> omap_device_force_idle
> omap_device_no_idle
> omap_device_smart_idle
>
> You can potentially add another API to restore the default idle mode:
>
> omap_device_default_idle
>
> That seems much simpler than 3 pairs of APIs.

My $0.02... based on the fact that we already have some IPs needing to
conrol all 3 modes, I think having the 3 functions above is better than
having 3 pairs of request/release functions.

Kevin


