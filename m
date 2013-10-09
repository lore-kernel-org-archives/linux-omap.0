From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Wed, 9 Oct 2013 05:35:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310090529420.30199@utopia.booyaka.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38784 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3JIFfi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 01:35:38 -0400
In-Reply-To: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishant Menon <nm@ti.com>, linux-omap@vger.kernel.org

Hi

On Thu, 3 Oct 2013, Suman Anna wrote:

> The hwmod init sequence involves initializing and idling all the
> hwmods during bootup. If a module class has sysconfig, the init
> sequence utilizes the module register base for performing any
> sysc configuration.

thanks for doing this.  A few comments:

1. The patch adds a warning when checked with 'checkpatch.pl --strict':

CHECK: Alignment should match open parenthesis
#109: FILE: arch/arm/mach-omap2/omap_hwmod.c:2434:
+			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
+				oh->name);

The issue has been fixed in in the local copy, but please don't forget to 
ensure that your patches don't generate any warnings[*] from 
'checkpatch.pl --strict' before sending them.

[*] Well, with the possible exception of 80-column violations when 
necessary.

2. -ENOMEM isn't the right error code to use here - it connotates "out of 
memory" rather than "missing address space".  -ENXIO seems better, so I've 
changed the patch to use that instead.


The patch has been queued provisionally, pending the outcome of testing.


- Paul

