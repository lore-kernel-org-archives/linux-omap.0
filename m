From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [regression] Re: [PATCH 3/7] mfd: twl4030-irq: drop the kthread
Date: Wed, 07 Dec 2011 15:59:47 +0200
Message-ID: <4EDF7153.7090306@bitmer.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com> <1309427470-605-4-git-send-email-balbi@ti.com> <CAMP44s3hFyAK+1W6eU30RNn3=cPDRGKXW+E+sDoWNrNhU0ZpPA@mail.gmail.com> <20111207065106.GE32368@legolas.emea.dhcp.ti.com> <CAMP44s0psqeMEh8vgYSfV=MAqSOJ6+EpWndXpc89qfGHMX_f=w@mail.gmail.com> <20111207133937.GX32368@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111207133937.GX32368@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On 12/07/2011 03:39 PM, Felipe Balbi wrote:
>> I'll try to flash a system to NAND, since I can't seem to just get the
>> MMC to work when the cover is open and the device is connected to the
>> jig to see if I can see something from serial console.
>>
>> You don't have any idea about what to try?
>
> you could cut the back cover so that it just fits the device on the jig
> (I did that to an old cover), then it works just fine :-)
>
You could also go without breaking the back cover by putting a magnet on 
top the hal sensor (like tape a piece from a fridge magnet). See here 
the place:

http://talk.maemo.org/showthread.php?p=1008775

Another option is to to set .gpio_cd = -EINVAL for external mmc in 
arch/arm/mach-omap2/board-rx51-peripherals.c.

-- 
Jarkko
