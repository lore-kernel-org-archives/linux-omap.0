From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 21:59:47 +0530
Message-ID: <510A9BFB.5070802@ti.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com> <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57972 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350Ab3AaQ2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 11:28:40 -0500
In-Reply-To: <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

On Thursday 31 January 2013 09:10 PM, Paul Walmsley wrote:
> Hi,
>
> On Thu, 31 Jan 2013, Rajendra Nayak wrote:
>
>> Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
>> that it isn't enabled by default in omap2plus_defconfig. Also
>> throw one when a suspend fails, saying bootloader *could be* a possible
>> cause specifying the right version to be used.
>
> In my view, these steps aren't sufficient, for the reasons described in
>
> http://marc.info/?l=linux-omap&m=135964568904053&w=2
>
> Even with CONFIG_CPU_IDLE=n, it's still possible to attempt to enter
> full-chip retention idle on OMAP4 via 'echo mem > /sys/power/state', so it
> doesn't seem right to restrict a solution to that case.
>

I think rajendra also mentioned adding one in suspend path too
when it fails.
" Also throw one when a suspend fails, saying bootloader
*could be* a possible cause specifying the right version to be used."

I find Rajendra's suggestion reasonable because some one might
just miss the boot message but getting the message on failure
case cant' be missed.

Regards
Santosh
