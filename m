From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/4] RETU fetch IRQ via struct resource
Date: Mon, 14 Feb 2011 21:00:01 +0200
Message-ID: <20110214190001.GT2549@legolas.emea.dhcp.ti.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34543 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752174Ab1BNTAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 14:00:11 -0500
Received: by mail-ew0-f53.google.com with SMTP id 6so2336159ewy.12
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 11:00:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297333281-29853-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Thu, Feb 10, 2011 at 12:21:17PM +0200, Felipe Balbi wrote:
> here are 4 very quick patches to grab IRQ
> via struct resource. Now all these changes
> need to be ported to Tahvo. I'm not sure
> I'll have any time to look at that for a
> while, though.

I have put together a few more patches which are now available at [1],
here's the diffstat against tony/master:

 arch/arm/mach-omap1/board-nokia770.c   |    1 +
 arch/arm/mach-omap2/board-n8x0.c       |    1 +
 arch/arm/plat-omap/include/plat/cbus.h |    4 +
 drivers/cbus/retu-headset.c            |   46 +++++---
 drivers/cbus/retu-pwrbutton.c          |    6 +-
 drivers/cbus/retu-rtc.c                |   57 +++++-----
 drivers/cbus/retu-wdt.c                |   15 +--
 drivers/cbus/retu.c                    |  202 ++++++++++++++++++++-----------
 drivers/cbus/retu.h                    |   10 +-
 9 files changed, 206 insertions(+), 136 deletions(-)

and here's the new shortlog:

Felipe Balbi (19):
      cbus: retu: pass IRQ via struct resource
      cbus: retu: headset: grab IRQ via struct resource
      cbus: retu: pwrbutton: grab IRQ via struct resource
      cbus: retu: rtc: grab IRQ via struct resource
      cbus: retu: drop retu_get_status
      cbus: retu: replace BUG_ON with WARN
      cbus: retu: drop the unnecessary spinlock_t
      cbus: retu: drop unused PFX macro
      arm: omap: cbus: add IDs for Retu and Tahvo
      arm: omap: pass Retu ID via platform_data
      cbus: retu: use the devid from platform_data
      cbus: retu: introduce internal read/write functions
      cbus: retu: search and replace
      cbus: retu: pwrbutton: save device pointer on our structure
      cbus: retu: pass the child device pointer to all retu functions
      cbus: retu: headset: don't save pdev pointer
      cbus: retu: replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
      cbus: retu: tabify retu initialization
      cbus: retu: set pm_power_off to NULL when removing retu

Want me to re-send all patches or you can pull from my cbus branch to
test ?

Any taker for fixing tahvo ? All you have to do is port the changes done
in retu to tahvo. Tahvo is a lot simpler than retu though.

-- 
balbi
