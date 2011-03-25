From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 12:49:32 +0100
Message-ID: <201103251249.32578.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <20110324212729.14936.98130.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1CYLtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 07:49:45 -0400
In-Reply-To: <20110324212729.14936.98130.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com, Andy Green <andy.green@linaro.org>

On Thursday 24 March 2011, Andy Green wrote:
> Introduce a generic helper function that can set a MAC address using
> data from the OMAP unique CPU ID register.
> 
> For comparison purposes this produces a MAC address of
> 
>   2e:40:70:f0:12:06
> 
> for the ethernet device on my Panda.
> 
> 
> Note that this patch requires the fix patch for CPU ID register
> indexes previously posted to linux-omap, otherwise the CPU ID is
> misread on Panda by the existing function to do it.  This patch
> is already on linux-omap.
> 
> "OMAP2+:Common CPU DIE ID reading code reads wrong registers for OMAP4430"
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=b235e007831dbf57710e59cd4a120e2f374eecb9
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

TI folks: While this is a working solution, I still think it would
be good to get an officially sanctioned method that allows the creation
of a IEEE 802 MAC address in a range assigned to TI instead of using
an address from the locally administered range.

Is that something that can be done?

	Arnd
