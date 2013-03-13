From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: Excessive ethernet interrupts on AM335x board
Date: Wed, 13 Mar 2013 10:11:36 +0000
Message-ID: <514050D8.2@mimc.co.uk>
References: <513F4B58.1000204@mimc.co.uk> <85569979-6B4C-46D0-BDC8-B70785375D64@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85569979-6B4C-46D0-BDC8-B70785375D64@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 13/03/13 08:44, Koen Kooi wrote:
> 
> Op 12 mrt. 2013, om 16:35 heeft Mark Jackson <mpfj-list@mimc.co.uk> het volgende geschreven:
> 
>> I'm just fighting an issue with ethernet on our custom AM335x board:-
>>
>> # uname -a
>> Linux nanobone 3.9.0-rc2-00113-gd60f039 #139 Tue Mar 12 15:14:01 GMT 2013 armv7l GNU/Linux
>>
>> Every now and then, the whole unit slows to a crawl.  The only indication of any problem is:-
>>
>> (a) the serial tty port becomes much less responsive
>> (b) normal ping times jump from 1ms to >10sec (sometimes >20sec !!)
>> (c) the ethernet interrupt count rockets (see below)
> 
> You probably have PG2.x silicon, have a look at this patch: https://github.com/beagleboard/kernel/blob/3.8/patches/net/0003-cpsw-Fix-interrupt-storm-among-other-things.patch

No, it's 1.0 ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.9.0-rc2-00113-gd60f039-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #141 Wed Mar 13 09:14:03 GMT 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: Newflow AM335x NanoBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES1.0 (neon )

The patch certainly didn't fix things (and possibly made things worse i.e. my nfs root kept dropping off even more).

> I saw some patches going into net-next today that might address this in a different way, but I haven't tried 3.9rc on an am335x yet.

I might track those down and test them.

Cheers
Mark J.
