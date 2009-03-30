From: Ameya Palande <ameya.palande@nokia.com>
Subject: Query about DSP_Close() function
Date: Mon, 30 Mar 2009 19:52:42 +0300
Message-ID: <49D0F8DA.4060900@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31289 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308AbZC3Qxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 12:53:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Doyu Hiroshi <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

I am trying to make sure that when an application closes a file handle
all the resources are freed properly.

I saw that DEV_CleanupProcessState() is never called.
I am not able to locate its definition :(
Is this code intentionally disabled/removed for some reason?

Cheers,
Ameya.

/*
 *  ======== DSP_Close ========
 *      The Calling Process handle is passed to DEV_CleanupProcesState
 *      for cleaning up of any resources used by the application
 */
bool DSP_Close(u32 dwOpenContext)
{
        bool retVal = false;

        DBC_Require(dwOpenContext != 0);

        GT_0trace(curTrace, GT_ENTER, "Entering DSP_Close\n");

#ifndef RES_CLEANUP_DISABLE

        if (DSP_SUCCEEDED(DEV_CleanupProcessState((HANDLE) dwOpenContext))) {
                //GT_0trace(curTrace, GT_1CLASS, "DSP_Close Succeeded \r\n");
                pr_emerg("DSP_Close Succeeded\n");
                retVal = true;
        } else {
                //GT_0trace(curTrace, GT_7CLASS, "DSP_Close failed \r\n");
                pr_emerg("DSP_Close failed\n");
        }
#endif

        return retVal;
}
