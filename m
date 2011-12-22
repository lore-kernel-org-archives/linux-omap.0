From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Thu, 22 Dec 2011 05:05:24 +0400
Message-ID: <4EF28254.3080009@emcraft.com>
References: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com> <loom.20111220T013434-130@post.gmane.org> <4EF07E2A.7030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:41174 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab1LVBEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 20:04:53 -0500
In-Reply-To: <4EF07E2A.7030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, "paul@pwsan.com" <paul@pwsan.com>

Hi Archit, Paul,

On 20.12.2011 16:23, Archit Taneja wrote:
> There was a patch which got into the kernel in 3.2-rc4:
> 
> b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
> ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in
> bootloader
> 
> This tries to disable any display outputs if enabled in bootloader. If
> this issue didn't happen before, we might want to look into this code.
> 
> Could you share what debug prints you get from the function
> omap_dss_reset() (its in arch/arm/mach-omap2/display.c)

In my case the bottom part of dispc_disable_outputs() is never executed
as dss_dispc is reset but omap_hwmod_setup_all function and when
dispc_disable_outputs is executed it sees that the display is disabled
already.

I've just posted a patch to fix this.

Regards, Ilya.
