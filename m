From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Mon, 22 Dec 2008 14:50:45 +0200
Message-ID: <20081222145045.2dc800c4.jarkko.nikula@nokia.com>
References: <20081222103422.GL29448@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44877 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbYLVMvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 07:51:16 -0500
In-Reply-To: <20081222103422.GL29448@guug.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Otto Solares <solca@guug.org>
Cc: linux-omap@vger.kernel.org

On Mon, 22 Dec 2008 04:34:22 -0600
"ext Otto Solares" <solca@guug.org> wrote:

> Hi all!
> 
> I want to resurrect missing support for the Nokia Internet Tablets
> starting with the N8x0s for my NITdroid project, which uses just
> standard Linux kernel APIs.
> 
> So first I would like to ask some very newbie questions:
> 
> -Is there any ongoing effort to support these devices in latest kernels
>  at the same level as the latest Nokia production kernel (2.6.21-omap)?
> 
"make n800_defconfig" in linux-omap tree is a very good start.

> -I don't plan to suspend but just sleep while idling, is this a good
>  approach to power management (pm)?
> 
> -I read about the pm branch, where can I pull it?
> 
Probably you read already this "N810 suspend" thread?

http://marc.info/?t=122937538800002&r=1&w=2

Short: N800 can do sleep_while_idle but GPS uart clock prevents it
currently in N810 and PM branch may have solution to idle it.

> -Does CONFIG_NO_HZ works for this devices?
> 
Was working at least some months ago with N800.

> -AFAIK the recent removals of the N800 sound driver was because it was
>  not written for ALSA OMAP SoC API, right?
> 
That's correct. N810 audio is already supported with SND_OMAP_SOC_N810
but N800 would require to have ASoC codec driver for TSC2301 and DAI
link driver for EAC, at least for exact sample rates.

This is due TSC2301 which can be only slave so in order to get stardard
sample rates, EAC or McBSP would require to use external master clock
to them and EAC_AC_MCLK and McBSP2.CLKS are not routed into same pads
like other four EAC and McBSP2 signals.

Most probably McBSP DAI & TSC2301 would work also if using internal 96
MHz as a source clock to McBSP. Then sample rate would be e.g.
96 MHz / 32 / 32 = 46.875 kHz.

> If it is lack of time of the original developers, I would like to step
> in, willing to try to complete this work as long as you are willing to
> support me with answers to my newbie questions as this devices are in
> plenty operation today but the Nokia kernel is getting really old and
> it's a good thing if we can port all the drivers to standard Linux API.
> 
I welcome you to step in this porting effort! I help what I can :-)


Jarkko
