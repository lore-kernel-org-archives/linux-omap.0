From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [RFC/PATCH 0/3] arm: omap: patches from -rt
Date: Thu, 1 Aug 2013 22:37:51 +0530
Message-ID: <51FA95E7.6040602@ti.com>
References: <1375359165-8411-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab3HARIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 13:08:19 -0400
In-Reply-To: <1375359165-8411-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thursday 01 August 2013 05:42 PM, Felipe Balbi wrote:
> Hi,
>
> the next three patches were taken from v3.10.4-rt1 patchset.
>
> I don't have any boards available to test them, so I'd suggest
> testing in as many platforms as possible before pushing
> upstream.
>
> By pushing these patches upstream, we help decrease the amount
> of out-of-tree changes rt folks need to carry.
>
> Frank Rowand (1):
>    arm: omap: convert omap boot_lock to raw
>
> Sebastian Andrzej Siewior (1):
>    i2c/omap: drop the lock hard irq context
>
> Thomas Gleixner (1):
>    serial: omap: fix omap lock crap
>
>   arch/arm/mach-omap2/omap-smp.c   | 10 +++++-----
>   drivers/i2c/busses/i2c-omap.c    |  5 +----
>   drivers/tty/serial/omap-serial.c | 12 ++++--------
>   3 files changed, 10 insertions(+), 17 deletions(-)
>
Tested this series on

omap4-sdp:
  - Boot tested .
  - run i2c dump on buses where devices were present.
  - check wakeup from suspend.

omap5-uevm:
- Boot tested.
- Tested this series on buses where devices are present.

dra7-evm:
  - Boot tested.
  - run i2c dump on buses where devices are present.

Tested-by: Sourav Poddar <sourav.poddar@ti.com>
