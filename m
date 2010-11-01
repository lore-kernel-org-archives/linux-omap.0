From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/2] OMAP: DSS2: Add new display panel
Date: Mon, 1 Nov 2010 12:45:06 -0400
Message-ID: <AANLkTi=fV58ApDqUE21YMK0_vhLdPbPr7F7YpYh0-2Vc@mail.gmail.com>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
	<1288620930.5614.16.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39145 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab0KAQpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 12:45:07 -0400
Received: by pxi15 with SMTP id 15so529094pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Nov 2010 09:45:06 -0700 (PDT)
In-Reply-To: <1288620930.5614.16.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hvaibhav@ti.com" <hvaibhav@ti.com>, "notasas@gmail.com" <notasas@gmail.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 1, 2010 at 10:15 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Thu, 2010-10-28 at 16:43 +0200, ext Enric Balletbo i Serra wrote:
>> Hi,
>>
>> Next patches adds support for the two new LCD panel display used
>> on IGEP boards.
>>
>> =A0Powertip PH480272T LCD 4.3inch (480x242) display
>> =A0Seiko 70WVW1TZ3 LCD 7.0inch WVGA (800x480) display
>>
>> Please, consider adding in next merge window.
>>
>> Cheers,
>>
>> Enric Balletbo i Serra (2):
>> =A0 OMAP: DSS2: Add Powertip PH480272T display panel
>> =A0 OMAP: DSS2: Add Seiko 70WVW1TZ3 display panel
>
> These both are "dummy" panels, and the driver is basically a copy of =
the
> existing drivers. I don't think I will merge any more of these, sorry=
=2E
>
> What we need is a common driver for all these dummy panels, and the
> driver would contain configurations for all the supported panels. The
> board file would pass the name of the panel used in that board to the
> driver, and the driver would use the configurations for that panel.
>

It looks like that we just need one file name displays.c to do those
generic things and pass the configuration from board files to this
driver, such as timing or other things.

> This has been discussed a few times in l-o list, but I haven't found
> time to implement it and nobody else has done it either.
>

I'm quite happy to do this, thanks,

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
