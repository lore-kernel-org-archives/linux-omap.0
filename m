From: "Taneja, Archit" <archit@ti.com>
Subject: FW: [RFC][PATCH 4/8] OMAP: DSS2: OMAP4 Secondary LCD Channel DISPC
 Registers
Date: Thu, 1 Jul 2010 17:35:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A419A3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab0GAMF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:05:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o61C5PrG013989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Jul 2010 07:05:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o61C5Or3028969
	for <linux-omap@vger.kernel.org>; Thu, 1 Jul 2010 17:35:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, Nil

 Hi,

> On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> > From: Semwal, Sumit <sumit.semwal@ti.com>
> > 
> > Introduce OMAP4 DISPC base address and Secondary LCD Channel 
> > registers, use them in register dumps.

<snip>

> >  #define DISPC_DIVISOR			DISPC_REG(0x0070)
> > +#define DISPC_DIVISOR1			DISPC_REG(0x0804)
> 
> What is this?

On OMAP4 there are 3 divisor registers, DIVISOR, DIVISOR1, DIVISOR2.
The first one can divide the DSS_CLK coming from the PRCM for DISPC_FCLK,
the last 2 provide pcd and lcd divisors for the 2 channels respectively.
The addresses and the naming are a bit confusing:

OMAP3:
DISPC_DIVISOR - 0x0070

OMAP4:
DISPC_DIVISOR - 0x0804
DISPC_DIVISOR1 - 0x0070
DISPC_DIVISOR2 - 0x040C

We really don't need this common divisor thing, so in order to make
minimal changes in the code we swapped the names of DIVISOR and DIVISOR1,
this also makes it fit well with the OMAP3 code.
You will see that DIPC_DIVISOR1 is not used at all, I just added it
for completeness, I will remove when I resubmit this series.

<snip>

> 
> >  #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
> > +#define DISPC_DIVISOR2		DISPC_REG(0x040C)
> > +#define DISPC_CONFIG2		DISPC_REG(0x0620)
> > +
> >  #define DISPC_MAX_NR_ISRS		8
> 
> Would it be possible to have similar system to these registers as with 
> for example the VID registers:
> 
> DISPC_SIZE_LCD(n) where n is 0 or 1, or possibly the channel.
> 
> This would reduce ifs quite a bit in the following patches.

Unfortunately, there is no linear mapping for the channel registers
as it is in the video plane. But I agree it is still worth it to
explicitly mention the addresses in the definitions.
It would make the later patches much cleaner.

> 
>  Tomi
> 

Thanks,

Archit