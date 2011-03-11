From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 11 Mar 2011 09:43:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD942@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <87ei6eftpc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40969 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1CKEOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 23:14:08 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2B4E403005603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 22:14:06 -0600
In-Reply-To: <87ei6eftpc.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 11, 2011 4:51 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Add routines to converts dmtimers to platform devices. The device data
> > is obtained from hwmod database of respective platform and is registered
> > to device model after successful binding to driver. It also provides
> > provision to access timers during early boot when pm_runtime framework
> > is not completely up and running.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> To make this series more readable, all the system_timer related
> additions added in this patch (varialbles and functions) should not be
> here since they are not used.  Instead, they should be added in the
> patch that uses them.
Sure, I will make this change.
--
Tarun
> 
> Kevin
