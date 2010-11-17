From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Wed, 17 Nov 2010 14:31:13 +0800
Message-ID: <AANLkTikcF1OnJjrUmame2HUjTadZLrgZwpam6RuGuKos@mail.gmail.com>
References: <1289881031-21354-1-git-send-email-bryan.wu@canonical.com>
	<1289881031-21354-2-git-send-email-bryan.wu@canonical.com>
	<1289920866.2668.138.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61101 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323Ab0KQGbO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 01:31:14 -0500
Received: by qyk12 with SMTP id 12so5988624qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 22:31:13 -0800 (PST)
In-Reply-To: <1289920866.2668.138.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>

On Tue, Nov 16, 2010 at 11:21 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-16 at 05:17 +0100, ext Bryan Wu wrote:
>> Generic DPI panel driver includes the driver and 4 similar panel con=
figurations. It
>> will match the panel name which is passed from platform data and set=
up the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4 duplicated pane=
l display
>> drivers. In the future, it is simple for us just add new panel confi=
guration
>> date in panel-generic-dpi.c to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0.../arm/plat-omap/include/plat/panel-generic-dpi.h | =A0 37 +++

[snip]

>> +
>> +static power_on_delay =3D 0;
>> +
>> +static power_off_delay =3D 0;
>
> This is not right. There may be multiple panels in a single board, an=
d
> these would be shared by both of the panels.
>
> What you need to do is have a struct, which contains pointer to the
> panel configuration used with that particular dssdev, and set the str=
uct
> with dev_set_drvdata().
>
> Check panel-taal.c for an example. There's struct taal_data, which
> contains also quite a bit other data, but also a pointer to the panel
> config.
>

Exactly, I just fixed it and sent the updated patchset.

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
