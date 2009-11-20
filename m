From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: Re: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
Date: Fri, 20 Nov 2009 20:17:48 +0530
Message-ID: <2ee9e08d0911200647o33a57e45j1bb4de6d9604d29a@mail.gmail.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
	<2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
	<200911200951.13181.peter.ujfalusi@nokia.com> <20091120155343.baf0b9d3.jhnikula@gmail.com>
	<1258726156.6157.11.camel@eenurkka-desktop>
Reply-To: anuj.aggarwal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44990 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZKTOsC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 09:48:02 -0500
Received: by pwi3 with SMTP id 3so2107679pwi.21
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 06:48:08 -0800 (PST)
In-Reply-To: <1258726156.6157.11.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang, Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 20, 2009 at 7:39 PM, Eero Nurkkala
<ext-eero.nurkkala@nokia.com> wrote:
> On Fri, 2009-11-20 at 14:53 +0100, ext Jarkko Nikula wrote:
>> On Fri, 20 Nov 2009 09:51:13 +0200
>> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
>>
>> > > My question is: is sysfs the only way to choose threshold or can=
 it be made
>> > > =A0as default? I could not see that happening in the code so thi=
nking of the
>> > > =A0possible reason of choosing not to do so. Because the user wh=
o wants to
>> > > =A0hit suspend will not like to issue driver specific commands. =
Any specific
>> > > =A0reason of not doing that by default?
>> >
>> > It is not selected as default on OMAP3, since it is a new feature,=
 and we don't
>> > want to change the behavior of the audio. If the reports are posit=
ive regarding
>> > to the threshold mode, than we can make it as default on OMAP3, at=
 least that is
>> > the plan AFAIK.
>>
>> Yep. Currently we want to keep DMA behaviour consistent across the
>> OMAPs and McBSP ports since the large internal FIFO is found only
>> from McBSP2 on OMAP3.
>>
>> This is good finding that you have found that it's the audio prevent=
ing
>> the suspend and the threshold transfer mode can make it hit better.
>>
>> But anyway, I'm afraid that threshold mode doesn't help to create
>> robust suspend. Threshold allow the DMA and core to be mode in idle
>> between the FIFO fills and probably that's why suspend might work
>> during these idle periods. For robust implementation there must be
>> explicit code stopping and resuming all activity gracefully so that =
it
>> can hit the suspend also if the fill is happening or if using anothe=
r
>> transfer mode.
>>
>>
>
> Looking at the very original patch, I don't know how things could get
> into deep sleep by disabling the fclk only... need to disable the icl=
k
> also. In threshold mode, HW autogates the iclk, so you may be just
> "lucky".
[Anuj] No, I am not :(. I had to modify the original patch to include
the disable part for the ICLK too. Without that, I was not able to hit
retention.
I will try to do some further regression on OMAP3 EVM and post my
findings. As of now, audio is working fine with these patches + ICLK
modification.
>
> One may want to be aware of this also:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git=
;a=3Dcommitdiff;h=3D72cc6d715d5b018e2cff4adb68966855850d4e77
>
> I think it's an undocumented feature.
>
> - Eero
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
