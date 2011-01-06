From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v8 4/11] OMAP3: hwmod data: add dmtimer
Date: Thu, 6 Jan 2011 11:42:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F370@dbde02.ent.ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<1294228127-11549-5-git-send-email-tarun.kanti@ti.com>
 <87oc7uuahm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54660 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1AFGMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 01:12:38 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p066CZYv014226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 00:12:37 -0600
In-Reply-To: <87oc7uuahm.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Kevin,
> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, January 06, 2011 6:14 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v8 4/11] OMAP3: hwmod data: add dmtimer
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > Add dmtimer data.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> This patch only adds GPT1-11.  What about GPT12 which is not only
> accessible on GP devices, on Beagle it is used as the system timer.
> 
> The result is this cannot boot on Beagle.
Ok, I will add. Thanks.
--
Tarun

> 
> Kevin
