From: Andreas Naumann <dev@andin.de>
Subject: Re: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Thu, 19 Dec 2013 15:06:55 +0100
Message-ID: <52B2FD7F.2070604@andin.de>
References: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>	<20131218153545.GA1593@saruman.home> <CANOLnOOP8bh2OuajnCE7P-VpSvH_u7-wk5bHuWEfXhALHCBk4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dd5612.kasserver.com ([85.13.130.143]:41816 "EHLO
	dd5612.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab3LSOGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 09:06:50 -0500
In-Reply-To: <CANOLnOOP8bh2OuajnCE7P-VpSvH_u7-wk5bHuWEfXhALHCBk4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, Felipe Balbi <balbi@ti.com>
Cc: anaumann@ultratronik.de, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Am 19.12.2013 00:40, schrieb Grazvydas Ignotas:
> On Wed, Dec 18, 2013 at 5:35 PM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> On Tue, Dec 17, 2013 at 05:48:33PM +0100, anaumann@ultratronik.de wr=
ote:
>>> From: Andreas Naumann <anaumann@ultratronik.de>
>>>
>>> This is a hard to reproduce problem which leads to non-functional
>>> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
>>> e25bec160158abe86c276d7d206264afc3646281, which introduces save/res=
tore
>>> of OTG_INTERFSEL over suspend.
>>> Since the resume function is also called early in driver init, it u=
ses a
>>> non-initialized value (which is 0 and a non-supported setting in DM=
37xx
>>> for INTERFSEL). Shortly after the correct value is set. Apparently =
this
>>> works most time, but not always.
>>
>> yeah, but the problem is not on the glue layer. The bug is omap_devi=
ce
>> and pm_runtime not agreeing on device's state. I suppose there was a=
 fix
>> for that recently in linux-omap@vger mailing list.
>
> You mean this: http://marc.info/?t=3D138444882600003&r=3D1&w=3D2 ?
>
> This looks like a different issue during suspend, this problem is at
> startup. Both musb_core and omap2430.c expect hardware to be disabled
> on startup, and that works as expected. The problem is on first
> pm_runtime_get_sync(), which results in first runtime_resume() call,
> musb_core checks for first resume and doesn't load yet-unset context
> in that case, however glue does and breaks things. We have this
> problem since 3.2.

I'm a bit short on time at the moment, but shall I have a go on another=
=20
version of the patch with the init-variable as atomic_t?

Andreas

>
> Gra=C5=BEvydas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
