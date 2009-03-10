From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 3/3] Boosting OPP1 voltage level
Date: Tue, 10 Mar 2009 09:17:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8E83885@dbde02.ent.ti.com>
References: <87sklmwlyi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbZCJDsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 23:48:41 -0400
In-Reply-To: <87sklmwlyi.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Kevin,
 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, March 10, 2009 12:41 AM
> To: Gupta, Ramesh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] Boosting OPP1 voltage level
> 
> "Gupta, Ramesh" <grgupta@ti.com> writes:
> 
> > From a0b8d146249e05465ff30cfd72592418c7a5da8d Mon Sep 17 
> 00:00:00 2001
> > From: Ramesh Gupta G <grgupta@ti.com>
> > Date: Thu, 12 Feb 2009 03:03:18 +0530
> > Subject: [PATCH 3/3] Boosting OPP1 voltage level
> >
> > some issues are observed like DSP sending SYS_ERROR MMU Fault if 
> > operated in OPP1, Looks like drop in voltage making DSP to 
> crash, this 
> > patch boosts voltage level slightly for stable DSP.
> >
> 
> Ramesh,
> 
> Have you retested DSPBRIDGE with the current PM branch HEAD?  
> Rajendra submitted some patches that update VDD1 that are now 
> included.  I'm guessing that will fix the problems you've 
> been seeing as well.

I had tested with Rajendra patches with latest VDD1 voltage levels that resolved 
the issues I was seeing, I sent an updated patch set for DSP bridge DVFS and OFF mode support.

[PATCH 0/1] DSPBRIDGE DVFS and offmode support updated

Ref: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg09655.html

This patch "[PATCH 3/3] Boosting OPP1 voltage level" is not required any more.

Please let me know your comments.

Regards
Ramesh Gupta G
