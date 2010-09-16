From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Thu, 16 Sep 2010 09:40:39 +0300
Message-ID: <20100916064039.GG3393@legolas.emea.dhcp.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
 <20100914102407.GC7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
 <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
 <20100915071116.GE3393@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843C3C3@dbde02.ent.ti.com>
 <20100916060329.GZ3393@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843C55C@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40086 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637Ab0IPGkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 02:40:53 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027843C55C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

On Thu, Sep 16, 2010 at 01:32:58AM -0500, G, Manjunath Kondaiah wrote:
>#define dma_read(reg)                                                   \
>({                                                                      \
>        u32 __val;                                                      \
>        if (cpu_class_is_omap1())                                       \
>                __val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);   \
>        else                                                            \
>                __val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);   \
>        __val;                                                          \
>})
>
>Since we are expanding abbrevated register offsets into full macro,
>hence these macros should be used in respective read/write
>functions(omap1 and omap2plus).
>
>Any other better methods?

generally we always define static inlines for read{b,w,l} and write{b,
w, l}, so instead of calling them omap1_* and omap2_* call them
something like omap_dma_readw(), omap_dma_readl().

-- 
balbi
