From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 26 Nov 2010 15:11:57 +0200
Message-ID: <AANLkTi=roWN7EpBy1+9HwntaaHd6Nh0rA9cScxfpRkOC@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
	<1290589057.13243.22.camel@tubuntu>
	<19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
	<20101124163100.GB5681@nokia.com>
	<19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
	<yw1xeia81nts.fsf@unicorn.mansr.com>
	<19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
	<20101126125539.GG8094@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34324 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0KZNL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 08:11:59 -0500
In-Reply-To: <20101126125539.GG8094@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@nokia.com>
Cc: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, Nov 26, 2010 at 2:55 PM, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala=
@nokia.com> wrote:
> On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote=
:
>> With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO =
(breaking standard applications).
>
> Applications using the standard fbdev API won't work with manual upda=
te
> displays anyway. You need omapfb specific code to handle it so having
> another small difference is not a big deal.
>
> In DirectFB the that's trivial since there's already a simple omap
> gfxdriver where you could override the default flip functionality wit=
h
> WAITFORGO based stuff.
>
> Or, as I said, you could add another standard ioctl and fix up usersp=
ace
> to use it where appropriate and if the kernel driver supports it.

That sounds more appealing to me: there's no point in having
omap-specific interfaces if they can be standard.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
