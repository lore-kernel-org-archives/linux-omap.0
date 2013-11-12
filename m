From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: move gpmc headers to include/linux/platform_data
Date: Tue, 12 Nov 2013 22:56:55 +0100
Message-ID: <5282A427.9070300@collabora.co.uk>
References: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk> <1384014842-4288-2-git-send-email-javier.martinez@collabora.co.uk> <20131112205147.GB20260@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:57820 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467Ab3KLV5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Nov 2013 16:57:49 -0500
In-Reply-To: <20131112205147.GB20260@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/12/2013 09:51 PM, Ezequiel Garcia wrote:
> Hey Javier,
>

Hi Ezequiel, thanks a lot for your feedback.

> On Sat, Nov 09, 2013 at 05:34:02PM +0100, Javier Martinez Canillas wrote:
>> The OMAP2+ General-Purpose Memory Controller (GPMC) driver
>> should eventually be moved from arch/arm/mach-omap2 to
>> drivers/memory. Unfortunately this is not trivial since it
>> includes headers files that still resides under mach-omap2
>> and can't be moved easilly.
>> 
>> This patch is the first step for taking the gpmc driver
>> outside arch/arm/mach-omap2 by moving its related headers
>> files to include/linux/platform_data.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Hi Tony,
>> 
>> I wonder what's your plan to move drivers outside of mach-omap2.
>> Currently this driver still includes soc.h and omap_device.h
>> that are on mach-omap2.
>> 
>> If we want to move out these two headers files then also omap
>> hwmod and per SoC family headers have to be moved out mach-omap2.
>> 
>> Do you want me to do a follow-up patch-set to move all these
>> headers out of mach-omap2 so the gpmc and other drivers can
>> be moved to drivers/? 
>> 
>> Is include/linux/platform_data the right place to put these
>> headers or there is a better place for them?
>> 
>> Thanks a lot and best regards,
>> Javier
>> 
>>  arch/arm/mach-omap2/board-2430sdp.c              |   5 +-
>>  arch/arm/mach-omap2/board-3430sdp.c              |   4 +-
>>  arch/arm/mach-omap2/board-cm-t35.c               |   6 +-
>>  arch/arm/mach-omap2/board-cm-t3517.c             |   4 +-
>>  arch/arm/mach-omap2/board-devkit8000.c           |   2 +-
>>  arch/arm/mach-omap2/board-flash.c                |   6 +-
>>  arch/arm/mach-omap2/board-flash.h                |   2 +-
>>  arch/arm/mach-omap2/board-h4.c                   |   5 +-
>>  arch/arm/mach-omap2/board-ldp.c                  |   4 +-
>>  arch/arm/mach-omap2/board-n8x0.c                 |   3 +-
>>  arch/arm/mach-omap2/board-omap3beagle.c          |   2 +-
>>  arch/arm/mach-omap2/board-omap3logic.c           |   5 +-
>>  arch/arm/mach-omap2/board-omap3pandora.c         |   3 +-
>>  arch/arm/mach-omap2/board-omap3stalker.c         |   4 +-
>>  arch/arm/mach-omap2/board-omap3touchbook.c       |   2 +-
>>  arch/arm/mach-omap2/board-overo.c                |   4 +-
>>  arch/arm/mach-omap2/board-rx51-peripherals.c     |   6 +-
>>  arch/arm/mach-omap2/board-rx51.c                 |   2 +-
>>  arch/arm/mach-omap2/gpmc-nand.c                  |   4 +-
>>  arch/arm/mach-omap2/gpmc-nand.h                  |  27 ---
>>  arch/arm/mach-omap2/gpmc-onenand.c               |   4 +-
>>  arch/arm/mach-omap2/gpmc-onenand.h               |  24 ---
>>  arch/arm/mach-omap2/gpmc-smc91x.c                |   4 +-
>>  arch/arm/mach-omap2/gpmc-smc91x.h                |  42 -----
>>  arch/arm/mach-omap2/gpmc-smsc911x.c              |   4 +-
>>  arch/arm/mach-omap2/gpmc-smsc911x.h              |  35 ----
>>  arch/arm/mach-omap2/gpmc.c                       |   7 +-
>>  arch/arm/mach-omap2/gpmc.h                       | 231 -----------------------
>>  arch/arm/mach-omap2/pm34xx.c                     |   2 +-
>>  arch/arm/mach-omap2/usb-tusb6010.c               |   3 +-
>>  include/linux/platform_data/gpmc-nand-omap.h     |  27 +++
>>  include/linux/platform_data/gpmc-omap.h          | 231 +++++++++++++++++++++++
>>  include/linux/platform_data/gpmc-onenand-omap.h  |  25 +++
>>  include/linux/platform_data/gpmc-smc91x-omap.h   |  42 +++++
>>  include/linux/platform_data/gpmc-smsc911x-omap.h |  35 ++++
>>  35 files changed, 403 insertions(+), 413 deletions(-)
>>  delete mode 100644 arch/arm/mach-omap2/gpmc-nand.h
>>  delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
>>  delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h
>>  delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h
>>  delete mode 100644 arch/arm/mach-omap2/gpmc.h
>>  create mode 100644 include/linux/platform_data/gpmc-nand-omap.h
>>  create mode 100644 include/linux/platform_data/gpmc-omap.h
>>  create mode 100644 include/linux/platform_data/gpmc-onenand-omap.h
>>  create mode 100644 include/linux/platform_data/gpmc-smc91x-omap.h
>>  create mode 100644 include/linux/platform_data/gpmc-smsc911x-omap.h
>> 
> 
> I'm not too convinced about the above diffstat. Maybe you can try a
> a better approach of making the move by: 1) renaming/moving a file,
> using 'git format-patch -M' and 2) then make the necessary changes
> in the new place.
> 
> Or, if the above ends up not fully bisectable you can try first (2)
> then (1).
>
> What bothers me most is seeing things like this:
> 
>   arch/arm/mach-omap2/gpmc-nand.h                  |  27 ---
>   arch/arm/mach-omap2/gpmc.h                       | 231 -----------------------
>   include/linux/platform_data/gpmc-nand-omap.h     |  27 +++
>   include/linux/platform_data/gpmc-omap.h          | 231 +++++++++++++++++++++++
> 
> What do you think?
> 

Agreed, I completely forgot about -M when generating the patches.

I'll wait to see what Tony thinks about this approach to take the gpmc driver
outside of mach-omap2 and send a v2 addressing the issues you pointed out.

Best regards,
Javier
