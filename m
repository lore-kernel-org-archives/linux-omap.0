From: Nishanth Menon <nm@ti.com>
Subject: Re: am335x: device tree entry for PRM_RTSTIME
Date: Tue, 3 Feb 2015 09:14:53 -0600
Message-ID: <54D0E5ED.1060200@ti.com>
References: <CAGm1_kuxiM7TCOEj_Crv-U49+GwtF=3==VokPnW_6xBDjuCNog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933946AbbBCPO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 10:14:56 -0500
In-Reply-To: <CAGm1_kuxiM7TCOEj_Crv-U49+GwtF=3==VokPnW_6xBDjuCNog@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/03/2015 03:07 AM, Yegor Yefremov wrote:
> I need to change the reset length. This is not a problem via "devmem
> 0x44e00f04 32 0x000010ff", but I would like to specify this in DTS
> file.
> 
> So far I could find these macros, but they seem not be used anywhere:
> 
> arch/arm/mach-omap2/prm33xx.h:#define AM33XX_PRM_RSTTIME_OFFSET         0x0004
> arch/arm/mach-omap2/prm33xx.h:#define AM33XX_PRM_RSTTIME
>          AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0004)
> 
> What be an appropriate place to handle this register?

This ideally should come under reset framework.

-- 
Regards,
Nishanth Menon
