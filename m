From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Wed, 27 Aug 2008 20:21:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C40F59BD@dbde02.ent.ti.com>
References: <52895.192.168.10.89.1218460298.squirrel@dbdmail.itg.ti.com>
 <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
 ,<B85A65D85D7EB246BE421B3FB0FBB59301A01EBC4F@dbde02.ent.ti.com>
 <8AA5EFF14ED6C44DB31DA963D1E78F0DB9195644@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58844 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbYH0Ov2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 10:51:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7REpJ9Z023100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 09:51:27 -0500
In-Reply-To: <8AA5EFF14ED6C44DB31DA963D1E78F0DB9195644@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta, Ramesh
> Sent: Wednesday, August 27, 2008 8:05 PM
> To: Dasgupta, Romit; Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
> 
> Hi Romit,
> 
> >________________________________________
> >From: Dasgupta, Romit
> >Sent: Wednesday, August 27, 2008 9:18 AM
> >To: Dasgupta, Romit; Gupta, Ramesh; Nayak, Rajendra; 
> linux-omap@vger.kernel.org
> >Suject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
> 
> >Sorry, missed the link
> >http://softwarecommunity.intel.com/articles/eng/1611.htm. 
> Search for "The Userspace Governor"
> 
> Do we have userspace governor implemented? I am not seeing 
> userspace governor with below command.
> 
> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
> ondemand performance
> 

You'll have to enable it in kernel configuration. Look under CPU Frequency Scaling.

- Anand