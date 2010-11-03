From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
Date: Wed, 3 Nov 2010 12:21:34 -0400
Message-ID: <AANLkTinSwSnozABAJrNzc+vNNVyV-qOo_avSQXWmihyF@mail.gmail.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BE1EB1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab0KCQVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 12:21:35 -0400
Received: by ewy7 with SMTP id 7so382050ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 09:21:34 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1EB1C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

On Wed, Nov 3, 2010 at 8:59 AM, Taneja, Archit <archit@ti.com> wrote:
> Hi,
>
> Bryan Wu <bryan.wu@canonical.com> wrote:
>> There are 4 duplicated panel drivers in DSS2 display driver.
>> They are similar and generic panel driver can support all
>> them with specific panel configuration.
>> And new panel driver can be easily supported by adding panel
>> configurations into generic panel driver.
>>
>> This patchset introduces generic panel driver, remove 3 panel
>> drivers and enable generic panel driver in board files. And
>> it is based on 2.6.37-rc1.
>>
>> Building with omap2plus_defconfig is successful.
>>
>> Keep sharp_ls_panel, since it contains blacklight control
>> code which will be moved out later.
>>
>> Bryan Wu (3):
>> =A0 OMAP: DSS2: Add generic panel display driver
>> =A0 OMAP: DSS2: remove generic panel driver duplicated panel drivers
>> =A0 OMAP: use generic panel driver in board files
>>
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
>> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +-
>> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +
>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A01 +
>> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 +
>> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A01 +
>> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
>> =A0arch/arm/plat-omap/include/plat/display.h =A0 =A0 =A0 =A0 =A0| =A0=
 28 +++-
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 16 +--
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 -
>> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0153=
 ++++++++++++++++--
>> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0165
>> =A0-------------------- .../video/omap2/displays/panel-toppoly-tdo35=
s.c =A0 =A0|
>> =A0164 ------------------- 14 files changed, 175 insertions(+), 369 =
deletions(-)
>> delete mode 100644
>> drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c =A0delete mod=
e 100644
>> drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>
> This series will break the build if we try to compile after applying
> only the first or the first two patches of the series since things us=
ed
> by the first patch are introduced in the last patch.
>
> Archit

Got it. I will try to reorder the sequence

--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
