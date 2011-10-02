From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/30] sound/soc/omap: limit to omap2plus
Date: Sun, 02 Oct 2011 20:03:38 +0200
Message-ID: <4511363.OPCpQMvKWi@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-22-git-send-email-arnd@arndb.de> <20111002204035.2e5b98943ed5137fd689b9be@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111002204035.2e5b98943ed5137fd689b9be@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 20:40:35 Jarkko Nikula wrote:
> Strange. I'm able to build them fine with omap1_defconfig and with two
> supported OMAP1 ASoC machine drivers we have:
> 
> CONFIG_SND_OMAP_SOC_AMS_DELTA=y
> CONFIG_SND_OMAP_SOC_OSK5912=y
> 
> What's the error you are seeing? I guess there might be some missing
> dependency that doesn't get visible with omap1_defconfig.
> 
> I would like to get that fixed instead of disabling OMAP1 ASoC support
> as the ams-delta in kernel is alive device thanks to active developer
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.

I no longer have the original bug, maybe it was a false positive.
I'll drop this patch and have another look if the problem comes back.

Thanks for taking a closer look!

	Arnd
