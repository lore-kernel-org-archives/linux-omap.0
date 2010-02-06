From: <ameya.palande@nokia.com>
Subject: RE: [PATCH 2/3] DSPBRIDGE: Get rid of MEM_Free()
Date: Sat, 6 Feb 2010 16:16:33 +0100
Message-ID: <DDE834F1D8D96540B7373DFF675BF56C1B8A2B5AA9@NOK-EUMSG-03.mgdnok.nokia.com>
References: <cover.1265296743.git.ameya.palande@nokia.com>
  <6320ca5c5c578ead8f092d0fe163bc319d0820d6.1265296743.git.ameya.palande@nokia.com>,<4B6CCCCE.4040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20896 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0BFPRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Feb 2010 10:17:11 -0500
In-Reply-To: <4B6CCCCE.4040304@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, deepak.chitriki@ti.com

Hi Omar,
________________________________________
From: ext Omar Ramirez Luna [omar.ramirez@ti.com]
Sent: Saturday, February 06, 2010 3:58 AM
To: Palande Ameya (Nokia-D/Helsinki)
Cc: linux-omap@vger.kernel.org; Menon, Nishanth; Chitriki Rudramuni, Deepak
Subject: Re: [PATCH 2/3] DSPBRIDGE: Get rid of MEM_Free()

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
-               MEM_Free(pDRVObject->devList);
-               MEM_Free(pDRVObject->devNodeString);
+               kfree(pDRVObject->devList);
+               kfree(pDRVObject->devNodeString);

proc.c
@@ -409,7 +409,7 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
                         "No Exec file found \n");
        }
  func_cont:
-       MEM_Free(hProcObject->g_pszLastCoff);
+       kfree(hProcObject->g_pszLastCoff);
        hProcObject->g_pszLastCoff = NULL;
        MEM_FreeObject(hProcObject);
  func_end:

If no objection I'll be pushing tomorrow.

No problem :)

Cheers,
Ameya.