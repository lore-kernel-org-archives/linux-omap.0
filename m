From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 23:40:55 +0800
Message-ID: <AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
	<AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42267 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476Ab0IGPlu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 11:41:50 -0400
In-Reply-To: <AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: venki kaps <venkiece2005@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>

2010/9/7 venki kaps <venkiece2005@gmail.com>:
> thanks for your good response.
>
> Venkii,
>
> On Tue, Sep 7, 2010 at 6:54 PM, Ming Lei <tom.leiming@gmail.com> wrot=
e:
>> 2010/9/7 venki kaps <venkiece2005@gmail.com>:
>>> Dear USB experts,
>>>
>>> =A0Is the same fix valid for omap3430 + 2.6.32 Kernel?
>>>
>>> =A0I have been facing mp3 playback idle current consumption 20mA mo=
re
>>> after booting without USB cable connected
>>> =A0but If USB cable detach and attach happen, then able to hit prop=
er
>>> values otherwise irrespective of cold/warm reset
>>> =A0the current values increases to 20mA.
>>>
>>> =A0with cable,
>>> =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
>>> =A0 =A0 =A0HSOTGUSB_STANDBY - SMART standby
>>>
>>> =A0without cable,
>>> =A0 =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
>>> =A0 =A0 =A0 =A0HSOTGUSB_STANDBY - Active
>>>
>>> =A0Even i have applied =A0patch but still the same issue.
>>
>> Are you applying the patch below?
>>
>> =A0 =A0 =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D128378686221264=
&w=3D2
>>
>> The patch(USB: otg: twl4030: fix phy initialization(v1)) above is ag=
ainst
>> 2.6.36-rc3, I don't think you can apply it directly on 2.6.32. And t=
he patch
>> is introduced to fix the problems caused by
>>
>> =A0 =A0 =A0 =A0 =A0commit 461c317705eca5cac09a360f488715927fd0a927.
>>
>> which change is committed into mainline 2.6.36-rc3.
> =A0>>> Yes, this patch i have applied.

If you applied the patch, I guess you may see __twl4030_phy_power(twl, =
0)
is called from .probe.

If called,  seems your description a little contradictory since you obs=
erved
__twl4030_phy_power(twl, 0) may hit proper values, right?

If not called, could you trace the return value of twl4030_usb_linkstat=
 in
twl4030_usb_phy_init?

thanks,

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
