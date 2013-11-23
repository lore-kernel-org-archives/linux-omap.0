From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Fri, 22 Nov 2013 21:27:11 -0600
Message-ID: <CAKZq+rcoC5PLSVVazWcce7V7TcBM8=M2jM56bvk9HO2orKt8fg@mail.gmail.com>
References: <87hab9agjr.fsf@gmail.com>
	<CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
	<87wqk3n54l.fsf@gmail.com>
	<20131120183548.GH10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:34700 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab3KWD1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Nov 2013 22:27:11 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so1672811qeb.35
        for <linux-omap@vger.kernel.org>; Fri, 22 Nov 2013 19:27:11 -0800 (PST)
In-Reply-To: <20131120183548.GH10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

"I wonder if we also have some dependency to some earlier versions of
u-boot as u-boot now only muxes the essential pins?"
This is exactly the problem in my case. I added "#define
CONFIG_SYS_ENABLE_PADS_ALL" in u-boot/include/configs/omap4_common.h
and now there is output.

I guess the reason that the u-boot worked out-of-box for Ben but not
for me is that I missed some configurations in v3.12 kernel. I image
there is a config options that tells the kernel to take care of the
non-essential pins that used to be the responsibility of u-boot. Could
you confirm my hypothesis? And if so, could you kindly suggest what's
the name of the config option?

Thank you!

On Wed, Nov 20, 2013 at 12:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ben Gamari <bgamari.foss@gmail.com> [131119 19:07]:
>> Chao Xu <caesarxuchao@gmail.com> writes:
>>
>> > Hi,
>> >
>> > I also try to boot v3.12 on my pandaboard rev A2, but it hangs at
>> > "starting kernel". My SD card is originally loaded with a linaro 12.04
>> > ubuntu-developer image. I have tried with v3.7 and v3.8 uImage and
>> > both of them work normally, but v3.12 hangs. Is there any trick I
>> > missed? Do I need to use the new u-boot as used by Ben?
>> >
>> I've written up some of my experiences bringing up 3.12 on the
>> PandaBoard here[1]. You may find it helpful. Regardless, I would
>> definitely try upgrading u-boot.
>
> Nice investigative blogging :)
>
> Care to also update it with the other issues remaining on pandaboard?
> Sounds like we're pretty close to having things working nicely with
> mainline kernel on it, so let's just fix those issues ASAP.
>
> I'm aware of at least two issues:
>
> 1.  The WLAN not working after a soft reset, or if the interface is
>     reset with ifconfig down. This could be a typo somewhere in the
>     .dts file for the WLAN regulator or something like that.
>
> 2. Suspend and resume does not wake-up from serial console and spews
>    a bunch of warnings. The wake-up issue can be fixed with the new
>    the new interrupts-extended property to use the wake IRQs, I'll
>    try to update my patches for that today.
>
>> > And here is a separate problem with building u-boot. I cloned the
>> > upstream u-boot repository. The latest commit is
>> > c2e5e802ecb7ab668ce9911b210ed68c804b349f. Then I did:
>> > make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- omap4_panda_config
>> > make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
>> > cp MLO u-boot.img /media/boot/
>> > But when turn on my pandaboard, there is NO output from the serial
>> > console. I didn't change the other file in the boot partition. They
>> > are from linaro 12.04 ubuntu-developer image.
>> >
>> I would check that you have earlyprintk enabled (both in the kernel
>> configuration as well as on the kernel command line). Moreover, ensure
>> that the correct serial devices is selected for low-level debug output
>> (in the kernel configuration).
>
> I wonder if we also have some dependency to some earlier versions of
> u-boot as u-boot now only muxes the essential pins?
>
> Regards,
>
> Tony
>
>
>> [1] http://bgamari.github.io/posts/2013-11-17-running-modern-kernel-on-pandaboard.html
>
>



-- 
Regards,
Chao Xu
