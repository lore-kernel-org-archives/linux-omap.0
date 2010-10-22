From: Nishanth Menon <nm@ti.com>
Subject: Re: hwmod and insertable modules
Date: Fri, 22 Oct 2010 04:43:31 -0500
Message-ID: <4CC15CC3.7060406@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0JVJnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 05:43:32 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9M9hVMn022596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 04:43:31 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9M9hV0Z001173
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 04:43:31 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9M9hV5L000787
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 04:43:31 -0500 (CDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 10/22/2010 04:41 AM, the following:

>>> During module_init I used omap_device_build() to create the 
>> omap_device.
>>> But when trying to implement the module_exit, I couldn't find the
>>> corresponding 'destructor'.
>> omap_device_build essentially does  a platform_device register today
>> and hence its not something to be done from a insmod'able 'driver'.
> 
> [sp] How does this work for - say dspbridge - where the DSP as device
> may not be 'registered' until it is really expected to be used?
> 
arch/arm/mach-omap2/dspbridge.c? ;)

-- 
Regards,
Nishanth Menon
