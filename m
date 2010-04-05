From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP] [PATCH 1/1] OMAP3: PM: cpu-omap: Check governor limits before applying mpu frequency
Date: Mon, 05 Apr 2010 16:01:32 -0700
Message-ID: <874ojpsdv7.fsf@deeprootsystems.com>
References: <1269428551-779-1-git-send-email-eduardo.valentin@nokia.com>
	<4BAA085A.6060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46813 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0DEXBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 19:01:35 -0400
Received: by pva18 with SMTP id 18so2056259pva.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Apr 2010 16:01:34 -0700 (PDT)
In-Reply-To: <4BAA085A.6060100@ti.com> (Nishanth Menon's message of "Wed\, 24 Mar 2010 07\:40\:58 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Eduardo Valentin had written, on 03/24/2010 06:02 AM, the following:
>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>
>> This patch fix the sequence inside omap_target while setting
>> a frequency for OMAP3 devices.
>>
>> Previously any frequency was set, even if out of range. Now
>> the range set by the governor is also checked for OMAP3.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> Good catch. thanks.
>
> Acked-by: Nishanth Menon <nm@ti.com>

Thanks, applying to pm-wip-opp (which I'm still trying to find the time to
rebase for upstream)

Kevin
