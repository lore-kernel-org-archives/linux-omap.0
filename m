From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp
 LS037V7DW01 LCD panel
Date: Mon, 6 Dec 2010 13:06:36 +0800
Message-ID: <AANLkTikMzXs=Rp8Wgm5PRD-VEGn=O9ii+by_27hsP-ar@mail.gmail.com>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com> <1291217575.10133.165.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39094 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0LFFG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 00:06:58 -0500
Received: by qyk11 with SMTP id 11so3186465qyk.19
        for <linux-omap@vger.kernel.org>; Sun, 05 Dec 2010 21:06:57 -0800 (PST)
In-Reply-To: <1291217575.10133.165.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

On Wed, Dec 1, 2010 at 11:32 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-30 at 20:07 +0800, ext Bryan Wu wrote:
>> After instroducing generic DPI panel driver for OMAP DSS2 system, we=
 need to
>> split out backlight driver from Sharp LS037V7DW01 panel driver befor=
e we move
>> to the generic DPI panel driver.
>>
>> This patchset introcuded backlight driver and cleanup the old Sharp =
LS037V7DW01
>> panel driver related code.
>>
>> It's built on mainline 2.6.37-rc4
>>
>> Bryan Wu (3):
>> =A0 Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
>> =A0 OMAP: move Sharp LS LCD panel device to generic DPI panel driver=
 and new backlight driver
>> =A0 OMAP: DSS2: remove Sharp LS037V7DW01 panel driver
>
> I don't think this is quite the right direction.
>
> All the backlight driver does is call a function in the board file. I=
t's
> not really a "sharp ls backlight driver", but rather generic one. I'm
> not even sure if it needs the dssdev pointer.
>

Since dssdev struct contains backlight releated fields, I passed that
into the driver. It can be replaced by a backlight related platform
data struct. Then we can remove those backlight related fields from
dssdev struct.

> This kind of backlight is, in a sense, totally separate component fro=
m
> the panel itself. All they have in common is that they are packaged i=
n
> the same physical display module, and they usually share the same
> connector.
>
> I have seen three kinds of backlights on OMAP devices:
> - on/off GPIO (like on 3430 SDP)
It seems like that we need a gpio_bl.c driver for this kind of usage.

> - PWM based (zoom seems to have this)

I failed to find any PWM or Backlight code in ZOOM boards source file.
Is that possible to us pwm_bl.c driver which is used by pxa?

> - Panel controlled (Taal-panel. Also PWM based, but OMAP doesn't see
> that)
>
Yeah, I don't plan to reform this driver at this time.

> The first two could (should?) be totally separate backlights from the
> panel itself. For those, a generic backlight driver could perhaps wor=
k.
> The third one needs to be quite tied to the panel driver, and I'm not
> sure how easy it would be to have a separate driver for that.
>

OK, I totally understand you concern now. How about a GPIO based
backlight driver for the first 2 cases.

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
