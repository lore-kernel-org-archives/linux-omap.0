From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: 2420 sDMA address mapping typo
Date: Tue, 15 Mar 2011 21:32:23 +0100
Message-ID: <4D7FCCD7.7050604@ti.com>
References: <E8606C3FD412994585953171ED63A9340217F287D9@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950Ab1COUcV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 16:32:21 -0400
In-Reply-To: <E8606C3FD412994585953171ED63A9340217F287D9@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Fillinger, Michael" <m-fillinger@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>

Salut Michael,

On 3/15/2011 5:44 PM, Fillinger, Michael wrote:
> Hi,
>
> There is a small issue introduced in 2.6.38 on the address space of sDMA for OMAP2420, which seems to be a mix of OMAP2&  newer OMAP addresses :
>
> arch/arm/mach-omap2/omap_hwmod_2420_data.c
>
> static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
>          {
>                   .pa_start   = 0x48056000,
>                   .pa_end     = 0x4a0560ff,
>                   .flags      = ADDR_TYPE_RT
>          },
> };
>
> pa_end should be 0x480560ff unless I'm mistaken.

Good catch, but the size is almost 4k to store all the channels.

The quick and dirty patch is:
-                   .pa_end     = 0x4a0560ff,
+                   .pa_end     = 0x48056fff,

Thanks,
Benoit
