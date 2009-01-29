From: Peter Reid <ppeter.reid@gmail.com>
Subject: Re: Beagle PM hangs
Date: Thu, 29 Jan 2009 22:50:25 +0530
Message-ID: <345163910901290920j2fa02b20p566118fa2ae61b39@mail.gmail.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	 <87zlhbqtrv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:14607 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZA2RU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 12:20:27 -0500
Received: by yw-out-2324.google.com with SMTP id 9so11331ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 09:20:26 -0800 (PST)
In-Reply-To: <87zlhbqtrv.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Koen Kooi <koen@beagleboard.org>, linux-omap@vger.kernel.org

Hi Kevin,

On Wed, Jan 28, 2009 at 9:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Peter Reid <ppeter.reid@gmail.com> writes:
>
>> Hi Kevin,
>>    I get hangs after boot on beagle with latest PM tree i have quite a
>> few scripts that run on boot.
>>
>>    have you seen this before?
>
> I have not, but I believe Koen has see something similar.  I've mainly
> been testing just a minimal rootfs and a minimal set of drivers on
> Beagle so I can hit full-chip off in idle.

   I have a default omap3_beagle_defconfig with cpuidle, cpufreq
   enabled.   It hangs after running the /etc boot scripts. The behaviour is
   random. Have seen this working randomly before.
   yet to debug this.


  Regards,
   reid.


>
> It would help if you could desribe your setup in more detail.  What
> kernel config are you using, what rootfs are you using?  Does it hang
> in the same spot every time?  If so, what is going on when it hangs?
> Have you written anything to any of the /sys/power/* files?
>
> Kevin
>
