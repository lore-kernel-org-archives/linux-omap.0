From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Fri, 3 Apr 2009 01:31:06 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EA966D57@dbde02.ent.ti.com>
References: <20090331184802.GA27745@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB02FB086086@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C0036E7EF891@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0904011301320.9879@utopia.booyaka.com>
	<20090401220745.GJ32530@atomide.com> <87ocvghsk7.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608702EA9669B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45283 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbZDBUBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 16:01:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n32K19eW028948
	for <linux-omap@vger.kernel.org>; Thu, 2 Apr 2009 15:01:15 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n32K18Tn018568
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 01:31:08 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EA9669B3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>
>Got many choices to choose for .config if I use SDP or LDP defconfigs -
>omap_3430sdp_defconfig
>omap_ldp_defconfig
>
>Looks like these have not been up-to-date. Not sure which options to choose for these boards.
>
>Eg:
>System V IPC (SYSVIPC) [Y/n/?] y
>POSIX Message Queues (POSIX_MQUEUE) [N/y/?] (NEW) ???
>
>OMAP PM layer selection
>  1. No PM layer (OMAP_PM_NONE) (NEW)
>> 2. No-op/debug PM layer (OMAP_PM_NOOP) (NEW)
>  3. PM layer implemented using SRF (OMAP_PM_SRF) (NEW)
>choice[1-3]:

Figured out the problem:
cp arch/arm/configs/omap_ldp_defconfig .config
make 
gives erros

make ARCH=arm omap_ldp_defconfig
make 
works fine.

>
>
>>
>>Kevin
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

