From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 0/2] OMAP: GPIO: cleanup: first pass at ifdef removal
Date: Thu, 21 Apr 2011 14:02:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037AD272CB@dbde02.ent.ti.com>
References: <1303344831-7889-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33673 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab1DUIcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 04:32:54 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3L8Wo6H005099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 03:32:53 -0500
In-Reply-To: <1303344831-7889-1-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> 
> This series is a first pass at the #ifdef removal cleanup.
> 
> To demonstrate the type of changes needed for the cleanup, the
> direction and data input/output functions are handled first.  Register
> offset fields are added to platform_data so #ifdefs can be removed.
> 
> Similar needs to be done for the remaining #ifdefs.
> 
> Currently boot tested on 3430/n900 only.
Tested following on OMAP2420, OMAP2430, OMAP4430:
-> request/free of gpio lines
-> configure input/output mode
-> interrupt configuration
-> read/write
--
Tarun
> 
> Series applies to v2.6.39-rc4.
> 
> Kevin Hilman (2):
>   OMAP: GPIO: move register offset defines into gpio.h
>   OMAP: GPIO: consolidate direction, input, output, remove #ifdefs
> 
>  arch/arm/mach-omap1/gpio15xx.c         |    7 +
>  arch/arm/mach-omap1/gpio16xx.c         |   15 ++
>  arch/arm/mach-omap1/gpio7xx.c          |   15 ++
>  arch/arm/mach-omap2/gpio.c             |   10 +
>  arch/arm/plat-omap/gpio.c              |  328 +++------------------------
> ----
>  arch/arm/plat-omap/include/plat/gpio.h |  111 +++++++++++
>  6 files changed, 190 insertions(+), 296 deletions(-)
> 
> --
> 1.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
