From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
Date: Fri, 24 Sep 2010 12:12:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD469D24@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1009171147560.6562@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307F35@dbde02.ent.ti.com>
 <20100924011323.GC4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298Ab0IXGmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 02:42:33 -0400
In-Reply-To: <20100924011323.GC4211@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, September 24, 2010 6:43 AM
> To: Shilimkar, Santosh
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> support
> 

<snip..>

> Santosh, the "Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries" should
> get tested in the arm tree to avoid nasty surprises. Please do the
> following
> split:
> 
> 1. A series for Russell to pull
> ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries
> omap: Map only available sram memory
> davinci: map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
> 
> You can add my Acked-by: Tony Lindgren <tony@atomide.com> to
> the "Map only available sram memory" patch.
Have submitted above three patches to RMK's patch system with
your ack on the mentioned patch
	-	patch 6407/1
	-	patch 6408/1
	-	patch 6409/1
They are also available at:
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap_for_2.6.37-rmk

> 
> 2. A series for me to pull
> omap4: sram: Fix start address
> omap4: Update id.c and cpu.h for es2.0
> omap4: l2x0: Fix init parameter for es2.0
> omap4: Panda: Add DEBUG_LL support
> omap4: Fix bootup crash observed with higher CPU clocks
>
The pull request is sent to you with patches rebased on
v2.6.36-rc5
 
> 3. A series for Paul to pull (already in omap4_scm_2.6.37)
> omap4: control: Add ctrl_pad_base to omap_globals
> omap4: control: Add accessor api's for pad control module
> omap4: control: Add the register definition headers
> omap4: control: Fix the control module register accesses
> 
This series is already available. I just rebased on 
v2.6.36-rc5 as you suggested.

Regards,
Santosh
