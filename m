From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap osk and mistral touchscreen-ads7846
Date: Thu, 22 May 2008 12:53:11 +0530
Message-ID: <a1d91fa0805220023i35666796k14773fbd1224d8c0@mail.gmail.com>
References: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com>
	 <c656a4d20805212316jdf9eb72ma62059f8cfc49e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:47492 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757644AbYEVHXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 03:23:13 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1731342tic.23
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2008 00:23:11 -0700 (PDT)
In-Reply-To: <c656a4d20805212316jdf9eb72ma62059f8cfc49e82@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

hi arun/all,

when i do cat for interrupts i get:

# cat /proc/interrupts
           CPU0
 19:          0         MPU  DMA
 20:          0         MPU  DMA
 21:          0         MPU  DMA
 22:          0         MPU  DMA
 23:          0         MPU  DMA
 24:          0         MPU  DMA
 25:       9834         MPU  LCD DMA
 31:          3         MPU  lcdc
 33:          1         MPU  omap-keypad
 36:        313         MPU  i2c_omap
 46:        148         MPU  serial
 54:      19893         MPU  32KHz timer
 78:          0         MPU  peripheral wakeup
 85:          0         MPU  DMA
 86:          0         MPU  DMA
 87:          0         MPU  DMA
 88:          0         MPU  DMA
 89:          0         MPU  DMA
 90:          0         MPU  DMA
 91:          0         MPU  DMA
 92:          0         MPU  DMA
 93:          0         MPU  DMA
 94:          0         MPU  DMA
160:       1409        GPIO  eth0
164:         24        GPIO  spi2.0
178:          0        GPIO  serial wakeup
197:          0        GPIO  serial wakeup
209:      19773        GPIO  serial wakeup
222:          0        GPIO  omap_cf
353:          0       MPUIO  tps65010
354:          0       MPUIO  mistral_wakeup
Err:          0

looks like am not getting the touchscreen interrupts.

i havent even calibrated my touchscreen. but i have enabled the SPI
interface and the ADS7846 touchscreen in the kernel. could you tell me
how to calibrate it or make it work? i guess i am missing out on some
files like i have nothing like ts_calibrate in my filesystem.

thank you,
regards,
Shareef

On Thu, May 22, 2008 at 11:46 AM, arun c
<arunedarath@mistralsolutions.com> wrote:
> On Thu, May 22, 2008 at 4:10 AM, mohammed shareef <mdshareef@gmail.com> wrote:
>> Hello,
>>
>> i have enabled the SPI and ADS7846 drivers during kernel (2.6.18)
>> compilation. i could see in the kernel boot log that they are also
>> initialized.
>>
>> ////////////////////////////////////////////////////////////////////////
>> ads7846 spi2.0: touchscreen + hwmon, irq 164
>> input: ADS784x Touchscreen as /class/input/input1
>> /////////////////////////////////////////////////////////////////////////
>> but could someone tell me what should i do next to calibrate my touchscreen?
>>
>> i even tried compiling tslib and added the executables to the file
>> system. But when i run the executable
>> /usr/X11/bin/ts_calibrate
>>
>> i see no response on the LCD. the system just hangs.'
>>
>> thanx and regards,
>> Shareef
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>
> Hi Shareef,
>
> Touch the screen several times and do a cat /proc/interrupts
> to check whether the interrupts are coming.
>
> Or you can enable event device debugging in menuconfig
> and see the debug messages.
>
> Regards,
> Arun C
>
