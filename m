From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap osk and mistral touchscreen-ads7846
Date: Tue, 3 Jun 2008 16:17:12 +0530
Message-ID: <a1d91fa0806030347k3c0e55afufe7fa78e0c741c4e@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C470213D794@dlee13.ent.ti.com>
	 <a1d91fa0805252150p334c8347s4c40db2f3e1d37ed@mail.gmail.com>
	 <9C23CDD79DA20A479D4615857B2E2C47039D9B23@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:41446 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbYFCKrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 06:47:16 -0400
Received: by ti-out-0910.google.com with SMTP id b6so499277tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 03:47:13 -0700 (PDT)
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47039D9B23@dlee13.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Spits, Tiemen" <tts@ti.com>, omap <linux-omap@vger.kernel.org>

Dear all,

finally i was able to calibrate the mistral touchscreen. the problem
seemed to be in the filesystem. probably i had compiled the tslib
using wrong options.

here is what should be done:

from the kernel side:

enable spi and ads7847 touchscreen.

from filesystem side:

take a tslib tar ball..

sh autogen.sh

Edit ./configure and remove the line no. 20623   "#define malloc rpl_malloc"

./configure --host=arm-linux --target=arm-linux
--prefix=/data/rootfs2.6/ --bindir=/data/rootfs2.6/bin
--sbindir=/data/rootfs2.6/sbin --libexecdir=/data/rootfs2.6/libexec
--datadir=/data/rootfs2.6/share --sysconfdir=/data/rootfs2.6/etc
--sharedstatedir=/data/rootfs2.6/com
--localstatedir=/data/rootfs2.6/var --libdir=/data/rootfs2.6/lib
--includedir=/data/rootfs2.6/include --infodir=/data/rootfs2.6/info
--mandir=/data/rootfs2.6/man

make

make install



now go to osk console:

# export TSLIB_TSDEVICE=/dev/input/event1
# export TSLIB_CONFFILE=/etc/ts.conf
# export TSLIB_PLUGINDIR=/lib/ts
# export TSLIB_FBDEVICE=/dev/fb0
# ts_calibrate


nfs: server 10.114.5.48 not responding, still trying
nfs: server 10.114.5.48 OK
xres = 240, yres = 320
Took 9 samples...
Top left : X = 2997 Y = 3109
Took 10 samples...
Top right : X = 1093 Y = 3204
Took 8 samples...
Bot right : X = 1468 Y = 1105
Took 9 samples...
Bot left : X = 3289 Y = 1036
Took 8 samples...
Center : X = 2283 Y = 2048
313.809875 -0.075604 -0.012148
393.598877 -0.004780 -0.106150
Calibration constants: 20565844 -4954 -796 25794896 -313 -6956 65536

 Hope this post helps people who are in trouble in future.

    thanx and regards,
    Shareef

On Fri, May 30, 2008 at 8:55 PM, Spits, Tiemen <tts@ti.com> wrote:
> Shareef,
> Setup your environment variables as follows:
>
> export TSLIB_TSDEVICE=/dev/input/event1
> export TSLIB_CONFFILE=/etc/ts.conf
> export TSLIB_PLUGINDIR=/lib/ts
>
> export TSLIB_CALIBFILE=/etc/pointercal
> export TSLIB_CONSOLEDEVICE=none
> export TSLIB_FBDEVICE=/dev/fb0
>
> before you run ts-calibrate. The fb0 designates the frame buffer to use
> for output to the screen. What do you see on the screen when you run
> ts-calibrate? Should be a number of little crosses for you to touch.
> When done, the offsets used by the ts driver should be in
> /etc/pointercal
>
> Cheers
> Tiemen T. Spits
> Western Area Senior Engineer
> Americas Sales and Marketing
> Semiconductor Group
> Office: +1 (858) 638-4340
> Mobile: +1 (214) 535-9160
>
>> -----Original Message-----
>> From: mohammed shareef [mailto:mdshareef@gmail.com]
>> Sent: Sunday, May 25, 2008 9:50 PM
>> To: Spits, Tiemen
>> Subject: Re: omap osk and mistral touchscreen-ads7846
>>
>> Dear spits,
>>
>> u told me that some ts related files were missing in my file system.
>> could u please get them for me? meanwhile i attempted the following:
>>
>> i cross-compiled the tslib for my filesystem as mentioned in:
>> http://linux.omap.com/pipermail/linux-omap-open-source/2005-
>> March/003174.html
>>
>> and i have put the executables in the filesystem.
>> when i do
>> /usr/X11/bin/ts_calibrate
>>
>> i dont get any "calibration request" on the LCD.
>> But when i do:
>>
>> cat /dev/input/event1
>>
>> i could see that i get stuff on my host computer when i touch the
>> screen. which means that my toucscreen is associated with event1. i
>> have even set up the proper environment variables.
>>
>> doing:
>> cat /proc/interrupts
>> also shows that spi interrupts incrementing on touching the screen.
>>
>> but running
>> ts_calibrate doesnt show anything on the LCD.
>>
>> could you tell me if am missing something?
>>
>> thank you,
>> warm regards,
>> Shareef
>>
>> On Thu, May 22, 2008 at 9:15 AM, Spits, Tiemen <tts@ti.com> wrote:
>> > Looks like te ts-cal app is not in your filesystem. I will see if I
> can
>> find
>> > it
>> > Cheers
>> >
>> > Tiemen Spits
>> > West region senior engineer
>> > America Sales and Marketing
>> > +1 214 535-9160
>> >
>> > ----- Original Message -----
>> > From: mohammed shareef <mdshareef@gmail.com>
>> > To: Spits, Tiemen
>> > Sent: Wed May 21 17:50:05 2008
>> > Subject: Re: omap osk and mistral touchscreen-ads7846
>> >
>> > Spits,
>> > when i did the above this is what i got:
>> >
>> > # export TSLIB_TSDEVICE=/dev/input/event1
>> > # export TSLIB_FBDEVICE=/dev/fb0
>> > # ts_calibrate
>> > -sh: ts_calibrate: not found
>> >
>> > where have i gone wrong?
>> >
>> > thanx and regards,
>> > Shareef
>> >
>> > On Thu, May 22, 2008 at 4:16 AM, Spits, Tiemen <tts@ti.com> wrote:
>> >> Shareef
>> >> You should be able to do the calibration as follows:
>> >>
>> >> linux:~# export TSLIB_TSDEVICE=/dev/input/event1
>> >> linux:~# export TSLIB_FBDEVICE=/dev/fb0
>> >> linux:~# ts_calibrate
>> >>
>> >> Then follow the onscreen prompts to calibrate. Once you have done
> this,
>> >> it should be stored in your filesystem from here on out.
>> >>
>> >> Cheers
>> >> Tiemen T. Spits
>> >> Western Area Senior Engineer
>> >> Americas Sales and Marketing
>> >> Semiconductor Group
>> >>
>> >>
>> >>> -----Original Message-----
>> >>> From: linux-omap-open-source-bounces@linux.omap.com
>> >> [mailto:linux-omap-
>> >>> open-source-bounces@linux.omap.com] On Behalf Of mohammed shareef
>> >>> Sent: Wednesday, May 21, 2008 3:40 PM
>> >>> To: omap; linux-omap-open-source@linux.omap.com
>> >>> Subject: omap osk and mistral touchscreen-ads7846
>> >>>
>> >>> Hello,
>> >>>
>> >>> i have enabled the SPI and ADS7846 drivers during kernel (2.6.18)
>> >>> compilation. i could see in the kernel boot log that they are also
>> >>> initialized.
>> >>>
>> >>>
>> >>
>>
> ////////////////////////////////////////////////////////////////////////
>> >>> ads7846 spi2.0: touchscreen + hwmon, irq 164
>> >>> input: ADS784x Touchscreen as /class/input/input1
>> >>>
>> >>
>>
> ////////////////////////////////////////////////////////////////////////
>> >> /
>> >>> but could someone tell me what should i do next to calibrate my
>> >>> touchscreen?
>> >>>
>> >>> i even tried compiling tslib and added the executables to the file
>> >>> system. But when i run the executable
>> >>> /usr/X11/bin/ts_calibrate
>> >>>
>> >>> i see no response on the LCD. the system just hangs.'
>> >>>
>> >>> thanx and regards,
>> >>> Shareef
>> >>> _______________________________________________
>> >>> Linux-omap-open-source mailing list
>> >>> Linux-omap-open-source@linux.omap.com
>> >>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>> >>
>> >
>
