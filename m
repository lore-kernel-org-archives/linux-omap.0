From: Sung Hee Park <shpark7@stanford.edu>
Subject: Re: omap3evm does not boot after 2.6.38-rc1
Date: Thu, 17 Feb 2011 14:01:36 -0800
Message-ID: <AANLkTik3PovrJ09ewK8S-sLLD+6uNvPzAuRPo9krUM=b@mail.gmail.com>
References: <AANLkTi=GHh-UTfTHgDJKW8HfCbTbe6zqitAL0FeyXtW8@mail.gmail.com>
	<20110217015454.GN20795@atomide.com>
	<0fc7120064d33b37334afa28bf4ee760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54144 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223Ab1BQWBj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 17:01:39 -0500
Received: by wwi17 with SMTP id 17so6045594wwi.1
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 14:01:38 -0800 (PST)
In-Reply-To: <0fc7120064d33b37334afa28bf4ee760@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Thanks for your suggestion. After enabling the early printk option, I
figured out that sched_clock_poll() was causing the problem, which can
be fixed with the following patch.

http://www.spinics.net/lists/arm-kernel/msg111325.html

Sung Hee


On Wed, Feb 16, 2011 at 8:12 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> Tony Lindgren wrote:
>> * Sung Hee Park <shpark7@stanford.edu> [110216 14:18]:
>> > Hi all,
>> >
>> > I'm having a problem with booting the linux kernel on my omap3evm.=
 It
>> > halts after saying "Uncompressing Linux... done, booting the kerne=
l."
>> > on boot. I had a similar problem with 2.6.37, but after changing t=
he
>> > name of the serial port devices from /dev/ttyS* to /dev/ttyO*, it
>> > worked. Does anyone experiencing this problem again with 2.6.38
>> > kernels? Please let me know if you have any idea what might have g=
one
>> > wrong.
>>
>> If you have 2.6.38-rc1 booting, maybe try running git bisect on it
>> to find out where it breaks?
>>
>> Tony
>
> Enable CONFIG_EARLY_PRINTK, and add the word earlyprintk to your boot=
args.
> This should help get some prints on the debug UART which might help
> debug this.
>
> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
