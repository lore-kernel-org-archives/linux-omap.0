From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Tue, 21 Dec 2010 11:27:35 -0800
Message-ID: <20101221192735.GG5829@atomide.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42870 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab0LUT1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 14:27:44 -0500
Content-Disposition: inline
In-Reply-To: <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [101221 10:20]:
> From: Thomas Petazzoni <tpetazzoni@ti.com>
> 
> WARNING: This is only a proof-of-concept, there are many known
> issues. The sole purpose of this patch is to get some feedback on
> whether the idea is useful or not, and whether it's worth cleaning up
> the remaining issues.
> 
> A trend in the kernel support for SoC is to build a single kernel that
> works accross a wide range of SoC inside a SoC family, or even in the
> future SoC of different families.
> 
> While this is very interesting to reduce the number of kernel images
> needed to support a large number of hardware platforms, it allows
> means that the kernel image size is increasing. Portions of code and
> data are specific to a given SoC (clock structures, hwmod structures
> on OMAP, etc.) and only the portion relevant for the current SoC the
> kernel is running on is actually useful. The rest of the code and data
> remains in memory forever.
> 
> While __init and __initdata can solve some of those cases, it is not
> necessarly easy to use, since the code/data that is actually useful
> needs to be copied so that it is kept after the init memory cleanup.
> 
> Therefore, we introduce an infrastructure that allows to put code and
> data into specific sections, called "conditional sections". All those
> sections are compiled into the final kernel image, but at runtime, by
> calling a function, we can get rid of the unused sections.

Great, something is certainly needed to free the unused memory.
 
> For example, on OMAP, you can declare data as being omap2 specific
> this way:
> 
>    static int __omap2_data foobar;
> 
> Then, in the board code of an OMAP3 or OMAP4 platform, you can call:
> 
>    free_unused_cond_section("omap2");

Sounds like this could be done after the cpu detection automatically?

I don't know what the section limitations are, but it would be nice
to have a separate section for each machine.. Then we could just
"free_unused_machines()" during the init.. :)

Tony
