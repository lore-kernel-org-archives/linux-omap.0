From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support for bridgedriver
Date: Fri, 13 Feb 2009 17:22:01 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A4177874@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbZBMLwk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 06:52:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1DBqWCD027313
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 05:52:38 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1DBqVrs016476
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 17:22:32 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BEB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

The patch [PATCH] OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2 from Rajendra Naik is fixing the OPP1 issues I was seeing. For Bridge DVFS to work [PATCH 1/3]DSPBRIDGE-Offmode-and-DVFS-Support.patch is sufficient from this patch set, I am going to send a single updated patch for DSPBRIDGE DVFS and OFF mode.

Thanks 
Ramesh Gupta G

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta, Ramesh
> Sent: Thursday, February 12, 2009 6:41 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support for 
> bridgedriver
> 
> All,
> 
> The patch set provides DVFS and offmode support for bridgedriver.
> These patches to be applied on top of the pm branch. 
> Currently Some times we have observed issues like MMU fault 
> and DSP Reset on setting VDD1 to OPP1.
> 
> Looks like the drop in voltage to DSP core causing the issue. 
> With a slight increase in VDD1 voltage level for OPP1 [patch 
> 3/3] solving the issue, We are investigating further into this. 
> 
> [PATCH 1/3]DSPBRIDGE-Offmode-and-DVFS-Support.patch
> [PATCH 2/3]DSPBRIDGE-DVFS-and-OFF-mode-support-with-OPP2.patch
> [PATCH 3/3]Boosting-OPP1-voltage-level.patch
> 
> 
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    2 +
>  arch/arm/plat-omap/include/dspbridge/drv.h     |    6 +
>  drivers/dsp/bridge/Kbuild                      |    3 +-
>  drivers/dsp/bridge/rmgr/drv.c                  |   11 +-
>  drivers/dsp/bridge/rmgr/drv_interface.c        |    5 +-
>  drivers/dsp/bridge/rmgr/node.c                 |   37 ++--
>  drivers/dsp/bridge/rmgr/proc.c                 |   48 ++--
>  drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    6 +
>  drivers/dsp/bridge/wmd/io_sm.c                 |  339 
> +++++++++++++-----------
>  drivers/dsp/bridge/wmd/tiomap3430.c            |  150 +++++++----
>  drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  225 
> +++++++++++++++--
>  drivers/dsp/bridge/wmd/tiomap_sm.c             |   51 ++--
>  12 files changed, 590 insertions(+), 293 deletions(-)
> 
> 
> Please let me know your comments.
> 
> Thanks & regards
> Ramesh Gupta G
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 