From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH v2 0/2] Enable CAN peripheral support on AM3517
Date: Thu, 1 Apr 2010 19:41:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703048E5983@dbde02.ent.ti.com>
References: <1267186035-8146-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab0DAOLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 10:11:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o31EB1VL020342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Apr 2010 09:11:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o31EB0HI027039
	for <linux-omap@vger.kernel.org>; Thu, 1 Apr 2010 19:41:00 +0530 (IST)
In-Reply-To: <1267186035-8146-1-git-send-email-srk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gole, Anant" <anantgole@ti.com>



> -----Original Message-----
> From: Govindarajan, Sriramakrishnan
> Sent: Friday, February 26, 2010 5:37 PM
> To: linux-omap@vger.kernel.org
> Cc: Gole, Anant; Govindarajan, Sriramakrishnan
> Subject: [PATCH v2 0/2] Enable CAN peripheral support on AM3517
> 
> AM3517 platform includes the ti-hecc CAN peripheral. This patch
> series enables support for the ti-hecc peripheral on AM3517 platform.
> This patch series has been validated on AM3517EVM.
> 
> This patch is generated against tip of linux-omap.
> 
> Sriramakrishnan (2):
>   can:ti_hecc: board specific hookup on AM3517EVM
>   can:ti_hecc: Enable CAN support on AM3517.
> 
>  arch/arm/configs/am3517_evm_defconfig     |   22 +++++++++++++---
>  arch/arm/mach-omap2/board-am3517evm.c     |   38
> +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/am35xx.h |    9 +++++++
>  3 files changed, 65 insertions(+), 4 deletions(-)

[Sriram]  Tony, 
Any comments on this patch
Thanks,
Sriram

