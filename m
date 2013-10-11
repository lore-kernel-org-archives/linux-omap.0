From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.13
Date: Fri, 11 Oct 2013 21:05:27 +0200
Message-ID: <52584BF7.8060100@baylibre.com>
References: <52582A67.6050108@baylibre.com> <20131011180324.GV29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:39607 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3JKTFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 15:05:32 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so4561935wes.6
        for <linux-omap@vger.kernel.org>; Fri, 11 Oct 2013 12:05:30 -0700 (PDT)
In-Reply-To: <20131011180324.GV29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Tony,

On 11/10/2013 20:03, Tony Lindgren wrote:
> Hi Benoit,
>
> * Benoit Cousson <bcousson@baylibre.com> [131011 09:50]:
>> Add the minimal DTS support for DRA7xx based SoC core.
>> Add the initial support for N900 and gta04 phones.
>> Enable USB3 on OMAP5 evm board.
>> Add support for cryto accelerators
>> Add new IGEP AQUILA board
>> Add AM33XX EDMA support
>> Update HSUSB node to use the reset-gpios fmwk
>
> Looks good to me, but we're getting self-inflicted merge
> conflicts in two places now with Paul's hwmod changes,
> and my defconfig changes.

Damn!

> Can you please respin without the following two patches:
>
> 49bcd824c1c0db32fe4de0c1ba3ee36defdb11ca ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies
> 736c4bb159c793b00331261438deb982cbac3c03 ARM: OMAP5: hwmod: add missing ocp2scp hwmod data
>
> I can pick the two patches above and apply after pulling in
> Paul's branch first.

OK, no problem.

>
> However, if other branches are based on this, then we just
> need to deal with the merge conflicts, and there's no point
> in redoing your branch.

Considering the patches, I don't see any dependency with the other ones, 
as soon as they are pulled before the DTS changes.

I'll do that ASAP and repost.

Benoit

