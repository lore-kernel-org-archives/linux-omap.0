From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support for bridgedriver
Date: Thu, 12 Feb 2009 14:58:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C103D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F5550D89@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58198 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbZBLJ3J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:29:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9T2sA006272
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:29:08 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9T1bk004850
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:59:01 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F5550D89@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Rajendra, 

> -----Original Message-----
> From: Nayak, Rajendra 
> Sent: Thursday, February 12, 2009 10:13 AM
> To: Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support 
> for bridgedriver
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta, Ramesh
> > Sent: Thursday, February 12, 2009 6:41 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support for 
> > bridgedriver
> > 
> > All,
> > 
> > The patch set provides DVFS and offmode support for bridgedriver.
> > These patches to be applied on top of the pm branch. Currently Some 
> > times we have observed issues like MMU fault and DSP Reset 
> on setting 
> > VDD1 to OPP1.
> > 
> > Looks like the drop in voltage to DSP core causing the issue. 
> > With a slight increase in VDD1 voltage level for OPP1 [patch 3/3] 
> > solving the issue, We are investigating further into this.
> 
> Ramesh,
> 
> The latest operating condition addendum for 3430 specifies 
> VDD1 OPP1 voltage to be .975 and OPP2 to be 1.05. Same for 
> VDD2. Rest OPP's remain the same. I will send a patch on PM 
> branch to update this and that sould solve your problem.

Thanks for looking into this, yeah this should resolve my issue with OPP1,
I will wait for your patches.

Regards
Ramesh Gupta G

 