From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: [PATCH 0/8] Omap fixes for v2.6.32-rc6
Date: Wed, 11 Nov 2009 03:16:49 +0000
Message-ID: <4AFA2CA1.4000005@blueyonder.co.uk>
References: <20091111025907.31793.84134.stgit@localhost>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:42831 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755568AbZKKDQu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 22:16:50 -0500
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N83hX-00088E-41
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 03:16:55 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N83hW-0001O0-ML
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 03:16:54 +0000
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I still haven't been able to find the reason why the Ralink drivers
haven't been offered in make config/menuconfig/xconfig - cross compiling
on Fedora 12 x86_64 as per my previous post. I downloaded the latest
linux-omap snapshot Tuesday, 6 hours after it was up.
Regards
Sid.

On 11/11/09 03:00, Tony Lindgren wrote:
> Hi all,
> 
> Here are still few more fixes for review for the current -rc series.
> 
> Regards,
> 
> Tony
> 
> ---
> 
> Grazvydas Ignotas (2):
>       omap: update Pandora defconfig
>       omap3: pandora: Fix keypad keymap
> 
> Janusz Krzysztofik (1):
>       omap1: Amstrad Delta defconfig fixes
> 
> Jarkko Nikula (1):
>       omap3: beagle: Fix USB host port power control
> 
> Mike Turquette (1):
>       omap3: Decrease cpufreq transition latency
> 
> Sergio Aguirre (1):
>       omap3: 3430sdp: Enable Linux Regulator framework
> 
> Tao Hu (1):
>       omap: Fix race condition in omap dma driver
> 
> Tobias Klauser (1):
>       omap: Use resource_size
> 
> 
>  arch/arm/configs/ams_delta_defconfig     |   24 +++++++--
>  arch/arm/configs/omap3_pandora_defconfig |   49 +++++++++++++++++--
>  arch/arm/configs/omap_3430sdp_defconfig  |    9 +++
>  arch/arm/mach-omap2/board-omap3beagle.c  |    2 -
>  arch/arm/mach-omap2/board-omap3pandora.c |   78 +++++++++++++++---------------
>  arch/arm/mach-omap2/gpmc.c               |    2 -
>  arch/arm/mach-omap2/mailbox.c            |    2 -
>  arch/arm/plat-omap/cpu-omap.c            |    2 -
>  arch/arm/plat-omap/dma.c                 |    6 ++
>  9 files changed, 118 insertions(+), 56 deletions(-)
> 


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

