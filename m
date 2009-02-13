From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2
Date: Fri, 13 Feb 2009 14:25:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A41776E2@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F55511F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41751 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759300AbZBMIzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 03:55:52 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1D8thSY027419
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 02:55:48 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1D8tfV9013089
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 14:25:42 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F55511F7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Rajendra,

> -----Original Message-----
> From: Nayak, Rajendra 
> Sent: Friday, February 13, 2009 11:31 AM
> To: linux-omap@vger.kernel.org
> Cc: Gupta, Ramesh
> Subject: [PATCH] OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2
> 
> This patch updates the voltage levels for VDD1 OPP1/2 and
> VDD2 OPP1/2 according to the latest operating condition
> addendum for 3430.
> 
> The new voltage levels at various OPP's for VDD1/2 are as below
> 
> VDD1 OPP1 0.975v
> VDD1 OPP2 1.050v
> VDD1 OPP3 1.200v
> VDD1 OPP4 1.270v
> VDD1 OPP5 1.350v
> 
> VDD2 OPP1 0.975v
> VDD2 OPP2 1.050v
> VDD2 OPP3 1.150v
> 
> The patch applies on the latest pm head and is validated on 3430SDP.
> 

I have tested Bridge DVFS and OFF mode with this patch, This works fine and it resolved the issues I was seeing with OPP1. 

Thanks 
Ramesh Gupta G