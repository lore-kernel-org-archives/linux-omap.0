From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
Date: Fri, 30 Apr 2010 20:03:38 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304E80EE8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38440 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab0D3Qsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 12:48:40 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Govindarajan, Sriramakrishnan
> Sent: Tuesday, February 23, 2010 12:08 PM
> To: linux-omap@vger.kernel.org
> Cc: Gole, Anant; Govindarajan, Sriramakrishnan
> Subject: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
> 
> Add board specific hookup for TI HECC driver on
> AM3517 EVM
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> Acked-by: Anant Gole <anantgole@ti.com>
> ---
> The driver requires that CAN_STB signal be driven low to enable
> CAN PHY. Currently this is being managed from U-boot. Will submit a patch
> for handling this as part of board init sequence.
> 
>  arch/arm/mach-omap2/board-am3517evm.c     |   38
> +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/am35xx.h |   10 +++++++
>  2 files changed, 48 insertions(+), 0 deletions(-)
> 
[Sriram] Tony, there hasn't been any review comments on this patch for long. Do you any comments on this patch? If not can please apply this patch

Regards
Sriram
