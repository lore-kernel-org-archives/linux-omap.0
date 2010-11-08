From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Mon, 8 Nov 2010 14:43:13 -0500
Message-ID: <AANLkTin7XOPyupobBehHc+hdJbGVJWFPRPYf03BwuDcZ@mail.gmail.com>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	<1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
	<1289219163.3297.54.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39448 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0KHTnQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 14:43:16 -0500
Received: by ewy7 with SMTP id 7so3079734ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:43:15 -0800 (PST)
In-Reply-To: <1289219163.3297.54.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

On Mon, Nov 8, 2010 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Fri, 2010-11-05 at 20:43 +0100, ext Bryan Wu wrote:
>> Introduce struct panel config data in panel.h, which will be used to=
 match
>> the right panel configurations in generic DPI panel driver and other=
 future
>> dsi panel drivers.
>>
>> Still keep sharp_ls_panel, since the sharp_ls_panel driver contains =
blacklight
>> control driver code which will be moved out later. Then we can use g=
eneric DPI
>> driver for sharp_ls_panel.
>
> As mentioned in the other mail, don't touch panel-taal or
> nokia-dsi-panel.h. They are not related to this change.
>

Got it. I just found nokia-dsi-panel.h is some kind of confusing and
tried to unify them. Obviously I should not touch them in this
patchset. I will remove them in next version.

> The panel.h file should be spesific for the generic panel driver, so
> name the .c and .h files similarly. (yes, panel-taal.c and
> nokia-dsi-panel.h are not good examples for this, but I have a patch
> fixing it, I just haven't had time to push it forward =3D).
>

OK, I got it. Actually I did that, but wanna unify the
nokia-dis-panel.h somehow. I will change back.

> And remember that the kernel should compile and work after each
> individual patch in the patch set. In this patch you set the boards t=
o
> use dvi_panel driver, but there is no dvi_panel driver yet.
>

Got it. I will fold some patches together.

> Also some comments inline.
>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 10 +++-
>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 19 +++++--
>> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 19 +++++--
>> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 22 +++++---
>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 10 +++-
>> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 | =A0=
 10 +++-
>> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 10 +++-
>> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0| =A0=
 19 +++++--
>> =A0arch/arm/plat-omap/include/plat/nokia-dsi-panel.h | =A0 31 ------=
-----
>> =A0arch/arm/plat-omap/include/plat/panel.h =A0 =A0 =A0 =A0 =A0 | =A0=
 57 +++++++++++++++++++++
>> =A0drivers/video/omap2/displays/panel-taal.c =A0 =A0 =A0 =A0 | =A0 2=
6 ++++------
>> =A011 files changed, 148 insertions(+), 85 deletions(-)
>> =A0delete mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-pane=
l.h
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/panel.h
>>
>> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-oma=
p2/board-3430sdp.c
>> index 4e3742c..859b4e5 100644
>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>> @@ -38,6 +38,7 @@
>> =A0#include <plat/dma.h>
>> =A0#include <plat/gpmc.h>
>> =A0#include <plat/display.h>
>> +#include <plat/panel.h>
>>
>> =A0#include <plat/gpmc-smc91x.h>
>>
>> @@ -270,11 +271,14 @@ static struct omap_dss_device sdp3430_lcd_devi=
ce =3D {
>> =A0 =A0 =A0 =A0 .platform_disable =A0 =A0 =A0 =3D sdp3430_panel_disa=
ble_lcd,
>> =A0};
>>
>> +static struct panel_data dvi_panel =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "generic",
>> +};
>> +
>> =A0static struct omap_dss_device sdp3430_dvi_device =3D {
>> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "dvi",
>> - =A0 =A0 =A0 .driver_name =A0 =A0 =A0 =A0 =A0 =A0=3D "generic_panel=
",
>> - =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP_DIS=
PLAY_TYPE_DPI,
>> - =A0 =A0 =A0 .phy.dpi.data_lines =A0 =A0 =3D 24,
>
> Why do you remove type and datalines configuration? You do this for t=
he
> other panels also.
>

I found this is common in all the generic dpi panel, but the value
depends on the specific panel. I move this to the panel configuration
data and will set this value in panel-dpi driver. Do you think need I
keep them here? Actually I found all of them are 24 for generic one.
16 or 18 for others.

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
