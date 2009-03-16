From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH] DSPBRIDGE Fix for auto image load updated
Date: Mon, 16 Mar 2009 19:53:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A90DFDE6@dbde02.ent.ti.com>
References: <49BE5E0B.9060607@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58554 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbZCPOY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 10:24:28 -0400
In-Reply-To: <49BE5E0B.9060607@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Ameya,
 

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com] 
> Sent: Monday, March 16, 2009 7:41 PM
> To: Gupta, Ramesh
> Cc: linux-omap@vger.kernel.org; Menon, Nishanth; Kanigeri, Hari
> Subject: Re: [PATCH] DSPBRIDGE Fix for auto image load updated
> 
> ext Gupta, Ramesh wrote:
> > From 757beb63e8e66c168231dd990440816fc5789d6c Mon Sep 17 
> 00:00:00 2001
> > From: Ramesh Gupta <grgupta@ti.com>
> > Date: Thu, 12 Mar 2009 09:32:31 -0500
> > Subject: [PATCH] DSPBRIDGE Fix for auto image load updated 
> Resending 
> > as the previous patch was not applyng cleanly.
> > This is updated patch to fix the auto image loading while 
> bridgedriver initialization.
> > 
> > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > ---
> >  drivers/dsp/bridge/rmgr/drv_interface.c |   32 
> +++++++++++++++---------------
> >  1 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c 
> > b/drivers/dsp/bridge/rmgr/drv_interface.c
> > index 3ad7a43..80edc4d 100755
> > --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> > +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> > @@ -400,7 +400,7 @@ static int __init bridge_init(void)
> >  		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, 
> (u8 *)&temp,
> >  			    sizeof(temp));
> >  		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 
> *)base_img,
> > -                           strlen(base_img) + 1);
> > +						strlen(base_img) + 1);
> >  	} else {
> >  		temp = false;
> >  		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, 
> (u8 *)&temp, @@ 
> > -408,7 +408,7 @@ static int __init bridge_init(void)
> >  		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 
> *) "\0", (u32)2);
> >  	}
> >  	REG_SetValue(NULL, NULL, NUMPROCS, REG_SZ, (u8 *) num_procs,
> > -                   strlen(num_procs) + 1);
> > +						strlen(num_procs) + 1);
> >  
> >  	if (shm_size >= 0x10000) {	/* 64 KB */
> >  		initStatus = REG_SetValue(NULL, NULL, SHMSIZE, 
> REG_DWORD, @@ 
> > -450,18 +450,9 @@ static int __init bridge_init(void)
> >  			    sizeof(tc_wordswapon));
> >  	}
> >  	if (DSP_SUCCEEDED(initStatus)) {
> > -		driverContext = DSP_Init(&initStatus);
> > -		if (DSP_FAILED(initStatus)) {
> > -			status = -1;
> > -			GT_0trace(driverTrace, GT_7CLASS,
> > -				 "DSP/BIOS Bridge 
> initialization Failed\n");
> > -		} else {
> > -			GT_0trace(driverTrace, GT_5CLASS,
> > -					"DSP/BIOS Bridge driver 
> loaded\n");
> > -		}
> >  #ifdef CONFIG_BRIDGE_DVFS
> > -		for (i = 0; i < 5; i++)
> > -                       pdata->mpu_speed[i] = 
> vdd1_rate_table_bridge[i].rate;
> > +		for (i = 0; i < 6; i++)
> > +			pdata->mpu_speed[i] = 
> vdd1_rate_table_bridge[i].rate;
> >  
> >  		clk_handle = clk_get(NULL, "iva2_ck");
> >  		if (!clk_handle) {
> > @@ -479,6 +470,15 @@ static int __init bridge_init(void)
> >  			"clk_notifier_register FAIL for iva2_ck \n");
> >  		}
> >  #endif
> > +		driverContext = DSP_Init(&initStatus);
> > +		if (DSP_FAILED(initStatus)) {
> > +			status = -1;
> > +			GT_0trace(driverTrace, GT_7CLASS,
> > +				 "DSP/BIOS Bridge 
> initialization Failed\n");
> > +		} else {
> > +			GT_0trace(driverTrace, GT_5CLASS,
> > +					"DSP/BIOS Bridge driver 
> loaded\n");
> > +		}
> >  	}
> >  
> >  	DBC_Assert(status == 0);
> > @@ -655,11 +655,11 @@ func_cont:
> >  				(struct DRV_OBJECT 
> *)hDrvObject, &pPctxt);
> >  
> >  	if (pPctxt != NULL) {
> > -               /* Return PID instead of process handle */
> > -               hProcess = current->pid;
> > +			/* Return PID instead of process handle */
> > +			hProcess = current->pid;
> >  
> >  		DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
> > -               DRV_ProcSetPID(pPctxt, hProcess);
> > +			DRV_ProcSetPID(pPctxt, hProcess);
> >  	}
> >  #endif
> >  
> 
> Hi Ramesh,
> 
> I am not clear about the issue which this patch fixes.
> As I understand that:
> 
> 1. You have increased the count for 
> pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
> 
> 2. Moved driverContext = DSP_Init(&initStatus) after 
> clk_notifier_register stuff.

These 2 changes fix the issue.

> 
> 3. Coding Style cleanups.

This is to fix only the checkpatch warnings.

> 
> I am not able to understand what this patch is fixing and how?
> Some explanation about this will be helpful.

Clock registration is called after DSP_Init mistakenly , the image autoloading loads PROC_Load
Inturn that calls for OPP boosting while loading the image , this fails as the clock registration is not called.

There was a typo in filling the platform data (5 instead of 6) because of that, the OPP5 frequency value is not updated, that causes WARN_ON()
In the SRF.

Please let me know if you need any more information on these changes.

Thanks
Ramesh Gupta G