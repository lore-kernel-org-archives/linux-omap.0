From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce dummy panel driver
Date: Tue, 02 Nov 2010 22:23:51 +0530
Message-ID: <4CD0421F.5070200@ti.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49920 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab0KBQyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 12:54:12 -0400
Received: by mail-vw0-f44.google.com with SMTP id 3so5737387vws.17
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 09:53:58 -0700 (PDT)
In-Reply-To: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/2/2010 9:43 PM, Bryan Wu wrote:
> There are 4 duplicated panel driver sin DSS2 display driver. They are similar
> and dummy panel driver can support all them with specific panel configuration.
> And new panel driver can be easily supported by adding panel configurations
> into dummy panel driver.
>
> This patchset introduces dummy panel driver, remove 3 panel drivers and enable
> dummy panel driver in board files. And it is based on 2.6.37-rc1.
>
> Building with omap2plus_defconfig is successful.
>
> Keep sharp_ls_panel, since it contains blacklight control code which will be
> moved out later.
>
> Bryan Wu (3):
>    OMAP: DSS2: Add dummy panel display driver
>    OMAP: DSS2: remove dummy panel driver duplicated panel drivers
>    OMAP: use dummy panel driver in board files
>
>   arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
>   arch/arm/mach-omap2/board-am3517evm.c              |    6 +-
>   arch/arm/mach-omap2/board-cm-t35.c                 |    6 +-
>   arch/arm/mach-omap2/board-devkit8000.c             |    6 +-
>   arch/arm/mach-omap2/board-igep0020.c               |    3 +-
>   arch/arm/mach-omap2/board-omap3beagle.c            |    3 +-
>   arch/arm/mach-omap2/board-omap3evm.c               |    3 +-
>   arch/arm/mach-omap2/board-omap3stalker.c           |    6 +-
>   arch/arm/plat-omap/include/plat/display.h          |   28 +-
>   drivers/video/omap2/displays/Kconfig               |   22 +-
>   drivers/video/omap2/displays/Makefile              |    4 +-
>   drivers/video/omap2/displays/panel-dummy.c         |  195 +++++++
>   drivers/video/omap2/displays/panel-dummy.h         |  119 +++++
>   drivers/video/omap2/displays/panel-generic.c       |  174 -------
>   .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 ------
>   .../video/omap2/displays/panel-tpo-td043mtea1.c    |  535 --------------------
>   16 files changed, 364 insertions(+), 914 deletions(-)
>   create mode 100644 drivers/video/omap2/displays/panel-dummy.c
>   create mode 100644 drivers/video/omap2/displays/panel-dummy.h
>   delete mode 100644 drivers/video/omap2/displays/panel-generic.c
>   delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
>   delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mtea1.c
>

Why can't panel-generic.c be reused instead of a new panel-dummy.c?

Sounds like what you're trying to do is to get a generic panel driver; 
so shouldn't it at least be called generic instead of dummy.

- Anand
