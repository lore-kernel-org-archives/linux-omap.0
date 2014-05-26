From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] omap pm changes for v3.16 merge window, resend
Date: Mon, 26 May 2014 13:25:26 -0700
Message-ID: <20140526202526.GJ27093@quad.lixom.net>
References: <20140520021151.GL15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33981 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaEZUZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2014 16:25:15 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so8087976pbb.36
        for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 13:25:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140520021151.GL15793@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, May 19, 2014 at 07:11:52PM -0700, Tony Lindgren wrote:
> The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:
> 
>   Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/pm-signed
> 
> for you to fetch changes up to 57b05572267581c2320462e9b606709fa6da4c5a:
> 
>   ARM: OMAP2+: Enable CPUidle in omap2plus_defconfig (2014-05-06 15:45:15 -0700)
> 
> ----------------------------------------------------------------
> PM related fixes for omap3 that were discovered during omap3
> conversion to device tree. This series sets up the PMIC signaling
> in a way where we can test for PM regressions easily by
> looking at state of the the sys_clkreq and sys_off_mode pins.
> 
> Note that this series alone does not make omap3 PM to cut
> off core voltage during off-idle, changes to twl4030-power.c
> configurations are still needed. Those will be posted
> separately.

Merged into next/soc.


Thanks,

-Olof
