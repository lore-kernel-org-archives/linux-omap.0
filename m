From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework
 (part 2)
Date: Tue, 28 Jun 2011 09:56:22 +0300
Message-ID: <1309244182.1825.28.camel@deskari>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57573 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756173Ab1F1G42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 02:56:28 -0400
Received: by bwb17 with SMTP id 17so2200225bwb.31
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 23:56:26 -0700 (PDT)
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
> Hi Paul,
> 
> Here is the second part of the modulemode series. 
> The goal here is to do the cleanup on the clock nodes and PRCM macros
> that are not needed anymore by the hwmod data.
> Some macros are still needed because of clock data. It should be removed
> once the clock data will be cleaned.
> 
> Moreover, in order to get rid of static clkdev, omap_device is trying to
> create dynamically an "fck" alias if a main_clk is defined in hwmod data.
> 
> As usual, because of drivers non-adapted to pm_runtime, some temp hacks
> are needed for both MMC and timer1.
> If the drivers are fixes before these series, these temp patches could be
> dropped.
> 
> The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
> are definitively needed.
> 
> The patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.0.1/6_hwmod_modulemode

I tested the branch on Blaze, but DSS doesn't work as the clock aliases
have changed, leading to crash. And as only OMAP4 clocks/hwmods were
changed, this makes me believe OMAP2/3 DSS would still work.

I think the OMAP2/3/4 changes need to be done in sync, and at the same
time keeping the peripherals working.

 Tomi


