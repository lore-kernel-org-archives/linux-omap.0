From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces
Date: Mon, 10 May 2010 16:58:41 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD51F7@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC2622733@dlee04.ent.ti.com>
	 <27F9C60D11D683428E133F85D2BB4A53043DFD4960@dlee03.ent.ti.com>
 <AANLkTimJA_ilSR6iTjV2Flxp-aNtk0JRRb2_zYxz6F-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757104Ab0EJV6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 17:58:48 -0400
In-Reply-To: <AANLkTimJA_ilSR6iTjV2Flxp-aNtk0JRRb2_zYxz6F-2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>


>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>
>On Sun, May 9, 2010 at 7:26 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
>> >From 451e9733672b7fd3879ec109f3c6b2ac55c21cf5 Mon Sep 17 00:00:00 2=
001
>>>From: Armando Uribe De Leon <x0095078@ti.com>
>>>Date: Thu, 8 Apr 2010 17:14:38 -0500
>>>Subject: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding b=
races
>>>
>>>This patch removes checkpatch errors due to misleading braces
>>>
>>>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>>>---
>>> arch/arm/plat-omap/include/dspbridge/mem.h | =A0 =A08 ++++----
>>> drivers/dsp/bridge/dynload/cload.c =A0 =A0 =A0 =A0 | =A0 =A04 ++--
>>> drivers/dsp/bridge/pmgr/cmm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 ++---
>>> drivers/dsp/bridge/pmgr/dbll.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +=
--
>>> drivers/dsp/bridge/wmd/io_sm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +=
--
>>> drivers/dsp/bridge/wmd/tiomap3430_pwr.c =A0 =A0| =A0 =A06 ++----
>>> 6 files changed, 12 insertions(+), 17 deletions(-)
>>>
>>
>> Pushed to dspbridge.
>
>What's the point of commenting every patch? Wouldn't commenting on the
>patch series achieve the same?
>

Couldn't find the cover-letter...

Same for this series http://marc.info/?l=3Dlinux-omap&m=3D1273379414099=
14&w=3D2

- omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
