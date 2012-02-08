From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP34xx
Date: Wed, 08 Feb 2012 09:01:24 -0800
Message-ID: <87k43xfee3.fsf@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	<20120204190109.GL20333@atomide.com>
	<20120204203453.GD17309@n2100.arm.linux.org.uk>
	<20120205012556.GG1426@atomide.com>
	<20120205125904.GB11372@n2100.arm.linux.org.uk>
	<20120205172925.GS20333@atomide.com>
	<20120205175809.GF17309@n2100.arm.linux.org.uk>
	<20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com>
	<87y5sei1qz.fsf@ti.com>
	<CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:60870 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754680Ab2BHRBc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 12:01:32 -0500
Received: by daed14 with SMTP id d14so927102dae.33
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:01:29 -0800 (PST)
In-Reply-To: <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 8 Feb 2012 12:46:18 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, gregkh@linuxfoundation.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Kevin Hilman <khilman@ti.com> writes:
>>
>>> This one is indeed strange. =C2=A0I have not seen this on the 34xx =
devices
>>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
>>
>> OK, I've reproduced this on v3.3-rc2.
>>
>> The reason I wasn't seeing this is because I'm using the fixes Paul =
has
>> already posted that fix this problem:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://marc.info/?l=3Dlinux-arm-kernel&m=3D=
132754676814391&w=3D2
>>
>> Kevin
>
> But it looks like these are now queued for 3.4 in tty tree?

I believe they were targettted for 3.3-rc.

Paul, Greg, can you confirm?

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
