From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to kernel-2.6.37
Date: Thu, 20 Jan 2011 14:46:47 +0800
Message-ID: <AANLkTi=9yAGvOLyBBHkeNL4-HJgVL2FKqKuW1tpqDoMu@mail.gmail.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
	<20110119110607.GA30211@legolas.emea.dhcp.ti.com>
	<AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
	<20110120063321.GA10094@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46220 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab1ATGqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 01:46:48 -0500
Received: by qwa26 with SMTP id 26so274063qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:46:47 -0800 (PST)
In-Reply-To: <20110120063321.GA10094@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

On Thu, Jan 20, 2011 at 2:33 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
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
> Looks like file system issue. You can try with below fs:
> http://code.google.com/p/beagleboard/downloads/detail?name=ALSA-FS.tar.gz&can=2&q=
>

Yeah, I also think it's file system issue. I added major and minor
number to omap-serial driver, it fix the problem temporary.

> No need to edit /etc/inittab with above fs since ttyO2 is mapped to
> console device file under /dev

Do you know how to do this map during build a fs?
Thanks.

-- 
Regards,
--Bob
