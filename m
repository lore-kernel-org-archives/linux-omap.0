From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for v4.0-rc cycle
Date: Sun, 29 Mar 2015 13:59:35 -0700
Message-ID: <20150329205935.GD13301@localhost>
References: <20150319204922.GV5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34757 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbC2U7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Mar 2015 16:59:38 -0400
Received: by pacwe9 with SMTP id we9so147443019pac.1
        for <linux-omap@vger.kernel.org>; Sun, 29 Mar 2015 13:59:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150319204922.GV5140@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Mar 19, 2015 at 01:49:23PM -0700, Tony Lindgren wrote:
> The following changes since commit 5b7610f235627878617648a99dd1442997f1c889:
> 
>   ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot (2015-03-06 10:37:34 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v4.0-rc4
> 
> for you to fetch changes up to 599c376c49323127c9bdbb0fa61a3d4743819bc2:
> 
>   ARM: dts: Fix gpio interrupts for dm816x (2015-03-18 13:41:34 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for the -rc cycle:
> 
> - Fix a device tree based booting vs legacy booting regression for
>   omap3 crypto hardware by adding the missing DMA channels.
> 
> - Fix /sys/bus/soc/devices/soc0/family for am33xx devices.
> 
> - Fix two timer issues that can cause hangs if the timer related
>   hwmod data is missing like it often initially is for new SoCs.
> 
> - Remove pcie hwmods entry from dts as that causes runtime PM to
>   fail for the PHYs.
> 
> - A paper bag type dts configuration fix for dm816x GPIO
>   interrupts that I just noticed. This is most of the changes
>   diffstat wise, but as it's a basic feature for connecting
>   devices and things work otherwise, it should be fixed.

Merged, thanks.


-Olof
