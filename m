From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/3] omap device tree changes for v3.19
Date: Thu, 20 Nov 2014 11:47:03 +0100
Message-ID: <201411201147.04064.arnd@arndb.de>
References: <pull-1415814409-868361>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55647 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbaKTKrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 05:47:12 -0500
In-Reply-To: <pull-1415814409-868361>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 12 November 2014, Tony Lindgren wrote:
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/dt-part1
> 
> for you to fetch changes up to 065bd7fe50de5e6d0fd5034cbc87120a558a1219:
> 
>   ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)
> 
> ----------------------------------------------------------------
> Device tree related changes for omaps:
> 
> - Fix currently harmless but wrong sizes for various GPMC connected
>   devices
> 
> - Set up timings for several GPMC connected devices to get rid of
>   bootloader dependencies in later patches
> 
> - Enable various drivers for dra7xx
> 
> - Prepare Igep boards to support new variants
> 
> - Add intial support for BeagleBoard-X15

pulled into next/dt, thanks!

	Arnd
