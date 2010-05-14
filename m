From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Fri, 14 May 2010 13:18:42 +0200
Message-ID: <5FC7083E-FFD9-4297-AC5D-522FBCBF11F0@dominion.thruhere.net>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273821814.2814.63.camel@tubuntu.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC35608703042887DB@dbde02.ent.ti.com> <AA4B1310-2BA5-411E-A7EA-AAE03F41CCF3@student.utwente.nl> <4BED2CD9.9000303@ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:42839 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab0ENLSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 07:18:47 -0400
In-Reply-To: <4BED2CD9.9000303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


Op 14 mei 2010, om 12:58 heeft Nishanth Menon het volgende geschreven:

> Koen Kooi had written, on 05/14/2010 05:39 AM, the following:
>> Op 14 mei 2010, om 12:03 heeft Guruswamy, Senthilvadivu het volgende geschreven:
>>> 
>>>> -----Original Message-----
>>>> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] Sent: Friday, May 14, 2010 12:54 PM
>>>> To: Guruswamy, Senthilvadivu
>>>> Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; tony@atomide.com; Hiremath, Vaibhav
>>>> Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
>>>> 
>>>> Hi,
>>>> 
>>>> On Thu, 2010-05-13 at 17:20 +0200, ext Senthilvadivu Guruswamy wrote:
>>>>> From: Senthilvadivu Guruswamy  <svadivu@ti.com>
>>>>> 
>>>>> Hi all,
>>>>> 
>>>>> This patch series replaces the patch "DSS2 Include VRFB into omap2-3build only"
>>>>> Thanks for the review comments. 
>>>>> The intent of this series is to split the patch into 2 logical
>>>>> patches and also to incorporate the comments on multi-omap build.
>>>>> 
>>>>> In this series, Kconfig is changed to have OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
>>>>> This change takes care of the multi-omap builds. 
>>>>> This patch would allow successful build of omap_4430sdp_defconfig when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.
>>>>> 
>>>>> For verification: Generated the .config on omap3_defconfig with DSS
>>>>> and FB enabled. Generated .config is same with and without 
>>>> the patch.
>>>>> List of Changed Files:
>>>>> arch/arm/plat-omap/include/plat/vrfb.h
>>>>> drivers/video/omap2/Kconfig
>>>>> drivers/video/omap2/omapfb/Kconfig
>>>> The patch set makes VRFB optional. What happens if VRFB is turned off,
>>>> and the user uses VRFB for a framebuffer?
>>> [Senthil] This patch keeps VRFB=y for ARCH_OMAP2 and ARCH_OMAP3.
>>> User would have got an option to turn it OFF if it had appeared in the menuconfig selections.  I did not give that option in menuconfig explicitly. ie  config OMAP2_VRFB
>>> 	bool <No name given here>
>>> 
>>> Suppose on a build the user deliberately gives "CONFIG_OMAP2_VRFB not set",
>>> then VRFB functions are made as empty functions by the compiler.
>>> 
>>> This is fine as long as the user does not say omapfb.vrfb=1.
>>> 
>>> But if the user sets omapfb.vrfb=1, then it is a wrong usage of the bootargs
>>> as he has already deliberately changed the defconfig to say "VRFB not set".
>>> 
>>> The result of his experiment: No bootup on the board as the vaddr of VRFB is populated nor of the normal RAM buffer.
>> And that is unacceptable when working with customers (or users in the open 
> >source world).  Instead of the kernel hacker spending an hour or 2 on a proper
> > solution we now need to waste a whole lot more time supporting customers who
> > pass vrfb in bootargs without knowing that it's turned off in the kernel.

> But why use bootargs?

Because (for some unknown reason) you can't toggle vrfb at runtime. If you realize you need rotation you need to reboot. I guess it's because the memory layout for vrfb is completely different, but again, I'm not a kernel hacker :)

regards,

Koen