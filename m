From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Thu, 22 May 2008 03:46:37 +0530
Message-ID: <a1d91fa0805211516y2651ce64u1930681831871f64@mail.gmail.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com>
	 <20080521154010.GY23002@atomide.com>
	 <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
	 <20080521174426.GC23002@atomide.com>
	 <db841a1287fea2504e17c787c8e25940@felipebalbi.com>
	 <20080521204822.GD23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:55881 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335AbYEUWQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 18:16:39 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1676266tic.23
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2008 15:16:37 -0700 (PDT)
In-Reply-To: <20080521204822.GD23002@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

hi,

i have changed the line in omap_osk.c to:

static struct omap_uart_config osk_uart_config __initdata = {
      .enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
};

And all the three UARTs are enabled now as i can see in the kernel boot-log:

serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 47) is a ST16654
serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 15) is a ST16654

A node called ttyS0 is already there which is linked to uart0.

when i type:

ls -l /dev/ttyS0
crw-rw-rw-    1 root     root       4,  64 Aug  8  2004
\0x1b[1;35m/dev/ttyS0\0x1b[0m
# ls -l /dev/ttyS1
-rw-r--r--    1 root     root           16 May 21  2008
\0x1b[0;0m/dev/ttyS1\0x1b[0m

i have a question on the above output. the major and minor number for
ttyS0 are 4, 64 but fot ttyS1 i dont find a major number. what does
this indicate?

thanx for all the help.

regards,
Shareef


On Thu, May 22, 2008 at 2:18 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <me@felipebalbi.com> [080521 12:37]:
>>
>>
>> On Wed, 21 May 2008 10:44:28 -0700, Tony Lindgren <tony@atomide.com> wrote:
>> > * mohammed shareef <mdshareef@gmail.com> [080521 10:12]:
>> >> i see the following lines in the omap-osk.c file regarding the uarts:
>> >>
>> >> static struct omap_uart_config osk_uart_config __initdata = {
>> >>    .enabled_uarts = (1 << 0),
>> >> };
>> >>
>> >>
>> >> what does it mean? i want all my uarts (1,2,3) enabled. how do i have
>> >> to modify the above line?
>> >
>> > How about try .enabled_uarts = 3
>>
>> this would enable only uarts 1 and 2, right?
>> maybe it's enough :-p
>
> Oh yeh, that's true :)
>
> Tony
>
