From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] OMAP3: hwmod_data: add HWMOD_INIT_NO_RESET flag for dss_dispc
Date: Thu, 22 Dec 2011 16:42:32 +0400
Message-ID: <4EF325B8.2090206@emcraft.com>
References: <1324515653-17287-1-git-send-email-yanok@emcraft.com> <1324548785.13282.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:41954 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1LVMmD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 07:42:03 -0500
In-Reply-To: <1324548785.13282.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Tomi,

On 22.12.2011 14:13, Tomi Valkeinen wrote:
> On Thu, 2011-12-22 at 02:00 +0100, Ilya Yanok wrote:
>> Resetting DISPC when a DISPC output is enabled causes the DSS to go into
>> an inconsistent state.
>>
>> commit b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
>> Author: Archit Taneja <archit@ti.com>
>> Date:   Thu Oct 6 18:04:08 2011 -0600
>>
>>     ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is
>> enabled in bootloader
>>
>> tries to deal with this problem by checking if display is enabled and
>> disabling it before doing reset.
>>
>> But in my setup dss_dispc is resetted from omap_hwmod_setup_all function
>> _before_ calling omap_dss_reset. So when dispc_disable_outputs is
>> executed dispc is already reset and nothing happens.
> 
> Hmm, why is that? You don't have the dss hwmod before dispc in the list
> of hwmods? The code presumes that dss hwmod is handled first.

Looking at the arch/arm/mach-omap2/omap_hwmod_3xxx_data.c I can see that
dss_dispc is in the list of generic hwmods which is registered first
while dss_core hwmod is in revision-specific lists which are registered
later. I think this is the real root of the problem, thanks for pointing
this out!

> 
>> This patch and HWMOD_INIT_NO_RESET flags to dss_dispc hwmod thus leaving
>> DISPC untouched so that omap_dss_reset can take care of it.
> 
> omap_dss_reset() doesn't reset dispc, so this will leave dispc
> un-reseted.
> 
> The idea of the current code is to do the reset similarly on all OMAPs.
> The sequence should be:
> 
> - omap_dss_reset(), which disables dispc outputs and manually resets dss
> registers.
> - then the rest of the dss modules reset themselves normally, using the
> softreset bit.

But currently omap_dss_reset() is called the last.

Regards, Ilya.
