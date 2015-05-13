From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Date: Wed, 13 May 2015 16:48:46 +0200
Message-ID: <20150513144846.GC6605@localhost>
References: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com>
 <20150513141658.GB6605@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34556 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965295AbbEMOsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 10:48:47 -0400
Content-Disposition: inline
In-Reply-To: <20150513141658.GB6605@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, matthijsvanduin@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

On Wed, May 13, 2015 at 04:16:58PM +0200, Johan Hovold wrote:
> On Wed, May 13, 2015 at 08:50:01AM -0500, Robert Nelson wrote:
> > Fixes: http://bugs.elinux.org/issues/143
> > 
> > Commit 672e2b147 which introduced proper shutdown chose to let the PMIC go into sleep-state (aka "RTC-only mode") rather than off-state. This was fine for rev A5 on which that patch was tested, but since then two changes have been made to the power supply scheme:
> > 
> > (rev A6) enable of the 3v3b regulator moved from LDO2 to LDO4 (3v3a)
> > side-effect: 3v3b rail remains on in sleep-mode (also in off-mode when battery-powered)
> > 
> > (rev A6A) am335x vdds supply moved from LDO3 to LDO1
> > side-effect: vdds remains supplied in sleep-mode
> > 
> > As a result heavy leakage occurs from vdds (directly) and 3v3b (via i/o pins) to the 3v3a. The amount of current depends on external connections, but for example leaving a serial console cable connected in this state resulted in serious violation of am335x absolute maximum ratings, with potential for hardware damage.
> > 
> > Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> > Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Johan Hovold <johan@kernel.org>
> 
> This should go into stable as well:
> 
> Fixes: 672e2b147413 ("ARM: dts: am335x-boneblack: enable power off and
> rtc wake up")
> Cc: stable <stable@vger.kernel.org>	# 3.19
> Acked-by: Johan Hovold <johan@kernel.org>

By the way, perhaps you should add a comment in the tps node explaining
why ti,pmic-shutdown-controller must not be disabled (on what revisions
of hardware) as well?

Johan
