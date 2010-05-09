From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces
Date: Sun, 9 May 2010 13:47:51 +0300
Message-ID: <AANLkTimJA_ilSR6iTjV2Flxp-aNtk0JRRb2_zYxz6F-2@mail.gmail.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC2622733@dlee04.ent.ti.com>
	 <27F9C60D11D683428E133F85D2BB4A53043DFD4960@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34184 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0EIKry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 06:47:54 -0400
Received: by bwz19 with SMTP id 19so1262945bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 09 May 2010 03:47:51 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DFD4960@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Sun, May 9, 2010 at 7:26 AM, Ramirez Luna, Omar <omar.ramirez@ti.com=
> wrote:
> >From 451e9733672b7fd3879ec109f3c6b2ac55c21cf5 Mon Sep 17 00:00:00 20=
01
>>From: Armando Uribe De Leon <x0095078@ti.com>
>>Date: Thu, 8 Apr 2010 17:14:38 -0500
>>Subject: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding br=
aces
>>
>>This patch removes checkpatch errors due to misleading braces
>>
>>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>>---
>> arch/arm/plat-omap/include/dspbridge/mem.h | =C2=A0 =C2=A08 ++++----
>> drivers/dsp/bridge/dynload/cload.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A04 ++--
>> drivers/dsp/bridge/pmgr/cmm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A05 ++---
>> drivers/dsp/bridge/pmgr/dbll.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A03 +--
>> drivers/dsp/bridge/wmd/io_sm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A03 +--
>> drivers/dsp/bridge/wmd/tiomap3430_pwr.c =C2=A0 =C2=A0| =C2=A0 =C2=A0=
6 ++----
>> 6 files changed, 12 insertions(+), 17 deletions(-)
>>
>
> Pushed to dspbridge.

What's the point of commenting every patch? Wouldn't commenting on the
patch series achieve the same?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
