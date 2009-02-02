From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/2] OMAP 2/3 GPIO fixes for idling debounce clocks
Date: Mon, 02 Feb 2009 12:15:27 -0800
Message-ID: <87ocxkbnog.fsf@deeprootsystems.com>
References: <1233194282-30057-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:65024 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbZBBUPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 15:15:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1636918rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2009 12:15:30 -0800 (PST)
In-Reply-To: <1233194282-30057-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 28 Jan 2009 17\:58\:00 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> [updated since v1: also works for retention/off when idle by 
>  masking off GPIO clocks in the 'fclks_active' check.]
>
> This series against the current PM branch is to add support for
> auto-disabling GPIO debounce clocks when the system is idle.  Without
> this, any platform using the GPIO debounce feature will not go into
> retention since the GPIO debounce clocks are still active.
>
> This is needed particularily on OMAP3EVM which sets up the debounce
> clocks for the touchscreen GPIO.
>
> Kevin Hilman (2):
>   OMAP2/3: GPIO: generalize prepare for idle
>   OMAP3: GPIO: disable GPIO debounce clocks on idle
>
>  arch/arm/mach-omap2/pm24xx.c           |    4 ++--
>  arch/arm/mach-omap2/pm34xx.c           |   14 ++++++++------
>  arch/arm/plat-omap/gpio.c              |   27 +++++++++++++++++++++------
>  arch/arm/plat-omap/include/mach/gpio.h |    4 ++--
>  4 files changed, 33 insertions(+), 16 deletions(-)

Pushing this series to PM branch.

Kevin
