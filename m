From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Wed, 16 Mar 2011 16:23:27 +0530
Message-ID: <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv> <1300258302.1917.32.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54687 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751825Ab1CPKxx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 06:53:53 -0400
Received: by bwz1 with SMTP id 1so1515368bwz.36
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 03:53:48 -0700 (PDT)
In-Reply-To: <1300258302.1917.32.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stephan Raue <mailinglists@openelec.tv>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Wed, Mar 16, 2011 at 12:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Sun, 2011-03-13 at 11:20 -0500, Stephan Raue wrote:
>> Am 13.03.2011 15:32, schrieb Stephan Raue:
>
> <snip>
>
>> > i have tried this omap2plus defconfig now too, with some little
>> > changes needed to boot my system (config:
>> > http://paste.pocoo.org/show/352917/). Now i get this error (see al=
so:
>> > http://paste.pocoo.org/show/352915/)
>> >
>> > [ =A0 =A03.255065] omapdss HDMI: fallback to VGA
>> > [ =A0 =A03.271636] omapdss HDMI error: Failed to set PHY_PWR_STATU=
S
>> > [ =A0 =A03.277587] omapdss HDMI error: failed to power on device
>> > [ =A0 =A03.283325] omapdss error: failed to power on
>> > [ =A0 =A03.287902] omapfb omapfb: Failed to enable display 'hdmi'
>> > [ =A0 =A03.293853] Console: switching to colour dummy device 80x30
>> > [ =A0 =A03.304595] omapfb omapfb: failed to setup omapfb
>> > [ =A0 =A03.309539] omapfb: probe of omapfb failed with error -5
>>
>> using omap2plus defconfig with my little changes i need to boot my
>> system i get the error above, also if i remove CONFIG_ARCH_OMAP2. bu=
t if
>> i remove CONFIG_ARCH_OMAP3 too i get the error i reported originally
>> (the kernel begins to boot, but crashes) (diff between omap2plus
>> defconfig without CONFIG_ARCH_OMAP2 and omap2plus defconfig without
>> CONFIG_ARCH_OMAP2, CONFIG_ARCH_OMAP3: http://paste.pocoo.org/show/35=
2960/)
>
> I'm currently traveling for this week so I have quite limited ability=
 to
> test this. Mythri still haven't been able to reproduce any of these
> errors, right?
>
That's right i have not been able to reproduce the error.  I have
tried with 4 Panda Boards with atleast 4  - 5 Montiors connected (
Also without connecting any monitor).

> Anybody else there to test HDMI on Panda and/or Blaze? I pushed the
> latest DSS + HDMI patches to a test branch for easier testing (I'll p=
ush
> Panda DVI patches there also when I get the new version):
>
> git://gitorious.org/linux-omap-dss2/linux.git test

Stephan,
It would be great if you could try out with this tree with omap2plus_de=
fconfig.
Note : Please disable VENC , there is a known issue of kernel crash
with VENC enabled.

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
