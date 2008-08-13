From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Wed, 13 Aug 2008 14:57:28 +0530
Message-ID: <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com> <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:45493 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbYHMJ1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 05:27:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, tony@atomide.com
Cc: linux-omap@vger.kernel.org


----- Original Message ----- 
From: "David Brownell" <david-b@pacbell.net>
To: <tony@atomide.com>; <madhu.cr@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Wednesday, August 13, 2008 2:24 PM
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2


>>  arch/arm/mach-omap2/board-3430sdp.c |    4
>>  arch/arm/mach-omap2/hsmmc.c         |  185 ++++++++++++++++++++++++++++++++
> 
> hsmmc.c is used by Beagle too, yet ...
> 
> 
>>  void __init hsmmc_init(void)
>>  {
>>  omap_set_mmc_info(1, &hsmmc_data);
>> + omap_set_mmc_info(2, &hsmmc2_data);
>>  }
> 
> ... MMC2 is rarely enabled on Beagle, so this is incorrect.
There is an another level of abstraction at the board level files like board-3430sdp.c,board-omap3beagle.c, board-omap3evm.c..
I see that the beagle board file does not enable hsmmc2. So the platform device for the second controller is not registered anyway.

> 
> 
> A better way to do this would be to let the boards say exactly
> what the hardware configuration is, rather than requiring all
> OMAP3 boards to be set up exactly like the SDP...
I think the initial version was written specific to SDP. Later on it was changed to hsmmc.c and the platforms 
which required simillar setup as SDP started using it. Now, if support for a new board is required which is unlike SDP a
new file can still be added for that perticular board, right?

Regards,
Madhu
> 
> - Dave
> 
> 
>
