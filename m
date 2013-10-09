From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Wed, 9 Oct 2013 12:54:10 -0500
Message-ID: <52559842.3070400@ti.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com> <alpine.DEB.2.02.1310090529420.30199@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228Ab3JIRzH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 13:55:07 -0400
In-Reply-To: <alpine.DEB.2.02.1310090529420.30199@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishant Menon <nm@ti.com>, linux-omap@vger.kernel.org

Hi Paul,

On 10/09/2013 12:35 AM, Paul Walmsley wrote:
> Hi
> 
> On Thu, 3 Oct 2013, Suman Anna wrote:
> 
>> The hwmod init sequence involves initializing and idling all the
>> hwmods during bootup. If a module class has sysconfig, the init
>> sequence utilizes the module register base for performing any
>> sysc configuration.
> 
> thanks for doing this.  A few comments:
> 
> 1. The patch adds a warning when checked with 'checkpatch.pl --strict':
> 
> CHECK: Alignment should match open parenthesis
> #109: FILE: arch/arm/mach-omap2/omap_hwmod.c:2434:
> +			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
> +				oh->name);
> 
> The issue has been fixed in in the local copy, but please don't forget to 
> ensure that your patches don't generate any warnings[*] from 
> 'checkpatch.pl --strict' before sending them.

I have not been using the --strict option, but will change my patch
sanity checking to use it going forward.

> 
> [*] Well, with the possible exception of 80-column violations when 
> necessary.
> 
> 2. -ENOMEM isn't the right error code to use here - it connotates "out of 
> memory" rather than "missing address space".  -ENXIO seems better, so I've 
> changed the patch to use that instead.

OK, thanks for fixing it up.

regards
Suman
