From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap soc changes for v3.17 merge window
Date: Sat, 26 Jul 2014 11:35:11 +0200
Message-ID: <5148043.QCGen0hlse@wuerfel>
References: <20140724115850.GC29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57993 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaGZJfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jul 2014 05:35:24 -0400
In-Reply-To: <20140724115850.GC29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 24 July 2014 04:58:50 Tony Lindgren wrote:
> SoC related changes for omaps for v3.17 merge window:
> 
> - Add device tree and hwmod data for various devices
>   for new SoCs
> 
> - Remove legacy mailbox hwmod data that's no longer
>   needed for SoCs that are DT only. Note that this may
>   cause a minor merge conflict in mach-omap2/devices.c
>   with omap_init_mbox() and omap_init_hdmi_audio(), both
>   are legacy code that is getting removed

Very good, merged into next/soc. Thanks,

	Arnd
