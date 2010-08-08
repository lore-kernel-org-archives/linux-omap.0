From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED	L1
 entries
Date: Sun, 8 Aug 2010 17:14:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2362@dbde02.ent.ti.com>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
 <20100808113550.GB23623@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0HHLoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Aug 2010 07:44:39 -0400
In-Reply-To: <20100808113550.GB23623@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, August 08, 2010 5:06 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
> L1 entries
> 
> On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> > This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONACHED
> 
> Spelling.
> 
> > types so that at boot-up, we can map memories outside system memory
> > at page level granularity
> 
> If you're only using MT_MEMORY_NONCACHED (it seems so from patch 4),
> please only modify that entry.

Patch 2 uses "MT_MEMORY_NONCACHED" for OMAP3 and MT_MEMORY for
rest of the OMAPs. So we need both.

Regards,
Santosh
