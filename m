From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [PATCH 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 29 Jan 2010 16:51:16 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1001291638470.11819@tumpelo.nmp.nokia.com>
References: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com> <20100128185702.6c1c0f04.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62811 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808Ab0A2OuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 09:50:21 -0500
In-Reply-To: <20100128185702.6c1c0f04.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>


Hi,

On Thu, 28 Jan 2010, ext Jarkko Nikula wrote:

> On Thu, 28 Jan 2010 17:46:25 +0200
> Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:
>
>> The first patch implements McBSP sidetone feature on OMAP3 while the second one
>> provides ALSA interface for using it.
>>
>> The patch set is based on the patch Eduardo Valentin sent to alsa-devel
>> mailing list in October 2009. Channel gain control and enabling the sidetone
>> have been moved to ALSA interface as suggested in comments.
>>
>> Eero Nurkkala (1):
>>   McBSP: OMAP3: Add sidetone feature
>>
>> Ilkka Koskinen (1):
>>   ASoC: OMAP-McBSP: ASoC interface for McBSP sidetone
>>
>>  arch/arm/mach-omap2/mcbsp.c             |    2 +
>>  arch/arm/plat-omap/include/plat/mcbsp.h |   63 +++++
>>  arch/arm/plat-omap/mcbsp.c              |  402 ++++++++++++++++++++++++++++++-
>>  sound/soc/omap/omap-mcbsp.c             |  187 ++++++++++++++
>>  sound/soc/omap/omap-mcbsp.h             |    2 +
>>  5 files changed, 655 insertions(+), 1 deletions(-)
>>
> For me the separation between arch/arm/plat-omap/mcbsp.c and
> sound/soc/omap/omap-mcbsp.c and board specific control registration
> function omap_mcbsp_st_add_controls looks ok.
>
> Set applies well on top of vanilla but the patch 1 doesn't apply on
> linux-omap due commit bcbb73c6fe8544bb50cddb8b5df0e2fcbb08b4b0.

I guess that's the case, since I just tested the patches on top 
linux-omap-2.6 master and sound tree...

> I was thinking that it makes sense to base the patch 1 on top of McBSP
> register cache patches from Janusz Krzysztofik after Tony applies
> them (+ having cache for ST regs). That avoid conflicts in mainline
> and makes the sidetone also ready for McBSP context save/restore
> functionality.

I'm ok with that. So would you suggest me to prepare the cache patch for 
ST registers? If so, would it be possible to make it as follow-up patch?

Cheers, Ilkka
