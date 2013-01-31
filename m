From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 16:56:48 +0530
Message-ID: <510A54F8.4090609@ti.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab3AaL06 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 06:26:58 -0500
In-Reply-To: <1359622829.10415.40.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Tero,

On Thursday 31 January 2013 02:30 PM, Tero Kristo wrote:
> Personally I don't like too much to have just extra spam during boot,
> which in many cases is even unnecessary (e.g. people who actually have
> good u-boot in use.) Personally I would like to have some sort of test
> during boot which detects broken PM and maybe prevents core idle
> completely if this is the case. Alternatively we can add extra info to
> the failed suspend dump and mention a good u-boot to try out (v2012-07
> or newer.)
>
> If we could detect boot loader version from kernel side, that would work
> also.

Given that there is no easy way to say for sure the bootloader is the
cause for broken PM in the kernel, neither is it possible to know the
bootloader version, why don't we do this.
Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
that it isn't enabled by default in omap2plus_defconfig. Also
throw one when a suspend fails, saying bootloader *could be* a possible
cause specifying the right version to be used. That should give enough
hints to folks still using old bootloaders and testing PM.
Does that sound good?

regards,
Rajendra

