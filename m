From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/3] DSPBRIDGE: Return right error codes
Date: Wed, 20 Jan 2010 16:52:23 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DF3B222@dlee03.ent.ti.com>
References: <1263924911-7404-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52084 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0ATWw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 17:52:27 -0500
In-Reply-To: <1263924911-7404-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar on Tuesday, January 19, 2010 12:15 PM
>
>This set of patches fixes the overwritten or missing error codes
>returned from different bridge layers.
>
>Fernando Guzman Lugo (3):
>  DSPBRIDGE: return right error codes wmd directory
>  DSPBRIDGE: return right error codes services directory
>  DSPBRIDGE: return right error codes rmgr directory
>
> drivers/dsp/bridge/rmgr/dbdcd.c         |   31 ++--
> drivers/dsp/bridge/rmgr/disp.c          |   36 ++--
> drivers/dsp/bridge/rmgr/drv.c           |   89 +++++----
> drivers/dsp/bridge/rmgr/dspdrv.c        |   27 ++--
> drivers/dsp/bridge/rmgr/mgr.c           |   23 +--
> drivers/dsp/bridge/rmgr/nldr.c          |   32 +--
> drivers/dsp/bridge/rmgr/node.c          |  123 ++++++------
> drivers/dsp/bridge/rmgr/proc.c          |  100 ++++------
> drivers/dsp/bridge/rmgr/strm.c          |   31 +--
> drivers/dsp/bridge/services/cfg.c       |    8 +-
> drivers/dsp/bridge/services/clk.c       |    7 +-
> drivers/dsp/bridge/services/reg.c       |   25 +--
> drivers/dsp/bridge/services/sync.c      |    1 -
> drivers/dsp/bridge/wmd/chnl_sm.c        |  230 +++++++++++------------
> drivers/dsp/bridge/wmd/io_sm.c          |  322 ++++++++++++++-----------------
> drivers/dsp/bridge/wmd/mmu_fault.c      |    4 +-
> drivers/dsp/bridge/wmd/msg_sm.c         |   47 +++--
> drivers/dsp/bridge/wmd/tiomap3430.c     |   28 +--
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   10 +-
> drivers/dsp/bridge/wmd/tiomap_io.c      |   10 +-
> drivers/dsp/bridge/wmd/tiomap_sm.c      |    2 -
> drivers/dsp/bridge/wmd/ue_deh.c         |   21 +--
> 22 files changed, 542 insertions(+), 665 deletions(-)

Pushed to dspbridge

- omar
