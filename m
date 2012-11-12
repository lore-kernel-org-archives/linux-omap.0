From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v3 1/6] watchdog: omap_wdt: convert to new
 watchdog core
Date: Mon, 12 Nov 2012 14:47:03 -0800
Message-ID: <20121112224703.GT6801@atomide.com>
References: <1352746025-1669-1-git-send-email-aaro.koskinen@iki.fi>
 <1352746025-1669-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352746025-1669-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [121112 10:49]:
> Convert omap_wdt to new watchdog core. On OMAP boards, there are usually
> multiple watchdogs. Since the new watchdog core supports multiple
> watchdogs, all watchdog drivers used on OMAP should be converted.
> 
> The legacy watchdog device node is still created, so this should not
> break existing users.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Tested-by: Jarkko Nikula <jarkko.nikula@jollamobile.com>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Wim, looks like these will cause merge conflicts with what we
have already queued in omap-for-v3.8/cleanup-prcm as patch
"watchdog: OMAP: use standard GETBOOTSTATUS interface; use
platform_data fn ptr" along with other ARM multiplatform
related clean up. If these look ackable to you, I can queue
these that's OK to you.

Regards,

Tony
