From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Mon, 8 Nov 2010 14:49:41 -0500
Message-ID: <AANLkTi=oTeqzSpAq6CXKTbmWCQ99HZcOx=o0QVK6-UoO@mail.gmail.com>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	<1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BF2D67E@dbde02.ent.ti.com>
	<1289218763.3297.47.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48914 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab0KHTtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 14:49:41 -0500
Received: by pwj1 with SMTP id 1so39529pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 11:49:41 -0800 (PST)
In-Reply-To: <1289218763.3297.47.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "ext Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

On Mon, Nov 8, 2010 at 7:19 AM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Fri, 2010-11-05 at 22:17 +0100, ext Taneja, Archit wrote:
>> Hi,
>>
>> linux-omap-owner@vger.kernel.org wrote:
>> > Introduce struct panel config data in panel.h, which will be
>> > used to match the right panel configurations in generic DPI
>> > panel driver and other future dsi panel drivers.
>> >
>> > Still keep sharp_ls_panel, since the sharp_ls_panel driver
>> > contains blacklight control driver code which will be moved
>> > out later. Then we can use generic DPI driver for sharp_ls_panel.
>> >
>> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> > ---
>> > =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 10 +++-
>> > =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 19 +++++--
>> > =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 19 +++++--
>> > =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 22 +++++---
>> > =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 10 +++-
>> > =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 | =A0=
 10 +++-
>> > =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 10 +++-
>> > =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0| =A0=
 19 +++++--
>> > =A0arch/arm/plat-omap/include/plat/nokia-dsi-panel.h | =A0 31 ----=
-------
>> > =A0arch/arm/plat-omap/include/plat/panel.h =A0 =A0 =A0 =A0 =A0 | =A0=
 57
>> > =A0+++++++++++++++++++++ drivers/video/omap2/displays/panel-taal.c=
 =A0 =A0 =A0 =A0 |
>> > =A026 ++++------ 11 files changed, 148 insertions(+), 85 deletions=
(-) =A0delete
>> > mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
>> > =A0create mode 100644 arch/arm/plat-omap/include/plat/panel.h
>>
>> I am not totally sure about the need of removal of nokia-dsi-panel.h
>> and the addition of a generic panel.h.
>>
>> I guess the reason why nokia-dsi-panel.h was introduced (and others =
that
>> will be introduced in future) was to easily represent panel-specific=
 data
>> across different boards that use the same panel.
>
> Right. Don't touch panel-taal.c or nokia-dsi-panel.h, they are not
> related to this DPI panel stuff.
>
>> For example, if there is a new panel which for some reson uses 2 pin=
s, one
>> for switching off and one for switching on the panel, then it would =
make sense
>> to introduce a structure for this panel having members on_gpio and o=
ff_gpio, this
>> struct could then be passed and accessed through dssdev->data in the=
 panel's probe
>> giving us the option to have different gpio numbers for different bo=
ards but finally
>> being accessed in the same way by the driver.
>>
>> So, there isn't a need to generalize this struct and the correspondi=
ng header file
>> for all panels and make it available for all board files.
>>
>> As far as the dummy panels are concerned, since the "name" is the on=
ly criteria to
>> differentiate the panel, I think passing the name to the data member=
 of omap_dss_device
>> should itself be enough for the generic dpi driver to handle things.
>
> I think it's a bit confusing to just put a string to the void *data
> member, but fortunately we don't need to ponder about that: the gener=
ic
> DPI panel should be told about reset_gpio, max_backlight_level,
> platform_enable/disable and set/get_backlight, which need to be passe=
d
> in a struct. So a header and a struct is needed for this generic DPI
> driver.
>

Yeah, so we just put  a name field in a struct such as
generic-dpi-panel-data in generic-dpi-panel.h
And our driver file will be panel-generic-dpi.c?

Thanks,
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
