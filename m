From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: hwmod and insertable modules
Date: Fri, 22 Oct 2010 15:07:42 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab0JVJhv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 05:37:51 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9M9blbX022120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 04:37:50 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9M9bkF0026415
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 15:07:47 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, October 22, 2010 2:43 PM
> To: linux-omap@vger.kernel.org
> Subject: hwmod and insertable modules
> 
> Hi all,
> 
> I was trying to use hwmod in one of the modules that user could choose
> to insert via insmod.
> 
> During module_init I used omap_device_build() to create the omap_device.
> But when trying to implement the module_exit, I couldn't find the
> corresponding 'destructor'.

omap_device_build essentially does  a platform_device register today
and hence its not something to be done from a insmod'able 'driver'.

Device registrations should happen only once from a board file or some
other place appropriate. The insmod'able driver can then be inserted
and rmmoded as many times without removing the device registration.

Regards,
Rajendra

> 
> I do see 4 kzalloc()s being called for each omap_device_build(). I do
> have a half-implemented destructor; but before I proceeded ahead I
> wanted to pose few questions which can help undertand if I am on a
> good track:
> 
> 1) Is the omap_device supposed to be persistent? i.e. subsequent
>    calls will return me the same device object?
> 
> 2) Has someone else tried to to use omap_device and done multiple
>    insmod and rmmod operations?
> 
> 3) Is my fear of memory leak real? OR there is some magic behind
>    omap_device_shutdown() that I haven't yet discovered?
> 
> Best regards,
> Sanjeev--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
