From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 02/14] omap: Map only available sram memory
Date: Sat, 2 Oct 2010 13:19:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
 <20101001225303.GF3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0JBHtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 03:49:41 -0400
In-Reply-To: <20101001225303.GF3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, October 02, 2010 4:23 AM
> To: Grazvydas Ignotas
> Cc: Shilimkar, Santosh; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [PATCH 02/14] omap: Map only available sram memory
> 
> * Grazvydas Ignotas <notasas@gmail.com> [101001 13:07]:
> > On Fri, Sep 17, 2010 at 12:47 PM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> > > Currently we map 1 MB section while setting up SRAM on OMAPs.
> > > The actual physcal OCM RAM available on OMAP SOCs is in order
> > > of KBs. This patch maps only available sram and removes some
> > > non necessary cpu_is_xxx checks.
> > >
> > > On the newer ARMs with speculation, this is dangerous and can
> > > result in untraceable aborts.
> > >
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> > This hangs OMAP3 pandora:
> >
> > [    0.000000] Linux version
> > 2.6.36-rc6-next-20101001-00002-ge76bb53-dirty (notaz@pixelinis) (gcc
> > version 4.3.3 (Sourcery G++ Lite 2009q1-20
> > [    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7),
> cr=10c53c7f
> > [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
> > instruction cache
> > [    0.000000] Machine: Pandora Handheld Console
> > [    0.000000] Ignoring unrecognised tag 0x54410008
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] Reserving 6422528 bytes SDRAM for VRAM
> > [    0.000000] Memory policy: ECC disabled, Data cache writeback
> > [    0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
> > [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
> > (stuck here)
> >
> > reverting this fixes the problem.
> 
> Hmm, boots fine here with overo. Any idea what in this patch breaks
> pandora?
> 
The change in this patch is not board dependent really. Have tested this
on 3430SDP. Pandora is OMAP3 based, right ?

Regards,
Santosh 
