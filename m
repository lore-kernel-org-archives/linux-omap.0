From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to kernel-2.6.37
Date: Thu, 20 Jan 2011 14:44:11 +0800
Message-ID: <AANLkTim5fx-1oZ+KU3CHbCY=cYheyP-5iC+jZd+jnAML@mail.gmail.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
	<20110119110607.GA30211@legolas.emea.dhcp.ti.com>
	<AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
	<20110120063021.GE2389@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50566 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab1ATGoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 01:44:14 -0500
Received: by qyj19 with SMTP id 19so1560784qyj.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:44:13 -0800 (PST)
In-Reply-To: <20110120063021.GE2389@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

On Thu, Jan 20, 2011 at 2:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Jan 20, 2011 at 01:32:24PM +0800, Bob Liu wrote:
>> On Wed, Jan 19, 2011 at 7:06 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > Hi,
>> >
>> > On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
>> >> Any ideas?
>> >
>> > s/console=ttyS2,115200n8/console=ttyO2,115200n8/
>> >
>> > on your CMDLINE.
>> >
>>
>> Yeah, that work! Thanks!
>>
>> But my system still can't enter shell, I have changed /etc/inittab
>> from "tty0::respawn:/sbin/getty -L ttyS2 115200 vt102" to
>> "tty0::respawn:/sbin/getty -L ttyO2 115200 vt102", and also have added
>> ttyO2 to /etc/securetty.
>
> Add this line to /etc/inittab:
>
> 1:2345:respawn:/sbin/getty 115200 ttyO2
>

Hi, balbi

I tried it ,this can't work.
always show: can't open /dev/1: No such file or directory.

Now I fixed this problem by add major and minor number to struct
serial_omap_reg in omap-serial.c. The same major minor number as
8250.c.
It can enter console now.

Thanks
-- 
Regards,
--Bob
