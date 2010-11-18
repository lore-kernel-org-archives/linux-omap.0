From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
 (try #8)
Date: Thu, 18 Nov 2010 10:14:03 +0800
Message-ID: <AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290003526.26444.30.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58464 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab0KRCOE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 21:14:04 -0500
Received: by qwf7 with SMTP id 7so28443qwf.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 18:14:03 -0800 (PST)
In-Reply-To: <1290003526.26444.30.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-11-17 at 21:34 +0800, ext Bryan Wu wrote:
>> There are 4 duplicated DPI panel drivers in DSS2 display driver. The=
y are
>> similar and a generic DPI panel driver can support all them with spe=
cific
>> panel configuration. And new DPI panel driver can be easily supporte=
d
>> by adding panel configurations into generic panel DPI driver.
>>
>> This patchset introduces a generic panel DPI driver, remove 3 panel =
drivers and enable
>> generic panel DPI driver in board files. And it is based on 2.6.37-r=
c2.
>>
>> Building with omap2plus_defconfig is successful.
>>
>> Keep sharp_ls_panel, since it contains blacklight control code which=
 will be
>> moved out later.
>>
>> Bryan Wu (3):
>> =A0 OMAP: DSS2: Add generic DPI panel display driver
>> =A0 OMAP: use generic DPI panel driver in board files
>> =A0 OMAP: DSS2: remove generic DPI panel driver duplicated panel dri=
vers
>
> Thanks, looks good. This is now applied to my tree.
>

Thanks a lot for making this happen, -:))

> Are you also interested in solving the backlight issue? =3D)

Yeah, can I start with
drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to move
the blacklight code to drivers/video/blacklight/ and let sharp_ls to
use panel-generic-dpi.c driver.

-Bryan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
