From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Wed, 15 Sep 2010 10:11:16 +0300
Message-ID: <20100915071116.GE3393@legolas.emea.dhcp.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
 <20100914102407.GC7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
 <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38483 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0IOHLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 03:11:24 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

On Tue, Sep 14, 2010 at 09:11:26AM -0500, G, Manjunath Kondaiah wrote:
>There are several places in kernel code (ex:
>tools/perf/util/include/linux/bitops.h:static __always_inline int
>test_bit(unsigned int nr, const unsigned long *addr)) which are using
>__always_inline attribute to make sure functions are inlined.

those are special cases. Generally, compiler is much better than humans
for choosing what should be inlined or not.

>Ok, Agreed.  We can have inline functions and expanding all macros in mach-omap
>dma driver code.
>However, there is common dma driver(in plat-omap) which has code for both omap1
>and omap2plus which uses this macro.

well, that can be patched, right ?

-- 
balbi
