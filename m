From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/3] DSPBRIDGE: Get rid of MEM_Free()
Date: Fri, 5 Feb 2010 19:58:38 -0600
Message-ID: <4B6CCCCE.4040304@ti.com>
References: <cover.1265296743.git.ameya.palande@nokia.com>  <6320ca5c5c578ead8f092d0fe163bc319d0820d6.1265296743.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806Ab0BFB7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:59:08 -0500
In-Reply-To: <6320ca5c5c578ead8f092d0fe163bc319d0820d6.1265296743.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 2/4/2010 9:33 AM, Ameya Palande wrote:
> kfree() is NULL and ZERO pointer safe so MEM_Free() doesn't provide any
> significant advantage. By getting rid of MEM_Free() and the NULL pointer
> check associated with it, we can save on:
> 1. One level of indirection which translates to a function call cost.
> 2. NULL pointer checking cost.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/mem.h |   19 +------
>   drivers/dsp/bridge/gen/gs.c                |    4 +-
>   drivers/dsp/bridge/pmgr/cmm.c              |   12 ++--
>   drivers/dsp/bridge/pmgr/cod.c              |    4 +-
>   drivers/dsp/bridge/pmgr/dbll.c             |   15 ++---
>   drivers/dsp/bridge/pmgr/dev.c              |    9 +--
>   drivers/dsp/bridge/pmgr/wcd.c              |   46 ++++++---------
>   drivers/dsp/bridge/rmgr/dbdcd.c            |   13 ++---
>   drivers/dsp/bridge/rmgr/disp.c             |    3 +-
>   drivers/dsp/bridge/rmgr/drv.c              |   38 +++++-------
>   drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
>   drivers/dsp/bridge/rmgr/nldr.c             |   52 ++++++-----------
>   drivers/dsp/bridge/rmgr/node.c             |   87 ++++++++++------------------
>   drivers/dsp/bridge/rmgr/proc.c             |   10 +--
>   drivers/dsp/bridge/rmgr/rmm.c              |   19 +++---
>   drivers/dsp/bridge/rmgr/strm.c             |    3 +-
>   drivers/dsp/bridge/services/mem.c          |   17 ------
>   drivers/dsp/bridge/services/ntfy.c         |    7 +-
>   drivers/dsp/bridge/services/regsup.c       |   10 ++--
>   drivers/dsp/bridge/services/sync.c         |    3 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c           |   11 ++--
>   drivers/dsp/bridge/wmd/io_sm.c             |   12 ++--
>   drivers/dsp/bridge/wmd/msg_sm.c            |    8 +-
>   drivers/dsp/bridge/wmd/tiomap3430.c        |   17 ++----
>   drivers/dsp/bridge/wmd/ue_deh.c            |    6 +-
>   25 files changed, 157 insertions(+), 270 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

I had to rework the patch as it sits on top of changes adding 3 more 
MEM_Free lines.

drv.c
@@ -603,10 +603,10 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT 
**phDRVObject)
  			 pDRVObject);
  		*phDRVObject = pDRVObject;
  	} else {
-		MEM_Free(pDRVObject->devList);
-		MEM_Free(pDRVObject->devNodeString);
+		kfree(pDRVObject->devList);
+		kfree(pDRVObject->devNodeString);

proc.c
@@ -409,7 +409,7 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
  			 "No Exec file found \n");
  	}
  func_cont:
-	MEM_Free(hProcObject->g_pszLastCoff);
+	kfree(hProcObject->g_pszLastCoff);
  	hProcObject->g_pszLastCoff = NULL;
  	MEM_FreeObject(hProcObject);
  func_end:

If no objection I'll be pushing tomorrow.

- omar
