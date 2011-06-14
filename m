From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regulator cleanups in mach-omap2, take three
Date: Tue, 14 Jun 2011 04:47:32 -0700
Message-ID: <20110614114732.GR3352@atomide.com>
References: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:51983 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755872Ab1FNLrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:47:35 -0400
Content-Disposition: inline
In-Reply-To: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* green@linuxhacker.ru <green@linuxhacker.ru> [110606 11:54]:
> Hello!
> 
>   This is yet another attempt at some regulator cleanups in mach-omap2 code:
>   Convert all users to REGULATOR_SUPPLY init style and drop the old-style
>   .dev assignment common ins hs_mmc init.
> 
>   I made a test compile and all the individual board files changed compile
>   (I don't have the devices themselves, but similar changes to my
>    device board file are working).
> 
>   For the pandaboard changes - I am not sure what the proper names for those
>   devices would be, so only converted the regulator to array.
> 
>   Big changes since v2:
>   Per Felipe Balbi request converted all regulator supplies to arrays
>   just in case.
>   Also nuked an unneeded comment in cm-t35 board left after mmc.dev
>   assignment removal.

Thanks, applying to devel-cleanup branch for next merge window.

Tony
