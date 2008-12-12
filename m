From: "Jason Marini" <jason.marini@gmail.com>
Subject: McBSP register question
Date: Fri, 12 Dec 2008 13:21:58 -0500
Message-ID: <423644ca0812121021k63a81930nb805b8ab7b5a6d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:39766 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758282AbYLLSV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 13:21:59 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1491747rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 10:21:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Looking at the latest git head, I see that omap_mcbsp_pollwrite() and
omap_mcbsp_pollread() improperly use readw() and writew() instead of
OMAP_MCBSP_READ() and OMAP_MCBSP_WRITE() in the file
arch/arm/plat-omap/mcbsp.c.

But while I was editing this file, I also saw writes to
OMAP_MCBSP_REG_DXR1, which is #define'd for ARCH_OMAP_34XX and
ARCH_OMAP_24XX to be at an offset of 0x0C.  The McBSP section of the
TRM for the OMAP34xx has no mention of any registers existing at this
offset.

Why is this DXR1 and not just DXR?

-Jason Marini
Associate Software Engineer
Vocollect, Inc.
