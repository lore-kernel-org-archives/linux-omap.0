From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 00/18] Custom debug cleanup
Date: Tue, 23 Feb 2010 11:53:13 -0600
Message-ID: <4B841609.5010608@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53017 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab0BWRxS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 12:53:18 -0500
In-Reply-To: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 2/16/2010 2:42 AM, Ramirez Luna, Omar wrote:
> Step 1 to remove custom debug tracing
>
> Omar Ramirez Luna (18):
>    DSPBRIDGE: Remove entry point custom debug statements for rmgr
>    DSPBRIDGE: Remove entry point custom debug statements for wmd
>    DSPBRIDGE: Remove entry point custom debug statements for pmgr
>    DSPBRIDGE: Remove entry point custom debug statements for wmd
>    DSPBRIDGE: Remove debug statements for success in rmgr
>    DSPBRIDGE: Remove debug statements for success in wmd
>    DSPBRIDGE: Remove debug statements for success in pmgr
>    DSPBRIDGE: Remove debug statements for success in services
>    DSPBRIDGE: Remove excessive debug statements for rmgr
>    DSPBRIDGE: Remove excessive debug statements for wmd
>    DSPBRIDGE: Remove excessive debug statements for pmgr
>    DSPBRIDGE: Remove excessive debug statements for services
>    DSPBRIDGE: change init statements to pr_info in rmgr
>    DSPBRIDGE: change critical error statements to pr_err in rmgr
>    DSPBRIDGE: change critical error statements to pr_err in wmd
>    DSPBRIDGE: print dsp trace buffer by default
>    DSPBRIDGE: change critical error statements to pr_err in pmgr
>    DSPBRIDGE: change critical error statements to pr_err in services
>
>   drivers/dsp/bridge/pmgr/chnl.c          |   43 +---
>   drivers/dsp/bridge/pmgr/cmm.c           |   87 +------
>   drivers/dsp/bridge/pmgr/cod.c           |  107 ++-------
>   drivers/dsp/bridge/pmgr/dbll.c          |   59 +----
>   drivers/dsp/bridge/pmgr/dev.c           |  238 ++----------------
>   drivers/dsp/bridge/pmgr/dmm.c           |   54 +----
>   drivers/dsp/bridge/pmgr/io.c            |   34 +---
>   drivers/dsp/bridge/pmgr/msg.c           |   15 +-
>   drivers/dsp/bridge/pmgr/wcd.c           |  139 +----------
>   drivers/dsp/bridge/rmgr/dbdcd.c         |  122 +---------
>   drivers/dsp/bridge/rmgr/disp.c          |  143 +----------
>   drivers/dsp/bridge/rmgr/drv.c           |  166 +++-----------
>   drivers/dsp/bridge/rmgr/drv_interface.c |   62 ++----
>   drivers/dsp/bridge/rmgr/dspdrv.c        |   22 +--
>   drivers/dsp/bridge/rmgr/mgr.c           |   75 +-----
>   drivers/dsp/bridge/rmgr/nldr.c          |   57 +----
>   drivers/dsp/bridge/rmgr/node.c          |  295 +++++------------------
>   drivers/dsp/bridge/rmgr/proc.c          |  407 ++++---------------------------
>   drivers/dsp/bridge/rmgr/rmm.c           |   35 +---
>   drivers/dsp/bridge/rmgr/strm.c          |   84 +------
>   drivers/dsp/bridge/services/cfg.c       |  134 ++--------
>   drivers/dsp/bridge/services/clk.c       |   49 +---
>   drivers/dsp/bridge/services/dbg.c       |    4 +-
>   drivers/dsp/bridge/services/mem.c       |   51 +----
>   drivers/dsp/bridge/services/ntfy.c      |    4 +-
>   drivers/dsp/bridge/services/reg.c       |   10 -
>   drivers/dsp/bridge/services/services.c  |    3 -
>   drivers/dsp/bridge/services/sync.c      |  151 ++----------
>   drivers/dsp/bridge/wmd/chnl_sm.c        |   37 +---
>   drivers/dsp/bridge/wmd/io_sm.c          |  130 ++---------
>   drivers/dsp/bridge/wmd/mmu_fault.c      |    9 -
>   drivers/dsp/bridge/wmd/tiomap3430.c     |  208 +++-------------
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   70 +-----
>   drivers/dsp/bridge/wmd/tiomap_io.c      |   58 +----
>   drivers/dsp/bridge/wmd/tiomap_sm.c      |    6 -
>   drivers/dsp/bridge/wmd/ue_deh.c         |   29 +--
>   36 files changed, 418 insertions(+), 2779 deletions(-)
>

Rebased and pushed to dspbridge

- omar
