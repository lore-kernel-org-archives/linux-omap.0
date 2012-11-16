From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc5
Date: Fri, 16 Nov 2012 14:35:39 +0300
Message-ID: <CAK0ocyD5rXGjAisjYVxt6YUqpLQSFmC0GSA6iADFz6tTg7S4_w@mail.gmail.com>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
	<50A26FC6.4070201@gmail.com>
	<20121116074754.GA25218@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38163 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2KPLfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 06:35:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1808637pad.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 03:35:40 -0800 (PST)
In-Reply-To: <20121116074754.GA25218@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Nov 16, 2012 at 11:47 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Nov 13, 2012 at 08:05:26PM +0400, Igor Mazanov wrote:
>> Paul Walmsley wrote:
>> >
>> >* AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>> >  - May be fixed now, pending retest:
>> >    - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>> >  - Not yet part of the automated test suite
>> >  * May be due to an old U-boot with FDT support problems used here?
>> >    Pending local investigation and re-test
>>
>> I have the same result with omap2plus_defconfig and kernel 3.7.0-rc5. I dumped
>> the kernel log buffer via JTAG and can send this log if it could be useful.
>
> I just got my BeagleBone replaced via RMA, and so I could try a fresh
> build of 3.7.0-rc5 with omap2plus_defconfig. It works just fine for me.
>
> A few details:
>
> U-Boot SPL 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
> U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
>
>  setenv ipaddr 192.168.0.77
>  setenv serverip 192.168.0.12
>  setenv netmask 255.255.255.0
>  setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=16384 earlyprintk=serial
>  tftp 81000000 uImage
>  tftp 82000000 beaglebone-initrd.gz
>  tftp 80000000 am335x-bone.dtb
>  bootm 81000000 - 80000000
>
> So I guess just using a recent u-boot will fix whatever issues you are
> seeing.

I have a quite new u-boot, exactly U-Boot 2012.10-02160-gc4d22de (Oct
24 2012 - 18:25:04).

The problem was in some inconsistency with clock names during changes
in the AM33xx clock subsystem, see

http://marc.info/?l=linux-omap&m=135299082705058&w=2

For now Beaglebone boots with current git kernel.

Regards,
Igor.

>
> Thanks,
> Richard
>
>
