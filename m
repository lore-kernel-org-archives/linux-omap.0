From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Wed, 06 Jan 2010 22:04:58 -0400
Message-ID: <4B45414A.9010805@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <20100106224520.GA29239@gandalf> <4B45167F.8020605@gmail.com> <201001070233.36120.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:47962 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab0AGCFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 21:05:06 -0500
Received: by ywh6 with SMTP id 6so18055485ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 18:05:04 -0800 (PST)
In-Reply-To: <201001070233.36120.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Luke-Jr <luke@dashjr.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Siarhei Siamashka wrote:
> On Thursday 07 January 2010, Francisco Alecrim wrote:
>> Felipe Balbi wrote:
>>> On Wed, Jan 06, 2010 at 06:11:10PM -0400, Francisco Alecrim wrote:
>>>> Thanks! Now it goes to rootfs and continue the boot, but device
>>>> power-off after 10-20 seconds. There is no error message to help. :(
>>> watchdog ?
>>>
>>> how about disabling watchdog with flasher ??
>> I'm using the flags (no-omap-wd,no-retu-wd,no-lifeguard-reset)
>> recommended by Kalle[1]. This's not the problem. :(
> 
> If I read these recommendations correctly, they tell to *clear* these R&D
> flags. So probably it's better not to have them enabled.
> 
> Moreover, based on the following post, watchdog is hardwired and just can't be
> disabled by any software methods:
> http://lists.maemo.org/pipermail/maemo-developers/2007-June/010650.html
> 
> Your powerdown problem is exactly caused by a watchdog. Earlier a solution was 
> to have a script which would kick watchdog periodically. But right now it is
> kicked automatically in the kernel if CONFIG_CBUS_RETU_WDT option is enabled.
> You also need to enable CONFIG_WATCHDOG, CONFIG_CBUS and probably some other
> stuff.
Thanks for this explanation. I works fine with the flags you indicate. :)
> 
> This all also means that CBUS is critical for correct N8x0 operation and these
> devices simply can't work without it at all.

Well, if it's critical to n8x0 operation then it should be in
n8x0_defconfig.
> 
> Hope this information helps.
> 
Thanks,
Alecrim.
