From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv5 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 20 Aug 2009 18:56:03 +0300
Message-ID: <a0580c510908200856h5c766fedg259a852bb9f84cbe@mail.gmail.com>
References: <1250774523-7950-1-git-send-email-eduardo.valentin@nokia.com>
	 <20090820143017.GH12309@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:60113 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbZHTP4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 11:56:03 -0400
In-Reply-To: <20090820143017.GH12309@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hello Tony,

On Thu, Aug 20, 2009 at 5:30 PM, Tony Lindgren<tony@atomide.com> wrote:
> * Eduardo Valentin <eduardo.valentin@nokia.com> [090820 16:36]:
>> Hello guys,
>>
>> I've updated this series after some previous confusion from my side.
>>
>> Now that all dependencies are merged (Janusz's patches and Jarkko's =
patch),
>> I've based this series on Takashi's tree (master branch).
>>
>> I've also talked with Tony and he agrees to have this changes merged
>> by alsa tree. And as pointed by Jarkko, the mcbsp code is currently
>> used only by Audio inside OMAP code. So, that should be safe.
>
> You might want to merge patches 5 and 6 together as 5 adds the
> fifo, then 6 limits it's size. But in general, for patches

Right, I left it as it is just to keep track of what was done and to gi=
ve
kudos to Peter.

> 1 - 14: Acked-by: Tony Lindgren <tony@atomide.com>

Okei.

>
>> It is the same series. It now includes patch description for
>> every patch. And also, as I already said, it is based on master
>> branch of sound-2.6.
>>
>> Tested with beagle and rx51. Compiled tested for n770.
>>
>> BR,
>>
>> Eduardo Valentin (11):
>> =A0 OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1
>> =A0 =A0 registers.
>> =A0 OMAP: McBSP: Use appropriate value for startup delay
>> =A0 OMAP: McBSP: Add transmit/receive threshold handler
>> =A0 OMAP: McBSP: Create and export max_(r|t)x_thres property
>> =A0 OMAP: McBSP: Rename thres sysfs symbols
>> =A0 OMAP: McBSP: Change wakeup signals
>> =A0 OMAP: McBSP: Configure NO IDLE mode for DMA mode different of
>> =A0 =A0 threshold
>> =A0 ASoC: OMAP: Enable DMA burst mode
>> =A0 ASoC: OMAP: Make DMA 64 aligned
>> =A0 ASoC: OMAP: Use McBSP threshold to playback and capture
>> =A0 ASoC: OMAP: Use DMA operating mode of McBSP
>>
>> Eero Nurkkala (7):
>> =A0 OMAP: McBSP: Provide functions for ASoC frame syncronization
>> =A0 OMAP: McBSP: Wakeups utilized
>> =A0 OMAP: McBSP: Retain McBSP FCLK clockactivity
>> =A0 OMAP: McBSP: Do not enable wakeups for no-idle mode
>> =A0 OMAP: McBSP: Let element DMA mode hit retention also
>> =A0 ASoC: Add runtime check for RFIG and XFIG
>> =A0 ASoC: Always syncronize audio transfers on frames
>>
>> Peter Ujfalusi (2):
>> =A0 OMAP3: McBSP: Lower the maximum buffersize for McBSP1,3,4,5
>> =A0 OMAP: McBSP: Add link DMA mode selection
>>
>> =A0arch/arm/mach-omap2/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +
>> =A0arch/arm/plat-omap/include/mach/mcbsp.h | =A0 49 ++++
>> =A0arch/arm/plat-omap/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0377 ++=
++++++++++++++++++++++++++++-
>> =A0sound/soc/omap/omap-mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 77 ++++=
++-
>> =A0sound/soc/omap/omap-pcm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 +-
>> =A0sound/soc/omap/omap-pcm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
+
>> =A06 files changed, 511 insertions(+), 13 deletions(-)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Eduardo Bezerra Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
