From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keypad: move platform_data to <linux/platform_data>
Date: Fri, 16 Mar 2012 09:36:19 -0700
Message-ID: <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
References: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com> <1331907989-11891-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57317 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031294Ab2CPQg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 12:36:27 -0400
In-Reply-To: <1331907989-11891-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

On Friday, March 16, 2012 07:56:28 PM Sourav Poddar wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> This patch allows us to drop the OMAP depencendy
> from the OMAP4 keypad driver.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c            |    1 +
>  arch/arm/mach-omap2/devices.c                  |    1 +
>  arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 ---------
>  drivers/input/keyboard/Kconfig                 |    1 -
>  drivers/input/keyboard/omap4-keypad.c          |    2 +-
>  include/linux/platform_data/omap4-keypad.h     |   13 +++++++++++++

Instead of creating platform_data directory why not move to
include/linux/input/omap4-keypad.h?

Thanks.

-- 
Dmitry
