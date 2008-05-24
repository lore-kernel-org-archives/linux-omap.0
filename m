From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap osk and mistral touchscreen-ads7846
Date: Sat, 24 May 2008 09:11:47 +0530
Message-ID: <a1d91fa0805232041l3f1346fei415a6bc0889ef7f7@mail.gmail.com>
References: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com>
	 <c656a4d20805212316jdf9eb72ma62059f8cfc49e82@mail.gmail.com>
	 <a1d91fa0805220023i35666796k14773fbd1224d8c0@mail.gmail.com>
	 <c656a4d20805220204g3db4fba3l43d0f3eea9d219c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:19657 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758934AbYEXDlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2008 23:41:50 -0400
Received: by ti-out-0910.google.com with SMTP id b6so805917tic.23
        for <linux-omap@vger.kernel.org>; Fri, 23 May 2008 20:41:48 -0700 (PDT)
In-Reply-To: <c656a4d20805220204g3db4fba3l43d0f3eea9d219c2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, linux-omap@vger.kernel.org

Hi,

fortunately looks like am getting interrupts when i touch the
touchscreen. i can say this because the spi interrupts were
incremented when i touched. here is the output:

# cat /proc/interrupts
           CPU0
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
160:       2997        GPIO  eth0
164:          0        GPIO  spi2.0

# cat /proc/interrupts
           CPU0
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
160:       3030        GPIO  eth0
164:          5        GPIO  spi2.0

we can observe that it has increased from 0 to 5.

do i need some executable files in my filesystem to calibrate it?

thanx and regards,
Shareef

On Thu, May 22, 2008 at 2:34 PM, arun c <arun.edarath@gmail.com> wrote:
> On Thu, May 22, 2008 at 12:53 PM, mohammed shareef <mdshareef@gmail.com> wrote:
>> hi arun/all,
>>
>> when i do cat for interrupts i get:
>>
>> # cat /proc/interrupts
>>           CPU0
>>  19:          0         MPU  DMA
>>  20:          0         MPU  DMA
>>  21:          0         MPU  DMA
>>  22:          0         MPU  DMA
>>  23:          0         MPU  DMA
>>  24:          0         MPU  DMA
>>  25:       9834         MPU  LCD DMA
>>  31:          3         MPU  lcdc
>>  33:          1         MPU  omap-keypad
>>  36:        313         MPU  i2c_omap
>>  46:        148         MPU  serial
>>  54:      19893         MPU  32KHz timer
>>  78:          0         MPU  peripheral wakeup
>>  85:          0         MPU  DMA
>>  86:          0         MPU  DMA
>>  87:          0         MPU  DMA
>>  88:          0         MPU  DMA
>>  89:          0         MPU  DMA
>>  90:          0         MPU  DMA
>>  91:          0         MPU  DMA
>>  92:          0         MPU  DMA
>>  93:          0         MPU  DMA
>>  94:          0         MPU  DMA
>> 160:       1409        GPIO  eth0
>> 164:         24        GPIO  spi2.0
>> 178:          0        GPIO  serial wakeup
>> 197:          0        GPIO  serial wakeup
>> 209:      19773        GPIO  serial wakeup
>> 222:          0        GPIO  omap_cf
>> 353:          0       MPUIO  tps65010
>> 354:          0       MPUIO  mistral_wakeup
>> Err:          0
>>
>> looks like am not getting the touchscreen interrupts.
>>
>> i havent even calibrated my touchscreen. but i have enabled the SPI
>> interface and the ADS7846 touchscreen in the kernel. could you tell me
>> how to calibrate it or make it work? i guess i am missing out on some
>> files like i have nothing like ts_calibrate in my filesystem.
>>
> See this link, i think it can help you.
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-March/003174.html
>
> Regards,
> Arun C
>
