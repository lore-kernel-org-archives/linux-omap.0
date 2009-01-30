From: Sriram V <vshrirama@gmail.com>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 19:46:20 +0530
Message-ID: <8bf247760901300616k53722fb0if55e2d07c71df10c@mail.gmail.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	 <87zlhbqtrv.fsf@deeprootsystems.com>
	 <87skn3qq6x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7277 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbZA3OQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 09:16:21 -0500
Received: by wf-out-1314.google.com with SMTP id 27so506665wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 06:16:20 -0800 (PST)
In-Reply-To: <87skn3qq6x.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Reid <ppeter.reid@gmail.com>, Koen Kooi <koen@beagleboard.org>, linux-omap@vger.kernel.org

Hi,
  I have done some testing on a custom board. it uses uart2
  I also see serial hang issues here. I have a minimum defconfig with
 only i2c enabled. no cpuidle/cpufreq.

  This is what i try to do -

  # echo -n mem > /sys/power/state

  I wait for a min and try to wakeup - It works.

  If i wait a little longer before waking it up say, 3 or 4 minutes.
It does not wakeup.

  I tried the same disabling clocks when idle The result is the same.

   # echo -n 1 > /sys/power/sleep_while_idle
   # echo -n 1 > /sys/power/clocks_off_while_idle
   # echo -n mem > /sys/power/state

   With the above,  i see all domains hitting retention.
   I have tried both keypads and uart activity as my wakeup
   sources.
   Am trying to debug this. why the serial is dead if
   there is no activity for a longer time.


Regards,
sriram









On Wed, Jan 28, 2009 at 11:16 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Peter Reid <ppeter.reid@gmail.com> writes:
>>
>>> Hi Kevin,
>>>    I get hangs after boot on beagle with latest PM tree i have quite a
>>> few scripts that run on boot.
>>>
>>>    have you seen this before?
>>
>> I have not, but I believe Koen has see something similar.  I've mainly
>> been testing just a minimal rootfs and a minimal set of drivers on
>> Beagle so I can hit full-chip off in idle.
>>
>> It would help if you could desribe your setup in more detail.  What
>> kernel config are you using, what rootfs are you using?  Does it hang
>> in the same spot every time?  If so, what is going on when it hangs?
>> Have you written anything to any of the /sys/power/* files?
>>
>
> Just a thought, do you still see these problems when using the CPUfreq
> performance governor instead of the ondemand governor?
>
> It could be pointing to some bugs in the switching of operating points.
>
> Kevin
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
