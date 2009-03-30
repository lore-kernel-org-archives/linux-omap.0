From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: Query about DSP_Close() function
Date: Mon, 30 Mar 2009 13:16:09 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2357EF0E@dlee03.ent.ti.com>
References: <49D0F8DA.4060900@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469AbZC3SQW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 14:16:22 -0400
In-Reply-To: <49D0F8DA.4060900@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Doyu Hiroshi <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ameya,

> I am trying to make sure that when an application closes a file handle
> all the resources are freed properly.
>

-- The current Bridge resource cleanup design is handling the resource cleanup in the Bridge open as opposed to do Bridge close.
The Bridge Open function loops through cleaning up the resources (that weren't freed by the User applications) of all the processes that were killed.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Monday, March 30, 2009 11:53 AM
> To: Kanigeri, Hari
> Cc: Doyu Hiroshi; linux-omap@vger.kernel.org
> Subject: Query about DSP_Close() function
> 
> Hi Hari,
> 
> I am trying to make sure that when an application closes a file handle
> all the resources are freed properly.
> 
> I saw that DEV_CleanupProcessState() is never called.
> I am not able to locate its definition :(
> Is this code intentionally disabled/removed for some reason?
> 
> Cheers,
> Ameya.
> 
> /*
>  *  ======== DSP_Close ========
>  *      The Calling Process handle is passed to DEV_CleanupProcesState
>  *      for cleaning up of any resources used by the application
>  */
> bool DSP_Close(u32 dwOpenContext)
> {
>         bool retVal = false;
> 
>         DBC_Require(dwOpenContext != 0);
> 
>         GT_0trace(curTrace, GT_ENTER, "Entering DSP_Close\n");
> 
> #ifndef RES_CLEANUP_DISABLE
> 
>         if (DSP_SUCCEEDED(DEV_CleanupProcessState((HANDLE)
> dwOpenContext))) {
>                 //GT_0trace(curTrace, GT_1CLASS, "DSP_Close Succeeded
> \r\n");
>                 pr_emerg("DSP_Close Succeeded\n");
>                 retVal = true;
>         } else {
>                 //GT_0trace(curTrace, GT_7CLASS, "DSP_Close failed \r\n");
>                 pr_emerg("DSP_Close failed\n");
>         }
> #endif
> 
>         return retVal;
> }

