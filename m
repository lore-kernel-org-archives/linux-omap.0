From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH A 00/15] tidspbridge: general cleanups
Date: Wed, 18 Mar 2009 07:55:55 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23320B36@dlee03.ent.ti.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbZCRM4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 08:56:08 -0400
In-Reply-To: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Felipe,

Thanks for your contributions. We will push these changes to OZ tree as soon as possible.

Thank you,
Best


> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Tuesday, March 17, 2009 8:23 PM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Guzman Lugo, Fernando;
> Felipe Contreras
> Subject: [PATCH A 00/15] tidspbridge: general cleanups
> 
> This patch series is not doing much, just cleaning up the irq mailbox
> functions
> and related stuff.
> 
> Among the sem-functional changes are:
>  * 0010: avoid udelay and use time_after
>  * 0015: print an error when timing out
> 
> Felipe Contreras (15):
>   tidspbridge: remove revision history
>   tidspbridge: trivial cleanup
>   tidspbridge: remove unused stuff
>   tidspbridge: remove IO_CALLDPC
>   tidspbridge: whitespace cleanups
>   tidspbridge: trivial cleanups
>   tidspbridge: hDevContext == pDevContext
>   tidspbridge: remove UTIL_Wait wrapper
>   tidspbridge: cleanup and remove HW_MBOX_IsFull
>   tidspbridge: remove udelay and use time_after instead
>   tidspbridge: Remove IO_InterruptDSP
>   tidspbridge: remove IO_InterruptDSP2
>   tidspbridge: remove CHNLSM_InterruptDSP
>   tidspbridge: remove wIntrVal2Dsp
>   tidspbridge: print an error when timing out
> 
>  arch/arm/plat-omap/include/dspbridge/chnl_sm.h |   42 ----
>  arch/arm/plat-omap/include/dspbridge/io_sm.h   |    3 -
>  arch/arm/plat-omap/include/dspbridge/util.h    |   51 -----
>  drivers/dsp/bridge/hw/hw_mbox.c                |   25 ---
>  drivers/dsp/bridge/hw/hw_mbox.h                |   35 ----
>  drivers/dsp/bridge/wmd/_tiomap.h               |   23 --
>  drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    4 -
>  drivers/dsp/bridge/wmd/_tiomap_util.h          |    1 -
>  drivers/dsp/bridge/wmd/io_sm.c                 |   78 +-------
>  drivers/dsp/bridge/wmd/tiomap3430.c            |   18 +-
>  drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   22 +-
>  drivers/dsp/bridge/wmd/tiomap_sm.c             |  260 +++++++------------
> -----
>  12 files changed, 101 insertions(+), 461 deletions(-)
> 

