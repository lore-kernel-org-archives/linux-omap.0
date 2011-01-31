From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as static
 and dynamic.
Date: Mon, 31 Jan 2011 19:50:16 +0530
Message-ID: <3daf21c18eb0a304c3284540a1efcb32@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-2-git-send-email-r.sricharan@ti.com> <d52d24e46279799c2019f7c297a4e627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47677 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab1AaOUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 09:20:20 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so5571185bwz.38
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 06:20:19 -0800 (PST)
In-Reply-To: <d52d24e46279799c2019f7c297a4e627@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, paul@pwsan.com

>-----Original Message-----
>From: Anand Gadiyar [mailto:gadiyar@ti.com]
>Sent: Saturday, January 29, 2011 2:19 AM
>To: Sricharan R; linux-omap@vger.kernel.org
>Cc: Santosh Shilimkar; tony@atomide.com; paul@pwsan.com
>Subject: RE: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as
>static and dynamic.
>
>sricharan wrote:
>>
>> 1) All the pads of a hwmod for the device are classified
>>    as static/dynamic. If a pad requires remuxing during
>>    the device transitions between enable/idle transitions
>>    then it is added to the dynamic list, static otherwise.
>>
>> 2) Both the static/dynamic pads of a hwmod are initialised
>>    when the device gets enabled. When the device transitions
>>    between enable/idle the dynamic pads are remuxed and
>>    static pads are skipped.
>>
>> 3) When the driver gets removed both the static and the
>>    dynamic pads are muxed to safe mode as default.
>>
>
>I haven't taken a look at the code. I do have a few
>concerns (which may really be non-issues, but I'm
>pointing them out anyway):
>
>- Not all pads have a safe mode.
>--- And why would you want statically muxed pads to be remuxed
>into safe mode anyway? What is the advantage of such a change,
>as against leaving them in a functional mode?
There is an option to mux the pads to different mode
than safe mode when the driver is removed. Those which
do not specify are put to safe mode.

With safe mode, the pins becomes a input with no functional
interface connected to it. This avoids the either omap
or outside device seeing any false logic from the pin.

>
>- Many signals are muxed on more than one pad.
>- Many peripherals need pads to be configured in different
>  mux modes depending on the way a board is wired up.
>
>
>With this, moving pad info to hwmod databases does not sound
>useful to me. Maybe I do not understand the need for this
>change, in place of what we have today.
>

The structure for containing the mux data is part of hwmod
for the device.

The hwmod is not static and it is dynamically
populated during the device init, with the
data being passed from board files if it is different across
boards.

The device state transitions (enable/idle) passes the through
the hwmod layer, which takes caring of muxing the pins
right way for each transition.

This helps to mux correctly the
1) shared pins
2) Initialsing the pads
3) Remux only pads that require change during enable/idle
   transitions.
4) Put the pads to safemode( default) when the driver is
   unplugged.


>- Anand
