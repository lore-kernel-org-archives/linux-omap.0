From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce dummy panel driver
Date: Tue, 2 Nov 2010 15:12:55 -0400
Message-ID: <AANLkTi=5QUqvp-=UugoxCTAu=602m528sWgfyD3tNdxr@mail.gmail.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<4CD0421F.5070200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52543 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0KBTM4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 15:12:56 -0400
Received: by gxk23 with SMTP id 23so4334611gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 12:12:55 -0700 (PDT)
In-Reply-To: <4CD0421F.5070200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 2, 2010 at 12:53 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> On 11/2/2010 9:43 PM, Bryan Wu wrote:
>>
>> There are 4 duplicated panel driver sin DSS2 display driver. They ar=
e
>> similar
>> and dummy panel driver can support all them with specific panel
>> configuration.
>> And new panel driver can be easily supported by adding panel
>> configurations
>> into dummy panel driver.
>>
>> This patchset introduces dummy panel driver, remove 3 panel drivers =
and
>> enable
>> dummy panel driver in board files. And it is based on 2.6.37-rc1.
>>
>> Building with omap2plus_defconfig is successful.
>>
>> Keep sharp_ls_panel, since it contains blacklight control code which=
 will
>> be
>> moved out later.
>>
>> Bryan Wu (3):
>> =A0 OMAP: DSS2: Add dummy panel display driver
>> =A0 OMAP: DSS2: remove dummy panel driver duplicated panel drivers
>> =A0 OMAP: use dummy panel driver in board files
>>
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A06 +-
>> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A06 +-
>> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +-
>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +-
>> =A0arch/arm/plat-omap/include/plat/display.h =A0 =A0 =A0 =A0 =A0| =A0=
 28 +-
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 22 +-
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
>> =A0drivers/video/omap2/displays/panel-dummy.c =A0 =A0 =A0 =A0 | =A01=
95 +++++++
>> =A0drivers/video/omap2/displays/panel-dummy.h =A0 =A0 =A0 =A0 | =A01=
19 +++++
>> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0174=
 -------
>> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0165 -----=
-
>> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0535
>> --------------------
>> =A016 files changed, 364 insertions(+), 914 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/displays/panel-dummy.c
>> =A0create mode 100644 drivers/video/omap2/displays/panel-dummy.h
>> =A0delete mode 100644 drivers/video/omap2/displays/panel-generic.c
>> =A0delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043=
t1dg01.c
>> =A0delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mt=
ea1.c
>>
>
> Why can't panel-generic.c be reused instead of a new panel-dummy.c?
>
> Sounds like what you're trying to do is to get a generic panel driver=
; so
> shouldn't it at least be called generic instead of dummy.
>

I assume panel-generic is for some DVI output connection, so I picked
up dummy. But yeah, I do prefer to panel-generic driver and maybe
change the name "generic-panel" to "dvi".

-Bryan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
