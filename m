From: venki kaps <venkiece2005@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 21:18:59 +0530
Message-ID: <AANLkTinkhY-y6Qv6HJnGbggksdEmULgQ9DTOrNmu1tLp@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
	<AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
	<AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

Venkii,

On Tue, Sep 7, 2010 at 9:10 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> 2010/9/7 venki kaps <venkiece2005@gmail.com>:
>> thanks for your good response.
>>
>> Venkii,
>>
>> On Tue, Sep 7, 2010 at 6:54 PM, Ming Lei <tom.leiming@gmail.com> wro=
te:
>>> 2010/9/7 venki kaps <venkiece2005@gmail.com>:
>>>> Dear USB experts,
>>>>
>>>> =A0Is the same fix valid for omap3430 + 2.6.32 Kernel?
>>>>
>>>> =A0I have been facing mp3 playback idle current consumption 20mA m=
ore
>>>> after booting without USB cable connected
>>>> =A0but If USB cable detach and attach happen, then able to hit pro=
per
>>>> values otherwise irrespective of cold/warm reset
>>>> =A0the current values increases to 20mA.
>>>>
>>>> =A0with cable,
>>>> =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
>>>> =A0 =A0 =A0HSOTGUSB_STANDBY - SMART standby
>>>>
>>>> =A0without cable,
>>>> =A0 =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idl=
e
>>>> =A0 =A0 =A0 =A0HSOTGUSB_STANDBY - Active
>>>>
>>>> =A0Even i have applied =A0patch but still the same issue.
>>>
>>> Are you applying the patch below?
>>>
>>> =A0 =A0 =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D12837868622126=
4&w=3D2
>>>
>>> The patch(USB: otg: twl4030: fix phy initialization(v1)) above is a=
gainst
>>> 2.6.36-rc3, I don't think you can apply it directly on 2.6.32. And =
the patch
>>> is introduced to fix the problems caused by
>>>
>>> =A0 =A0 =A0 =A0 =A0commit 461c317705eca5cac09a360f488715927fd0a927.
>>>
>>> which change is committed into mainline 2.6.36-rc3.
>> =A0>>> Yes, this patch i have applied.
>
> If you applied the patch, I guess you may see __twl4030_phy_power(twl=
, 0)
> is called from .probe.
>
> If called, =A0seems your description a little contradictory since you=
 observed
> __twl4030_phy_power(twl, 0) may hit proper values, right?

  Yes, __twl4030_phy_power(twl, 0) -  the current values are getting
proper with or without cable.
>
> If not called, could you trace the return value of twl4030_usb_linkst=
at in
> twl4030_usb_phy_init?
ok, i can do that and update.
>
> thanks,
>
> --
> Lei Ming
>
