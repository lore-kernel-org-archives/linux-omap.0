From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.14-rc4
Date: Fri, 28 Feb 2014 16:03:58 +0100
Message-ID: <201402281603.58489.arnd@arndb.de>
References: <20140228000715.GA14514@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:53817 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaB1PEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 10:04:07 -0500
In-Reply-To: <20140228000715.GA14514@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 28 February 2014, Tony Lindgren wrote:
> The following changes since commit 8842446ac74263f1330f46e11ed649e2b0ed6545:
> 
>   Documentation: dt: OMAP: Update Overo/Tobi (2014-02-14 08:37:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-rc4
> 
> for you to fetch changes up to 4b41636878ee32d4c45a49de7749abca9721bd6a:
> 
>   ARM: OMAP3: Fix pinctrl interrupts for core2 (2014-02-27 15:35:48 -0800)
> 
> ----------------------------------------------------------------
> Fixes for omaps mostly to fix the 3430 display regression,
> and random crashes if booting n900 with device tree and
> thumb mode. Also few other regressions and fixes.

Pulled into fixes, thanks!

	Arnd
