From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Sat, 03 Nov 2012 12:43:54 +0100
Message-ID: <5095037A.2020503@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46856 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab2KCLut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 07:50:49 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1967167wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 04:50:48 -0700 (PDT)
In-Reply-To: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> AM33XX has only one usable timer in the WKUP domain.
> Currently the timer instance in WKUP domain is used
> as the clockevent and the timer in non-WKUP domain
> as the clocksource. The timer in WKUP domain can keep
> running in suspend from a 32K clock and hence serve
> as the persistent clock. To enable this, interchange
> the timers used as clocksource and clockevent for
> AM33XX.

Doesn't this also mean that you won't get timer wakeups
in idle?  Or are you keeping the domain where the clockevent is
on during idle?

Kevin
