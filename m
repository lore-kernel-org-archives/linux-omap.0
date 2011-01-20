From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to kernel-2.6.37
Date: Thu, 20 Jan 2011 14:58:30 +0800
Message-ID: <AANLkTinNe76Wq-w78m7tMDY-gfMu7zt6jT7zs_KGL-iG@mail.gmail.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
	<20110119110607.GA30211@legolas.emea.dhcp.ti.com>
	<AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
	<20110120063321.GA10094@m-desktop>
	<AANLkTi=9yAGvOLyBBHkeNL4-HJgVL2FKqKuW1tpqDoMu@mail.gmail.com>
	<20110120065029.GH2389@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41510 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1ATG6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 01:58:31 -0500
Received: by qwa26 with SMTP id 26so281909qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:58:31 -0800 (PST)
In-Reply-To: <20110120065029.GH2389@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

On Thu, Jan 20, 2011 at 2:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Jan 20, 2011 at 02:46:47PM +0800, Bob Liu wrote:
>> Yeah, I also think it's file system issue. I added major and minor
>> number to omap-serial driver, it fix the problem temporary.
>>
>> > No need to edit /etc/inittab with above fs since ttyO2 is mapped to
>> > console device file under /dev
>>
>> Do you know how to do this map during build a fs?
>> Thanks.
>
> which FS do you use ? I use a debootstrap generally :-p
>

I use buildroot to generate an initramfs :-)
Of course I made some changes.

If using 8250 serial driver, my fs works well,it can enter console correctly.
But using omap-serial driver, it can't.

I think there maybe some problem about the ttyO2 node in my fs.
So I add it to my fs by hand, so i need to know it's major & minor number,
so I added major &minor number to omap-serial driver.
It seems working okay now.

-- 
Regards,
--Bob
