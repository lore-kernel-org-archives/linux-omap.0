From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Mon, 01 Feb 2010 19:31:33 +0200
Message-ID: <1265045493.1997.26.camel@sanganak>
References: <1264078990-4829-1-git-send-email-ameya.palande@nokia.com>
	 <4B5DEF3D.4080701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31120 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0BARcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 12:32:04 -0500
In-Reply-To: <4B5DEF3D.4080701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "omap.ramirez@ti.com" <omap.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

Hi Omar,

On Mon, 2010-01-25 at 20:21 +0100, ext Omar Ramirez Luna wrote:
> Hi,
> 
> On 1/21/2010 7:03 AM, Ameya Palande wrote:
> > Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> > ---
> >   drivers/dsp/bridge/rmgr/proc.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> > index a75b64a..91ab64f 100644
> > --- a/drivers/dsp/bridge/rmgr/proc.c
> > +++ b/drivers/dsp/bridge/rmgr/proc.c
> > @@ -512,6 +512,10 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
> >   			 "No Exec file found \n");
> >   	}
> >   func_cont:
> > +	if (hProcObject->g_pszLastCoff) {
> > +		MEM_Free(hProcObject->g_pszLastCoff);
> > +		hProcObject->g_pszLastCoff = NULL;
> > +	}
> 
> Wouldn't be better to keep this inside PROC_Load in case of error?

PROC_Load allocates the memory to hProcObject->g_pszLastCoff which gets
freed in PROC_Detach. But PROC_AutoStart is a special case. It creates a
dummy ProcObject and after it is done with it, it frees it. And there it
leaks the memory. So IMO this is the correct place.

> Also MEM_Free checks for NULL.

Agreed! I will send a V2 of the patch with without the check.

> 
> >   	MEM_FreeObject(hProcObject);
> >   func_end:
> >   	GT_1trace(PROC_DebugMask, GT_ENTER,
> 
> Regards,
> 
> Omar

Thanks for your review!

Cheers,
Ameya.

