From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 19/20] GPIO: OMAP: optimize suspend and resume
 functions
Date: Thu, 7 Jul 2011 10:12:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BD02D4A@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-20-git-send-email-tarun.kanti@ti.com>
 <87d3hnf7tx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab1GGEma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 00:42:30 -0400
In-Reply-To: <87d3hnf7tx.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, July 07, 2011 2:25 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v3 19/20] GPIO: OMAP: optimize suspend and resume
> functions
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > There is no need to operate on all the banks every time the function is
> called.
> > Just operate on the current bank passed by the framework.
> 
> That's a good change.
> 
> There is also no need to runtime suspend/resume the bank if
> bank->suspend_wakeup == 0 during suspend (or bank->saved_wakeup == 0
> during resume.)
> 
> IOW, banks with no wakeups enabled have an unnecessary runtime
> resume/suspend in both the system suspend and resume path.
Ok, I will incorporate the change.
--
Tarun

> 
> Kevin
