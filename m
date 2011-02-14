From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: Pandaboard boot problem
Date: Mon, 14 Feb 2011 15:01:30 +0100
Message-ID: <AANLkTinJPPDH6bWQ-Q14k6vgx8iGQvUmPFbrWqQX1JJ5@mail.gmail.com>
References: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
	<20110204015301.GQ3322@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40782 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab1BNOBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 09:01:31 -0500
Received: by qwa26 with SMTP id 26so3116851qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 06:01:30 -0800 (PST)
In-Reply-To: <20110204015301.GQ3322@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Feb 4, 2011 at 2:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Jean Pihet <jean.pihet@newoldbits.com> [110201 10:29]:
>> Hi!
>>
>> I have a problem with a Pandaboard hanging a few seconds after the
>> kernel boot, likely due to the watchdog firing.
>> The kernel boots fine, mounts the root FS (initramfs) and the shell
>> prompt works OK.
>>
>> Board details: Panda A1, OMAP4430 ES2
>> Kernel details: l-o tree master, using the omap2plus_defconfig +
>> initramfs. WDOG is enabled in the config.
>>
>> From some investigation I can see that PM runtime disables the wdog
>> (omap_device_idle). Is that intented?
>>
>> Any thought?
>
> Does it power down after few tens of seconds?
Yes

> If so, I've seen this same issue few times after having my panda
> powered off for a while, for example over the weekend.
>
> What I've noticed is that leaving just u-boot prompt running
> for a few minutes cures the problem somehow.. After that the
> kernel will boot just fine.
Unfortunately that is not helping.
I am still investigating. For the moment the pandaboard is pretty useless ;(

>
> Regards,
>
> Tony

Regards,
Jean
