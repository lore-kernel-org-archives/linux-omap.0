From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 1/4] dsp-bridge: remove unnecessary comments in
 util.h
Date: Sun, 22 Feb 2009 13:35:29 +0200 (EET)
Message-ID: <20090222.133529.59670479.Hiroshi.DOYU@nokia.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
	<1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19089 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbZBVLft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 06:35:49 -0500
In-Reply-To: <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, ameya.palande@nokia.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] dsp-bridge: remove unnecessary comments in util.h
Date: Sun, 22 Feb 2009 10:32:21 +0100

> For starters util.h should not exist, but for now I'm cleaning it up to
> remove the 'history log' which is tracked by git anyway, and wrong
> information about private functions.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/util.h |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)

These following patches look ok to me.

Hari, Please apply them to o-z as well if you think that they are ok.


> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
> index 3b3e9c0..9d8842a 100644
> --- a/arch/arm/plat-omap/include/dspbridge/util.h
> +++ b/arch/arm/plat-omap/include/dspbridge/util.h
> @@ -27,24 +27,6 @@
>   *      UTIL_GetSysInfo
>   *      UTIL_Init
>   *      UTIL_Wait
> - *
> - *  Private Functions:
> - *      isspace
> - *
> - *  Notes:
> - *
> - *! Revision History
> - *! ================
> - *! 12-Aug-2000 ag: Added UTIL_GetSysInfo().
> - *! 31-Jan-2000 rr: Comments modifed for UTIL_Wait fxn.
> - *! 17-Jan-2000 rr: UTIL_Wait fxn added. Busy waits x number of micro seconds.
> - *! 12-Nov-1999 kc: Modified UTIL_CmdLineToArgs for use by different tests.
> - *! 02-Nov-1999 kc: Removed parameter from UTIL_CDTestDll.
> - *! 29-Oct-1999 kc: Cleaned up for code review.
> - *! 08-Oct-1999 kc: Renamed UTIL_TestDllExec to UTIL_CDTestDll; added
> - *!                 UTIL_CmdLineToArgs(); added isspace private func.
> - *! 26-Dec-1996 cr: Created from misc pieces of wcd95.c, ktest.c.
> - *
>   */
> 
>  #ifndef _UTIL_H
> --
> 1.6.1.3
> 
