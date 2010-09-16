From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Thu, 16 Sep 2010 09:03:29 +0300
Message-ID: <20100916060329.GZ3393@legolas.emea.dhcp.ti.com>
References: <1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
 <20100914102407.GC7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
 <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
 <20100915071116.GE3393@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843C3C3@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53518 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0IPGDn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 02:03:43 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027843C3C3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

On Wed, Sep 15, 2010 at 10:40:08PM -0500, G, Manjunath Kondaiah wrote:
>In that case, the dma_read/dma_write macros will be splitted into:
>
>static inline void omap1_dma_write(...);
>static inline void omap2_dma_write(...);
>static inline u32 omap1_dma_read(...);
>static inline u32 omap2_dma_read(...);
>
>i.e., Two macro definitions will expand into four internal functions.

why do you need separate methods for omap1 and omap2 ??

-- 
balbi
