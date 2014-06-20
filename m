From: Ash Charles <ash@gumstix.com>
Subject: Re: OMAP 3630 random crashes
Date: Fri, 20 Jun 2014 07:17:17 -0700
Message-ID: <CAK8F28=pF=gy10Lar35q2-s=f0TxNJFZ6XpdTFvHYankXtzH4Q@mail.gmail.com>
References: <1403254242990.39117@grundfos.com> <20140620091431.GA28884@atomide.com>
 <1403272840480.35753@grundfos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:48195 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaFTORs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2014 10:17:48 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so3491873vcb.16
        for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2014 07:17:47 -0700 (PDT)
In-Reply-To: <1403272840480.35753@grundfos.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Casper,

What is the top-side marking on the memory chip on your Overo?  There
were some random faults due to poor memory chips marked 'JW513' from
about 18 months ago.

--Ash

On Fri, Jun 20, 2014 at 7:00 AM, Casper Lyngesen Mogensen
<clmogensen@grundfos.com> wrote:
> Hi
>
> U-boot seems to set the speed to 165 Mhz
> "OMAP36XX/37XX-GP ES1.2, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz"
>
> I have a LAN9221, but tried the other timings, still same result.
>
> Also tried running the entire system from an MMC card, same result, but my test had
> to run a little longer.
>
> Found a quicker test to reproduce the error, a little C-program:
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
>
> int main(void){
>         long long var=0;
>
>         int *ptr=NULL;
>
>         int run=1;
>         while(run){
>                 ptr=malloc(sizeof(int)*1000);
>                 if(ptr==NULL){
>                         run=0;
>                 }
>                 var+=1000;
>                 printf("mallocsize = %lld\n",var*sizeof(int));
>         }
> }
>
>
> Booting from NFS, the system crashes at ~40mb allocated
> On MMC at ~60MB
>
> Med venlig hilsen/Best regards
>
> Casper Mogensen
>
> ________________________________________
> From: Tony Lindgren <tony@atomide.com>
> Sent: Friday, June 20, 2014 11:14
> To: Casper Lyngesen Mogensen
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP 3630 random crashes
>
> Hi,
>
> * Casper Lyngesen Mogensen <clmogensen@grundfos.com> [140620 01:52]:
>> Hi
>>
>> I have  custom board with a Gumstix Overo, my board is similar to a
>> Tobi board. Right now i have it running with a 3.5.0 kernel. I'm
>> trying to upgrade the kernel, and have tried several versions (3.10 ->
>> 3.15) and i seem to be hitting the same problem with all versions, i
>> get random crashes. Found a way to  trigger the crash within
>> minutes/seconds:
>>
>> # dd if=/dev/urandom of=/tmp/test.file bs=1024 count=100000
>>
>> A count > 10000 will at some point trigger the crash. The hang/crash
>> is repeatable everytime but the log is not, sometimes i do not get
>> any trace at all. I can provide more logs if necessary.  Config and
>> crash log are below..
>>
>> Have tried disabling various peripherals, such as sound, usb,
>> ethernet, wifi, bluetooth, but with no luck. Also tried different Overo
>> boards.
>>
>> Hope someone can help me/point me in the right direction
>
> I was seeing similar issues with NFSroot until commit dcf21919
> (ARM: dts: Fix GPMC timings for LAN9220). Turns out LAN9220 has
> much slower timings compared to LAN9221. So you need to check that
> you're using right timings if you have LAN9220.
>
> Also, check what rate your bootloader is setting the L3 speed.
> If it's set to 200MHz, then LAN9220 timings seem to overflow the
> GPMC registers for the calculated values and bootloader timings
> are used instead.
>
>> Starting kernel ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 3.15.0 (clmo@N66266) (gcc version 4.8.1 (crosstool-NG 1.19.0) ) #3 SMP Wed Jun 11 23:50:13 CEST 2014
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> [    0.000000] Machine model: OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi
>> [    0.000000] cma: CMA: reserved 16 MiB at 8d800000
>> [    0.000000] Memory policy: Data cache writeback
>> [    0.000000] CPU: All CPU(s) started in SVC mode.
>> [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
>> [    0.000000] PERCPU: Embedded 9 pages/cpu @cecc6000 s14080 r8192 d14592 u36864
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 60704
>> [    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/nfs nfsroot=192.168.100.1:/export/bbroot,nolock rw ip=192.168.100.7::192.168.100.1:::eth0:off mem=240M
>
> Maybe also check if your test works with NFSroot idsabled.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
