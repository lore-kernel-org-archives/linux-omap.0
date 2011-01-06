From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 3/4] OMAP4: hwmod: add entries for DMIC driver
Date: Thu, 06 Jan 2011 14:39:44 -0800
Message-ID: <87k4ihsllb.fsf@ti.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
	<1294322439-16305-4-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55671 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754470Ab1AFWju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 17:39:50 -0500
Received: by pxi17 with SMTP id 17so3590723pxi.20
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 14:39:48 -0800 (PST)
In-Reply-To: <1294322439-16305-4-git-send-email-dlambert@ti.com> (David
	Lambert's message of "Thu, 6 Jan 2011 08:00:38 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

David Lambert <dlambert@ti.com> writes:

> Adds HWMOD entries for the OMAP DMIC driver and creates
> a platform device.  The HWMOD entires define the system
> resource requirements for the drvier such as DMA addresses, channels,
> and IRQ's.  Placing this information in the HWMOD database allows
> for more generic drivers to be written and having the specific
> implementation details defined in HWMOD.
>
> Signed-off-by: David Lambert <dlambert@ti.com>
>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++++++++++
>  arch/arm/plat-omap/devices.c               |   35 +++++++++++
>  2 files changed, 126 insertions(+), 0 deletions(-)

Please split this into two patches: one for just the hwmod data, and the
other for initializing the device.

Also, I'm assuming the hwmod data came from the auto-generated data from
Benoit, correct?  If so authorship and signoff of the hwmod data patch
should reflect that.

Thanks,

Kevin
