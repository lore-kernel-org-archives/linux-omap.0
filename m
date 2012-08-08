From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
Date: Wed, 08 Aug 2012 16:06:12 +0300
Message-ID: <50226444.4060100@compulab.co.il>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com> <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com> <50225A84.5010008@compulab.co.il> <50225BB5.3000407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:41312 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805Ab2HHNGU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 09:06:20 -0400
In-Reply-To: <50225BB5.3000407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

On 08/08/12 15:29, Peter Ujfalusi wrote:
> Hi Igor,
> 
> On 08/08/2012 03:24 PM, Igor Grinberg wrote:
>>> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
>>> index 97d7190..b73fa5c 100644
>>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>>> @@ -731,6 +731,7 @@ static void __init cm_t3x_common_init(void)
>>>  	cm_t35_init_ethernet();
>>>  	cm_t35_init_led();
>>>  	cm_t35_init_display();
>>> +	omap_twl4030_audio_init("overo", 26000000);
>>
>> Can the card_name here be "cm-t3x" ?
> 
> I have used the "overo" as card name here since what I gathered is that cm-t35
> used the sound/soc/omap/overo.c machine driver for audio support.
> If the card name is changing your existing user space might get confused by
> the card name change.
> But sure, I can change the card name to "cm-t3x" if it is better for you.

Well, yes I know we will need to adjust the user space.
I wanted to change that for a long time and did not get to it...
Now, with your patches, it seems like the best time for doing this.

Thanks


-- 
Regards,
Igor.
