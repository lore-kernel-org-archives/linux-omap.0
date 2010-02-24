From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [Patchv2 0/8] DSPBRIDGE: typedef cleanup
Date: Tue, 23 Feb 2010 20:11:14 -0600
Message-ID: <4B848AC2.9080506@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab0BXCLP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 21:11:15 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1O2BEeX004105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:11:14 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1O2BEK9022596
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:11:14 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1O2BEfG001172
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:11:14 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Bhavin Shah <bshah@ti.com>, "Menon, Nishanth" <nm@ti.com>

On 2/5/2010 7:21 PM, Hebbar, Shivananda wrote:
> Resending the patches after updating review comments and also
> Fixing some compilation breaks.
>
> These patches remove the typedefs and replace it with normal C types:
>
> Shivananda Hebbar (8)
>
> DSPBRIDGE: typedef cleanup -DSP RTOS
> DSPBRIDGE: typedef cleanup -PROCTYPE
> DSPBRIDGE: typedef cleanup -PROCFAMILY
> DSPBRIDGE: typedef cleanup -DSP_HSTREAM
> DSPBRIDGE: typedef cleanup -DSP_HPROCESSOR
> DSPBRIDGE: typedef cleanup -DSP_HNODE
> DSPBRIDGE: typedef cleanup -BRD_STATUS
> DSPBRIDGE: typedef cleanup -CHNL_MODE
>
>   arch/arm/plat-omap/include/dspbridge/brddefs.h  |    1 -
>   arch/arm/plat-omap/include/dspbridge/chnldefs.h |    2 -
>   arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   18 +---
>   arch/arm/plat-omap/include/dspbridge/dispdefs.h |    4 +-
>   arch/arm/plat-omap/include/dspbridge/dmm.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/drv.h      |    6 +-
>   arch/arm/plat-omap/include/dspbridge/node.h     |    4 +-
>   arch/arm/plat-omap/include/dspbridge/proc.h     |   43 +++++-----
>   arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   96 +++++++++++-----------
>   arch/arm/plat-omap/include/dspbridge/wmd.h      |    4 +-
>   arch/arm/plat-omap/include/dspbridge/wmdchnl.h  |    2 +-
>   drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
>   drivers/dsp/bridge/pmgr/dev.c                   |    6 +-
>   drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
>   drivers/dsp/bridge/pmgr/wcd.c                   |    4 +-
>   drivers/dsp/bridge/rmgr/node.c                  |   12 ++--
>   drivers/dsp/bridge/rmgr/proc.c                  |   56 +++++++-------
>   drivers/dsp/bridge/rmgr/strm.c                  |    2 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c                |    8 +-
>   drivers/dsp/bridge/wmd/tiomap3430.c             |    4 +-
>   21 files changed, 134 insertions(+), 146 deletions(-)
> --

Patch 5 had lots of checkpatch errors, I understand that they were there 
before but would be good if they are fixed when touching those lines 
(btw they were fixed). For this patch only one "suspect code indent" is 
still there because of the original code, it can't be fixed without 
changing a big chunk of the file so leaving it as it is (will be 
addressed by lindent)

Pushed to dspbridge

- omar
