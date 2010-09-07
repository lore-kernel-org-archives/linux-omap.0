From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 21:24:44 +0800
Message-ID: <AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40168 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab0IGNdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 09:33:14 -0400
In-Reply-To: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: venki kaps <venkiece2005@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>

2010/9/7 venki kaps <venkiece2005@gmail.com>:
> Dear USB experts,
>
> =A0Is the same fix valid for omap3430 + 2.6.32 Kernel?
>
> =A0I have been facing mp3 playback idle current consumption 20mA more
> after booting without USB cable connected
> =A0but If USB cable detach and attach happen, then able to hit proper
> values otherwise irrespective of cold/warm reset
> =A0the current values increases to 20mA.
>
> =A0with cable,
> =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
> =A0 =A0 =A0HSOTGUSB_STANDBY - SMART standby
>
> =A0without cable,
> =A0 =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
> =A0 =A0 =A0 =A0HSOTGUSB_STANDBY - Active
>
> =A0Even i have applied =A0patch but still the same issue.

Are you applying the patch below?

         http://marc.info/?l=3Dlinux-omap&m=3D128378686221264&w=3D2

The patch(USB: otg: twl4030: fix phy initialization(v1)) above is again=
st
2.6.36-rc3, I don't think you can apply it directly on 2.6.32. And the =
patch
is introduced to fix the problems caused by

          commit 461c317705eca5cac09a360f488715927fd0a927.

which change is committed into mainline 2.6.36-rc3.

>
> =A0If i use __twl4030_phy_power(twl, 0) at the end of USB LDO initial=
ization,

If you apply this patch against 2.6.36-rc3, you will find
__twl4030_phy_power(twl, 0)  is always called from .probe
if you don't connect musb with PC via cable when powering on.

> =A0then able to hit proper values but USB ADC values are getting in c=
orrect
> =A0with Travel adapter (Charger power supply) which means temperature
> =A0shows 84 instead of 26~30 degrees.
>
> =A0Queries,
> =A0-----------
> =A0 - Is Errata 1.164 fix : OTG idle will work on 3430?

No such errata found in ti wetsite, could you give a link?

> =A0 - USBOTG_SUSPEND is enabled in Kernel 32, will it give any impact=
?

Kernel does not have USBOTG_SUSPEND config option. Do you
mean USB_SUSPEND? If so, it is nothing to do with your issue since
it is only valid for host driver. Also for your case, musb works at
b-idle state.

> =A0 - Is there anything missed from Power management idle path (or)
> =A0 =A0USB OTG controller/Transreceiver driver part?

Maybe with transreceiver part, musb doesn't support runtime pm now.

>
> =A0Could you please provide the best approach to solve my issue?

Sorry, this patch is not for your issue, as said above.


--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
