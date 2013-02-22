From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: AM335x mpurate + bogomips
Date: Fri, 22 Feb 2013 08:49:20 -0600
Message-ID: <51278570.7020300@gmail.com>
References: <51264CFF.8050200@mimc.co.uk> <CA+T6QPkOE1pS3YL4WNpT3-LJq2zjy9mU1iB7FTX+TNYL6aao8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:47938 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab3BVOtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Feb 2013 09:49:25 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so391531dak.2
        for <linux-omap@vger.kernel.org>; Fri, 22 Feb 2013 06:49:24 -0800 (PST)
In-Reply-To: <CA+T6QPkOE1pS3YL4WNpT3-LJq2zjy9mU1iB7FTX+TNYL6aao8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/22/2013 02:03 AM, Jason Kridner wrote:
> On Thu, Feb 21, 2013 at 11:36 AM, Mark Jackson <mpfj-list@mimc.co.uk> wrote:
>> Before I dig any deeper, can anyone tell me if the bootarg "mpurate" is meant to
>> be supported for AM335x SoCs ?
>>
>> I've tried it on our custom board using 3v8, but no joy.
>>
>> The boot log shows:-
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 3.8.0-03059-g621553c-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #113 SMP Thu Feb 21 16:29:48 GMT 2013
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: Newflow NanoBone
>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>> [    0.000000] CPU: All CPU(s) started in SVC mode.
>> [    0.000000] AM335X ES1.0 (neon )
>> ...
>> [    0.000000] Kernel command line: console=ttyO0,115200n8 mpurate=720 root=/dev/mmcblk0p2 ro rootfstype=ext2 rootwait
>> ...
>> [    0.001119] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
>
> I don't think mpurate does anything on AM335x, though I could be
> wrong---just that I've not heard of anyone using it for any purpose.
>
> The BogoMIPS values don't seem to be very useful. I'm not sure of
> their purpose, but the hopefully useful information I can offer you is
> that if you are running a kernel supporting dynamic frequency scaling
> on AM335x, the number tends to be lower.
>
>>
>> I have seen other boot logs outputs [1] from other people where they are getting nearly double that.
>>
>> Looking at omap2xxx_clk_arch_init(), only ompa24xx devices are supported.
>>
>> Am I missing something obvious (like it's not yet supported !!) ?
>
> Use the cpufreq tools to determine and set the frequency.

Cant we just drop mpurate?

The initial trigger was to be able to boot at a known frequency - 
bootloaders typically do that. having to deal with mpurate means that we 
have to deal with it for *all* SoCs - which means we have to support 
frequency and voltage "forced setting", including other fringe stuff 
like abb, avs etc..

for example: just doing a clock setting to 1GHz is not an good idea if 
bootloader booted at 300MHz without being able to do everything right 
*if* it is right for the SoC.


I agree with Jason here, if we wanted to boot up kernel at a higher 
frequency - do it in the bootloader.
if your bootloader is not controlled or "too ancient to be modified", do 
it with cpufreq userspace utils.

at least the bootlogic will remain in the "at least predictable boot 
order" of initcalls and subsystem bringup sequences without having to 
deal with "exception overrides" like mpurate, which dont always work 100%.

---
Regards,
Nishanth Menon
