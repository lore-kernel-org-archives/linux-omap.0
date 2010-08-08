From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED	L1
 entries
Date: Sun, 8 Aug 2010 17:16:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2363@dbde02.ent.ti.com>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
 <20100808113403.GA23623@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41386 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab0HHLqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Aug 2010 07:46:23 -0400
In-Reply-To: <20100808113403.GA23623@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, August 08, 2010 5:04 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
> L1 entries
> 
> On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> > @@ -475,6 +486,9 @@ static void __init build_mem_type_table(void)
> >  	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
> >  	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
> >  	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
> > +	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
> > +	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask | cp->pmd;
> > +	mem_types[MT_MEMORY_NONCACHED].prot_pte |= kern_pgprot;
> 
> This is wrong - it will result in the non-cached memory mapped in as
> sections having the same cache settings as MT_MEMORY - in other
> words, probably write back.
You are right. Will fix this in next version.

Regards,
Santosh
