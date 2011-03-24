From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Thu, 24 Mar 2011 08:18:45 -0700
Message-ID: <20110324151844.GT2811@atomide.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28124 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1CXPSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 11:18:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [110324 02:50]:
> Hi,
> 
> Try to run 2.6.38 on my sbc8100
> (use mach-type for devkit8000 because boards are similar) board but
> when u-boot load it to ram I see just:
> ## Booting kernel from Legacy Image at 80300000 ...
>    Image Name:   Linux-2.6.38-06570-g79c21b4
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2967164 Bytes =  2.8 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> Starting kernel ...
> 
> I have changed bootargs to: bootargs=console=ttyO2,115200n8 doesn't
> help. Any ideas what could be checked?

Can you enable DEBUG_LL and EARLY_PRINTK in your .config
and add earlyprintk to your cmdline? Then you should see
what goes wrong.

Tony
