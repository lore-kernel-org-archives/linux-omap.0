From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 8/9] ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix exist now
Date: Wed, 27 Mar 2013 20:01:20 +0100
Message-ID: <87li98651b.fsf@dell.be.48ers.dk>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
	<1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
	<874nfw7kb6.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:39113 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab3C0TBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 15:01:25 -0400
Received: by mail-ee0-f45.google.com with SMTP id b57so4623657eek.32
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 12:01:23 -0700 (PDT)
In-Reply-To: <874nfw7kb6.fsf@linaro.org> (Kevin Hilman's message of "Wed, 27
	Mar 2013 11:46:05 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

>>>>> "Kevin" == Kevin Hilman <khilman@linaro.org> writes:

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

 >> With commit bfd6d021 {ARM: OMAP3+: Implement timer workaround for errata
 >> i103 and i767}, the sync and gptimer synchronization errata got fixed.
 >> 
 >> Hence the l4_wakeup static dependency with MPU can  can be removed

s/can  can/can/

-- 
Bye, Peter Korsgaard
