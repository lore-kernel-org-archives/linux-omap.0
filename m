From: James <angweiyang@gmail.com>
Subject: Re: Simple GPMC device driver with basic User application
Date: Tue, 8 Nov 2011 10:07:31 +0800
Message-ID: <CAOy7-nO5mWvnz5AHNzdeGb=K9cSeEn07QiVSTG36VkuNRxPqPg@mail.gmail.com>
References: <CAOy7-nNxRgB21JSFcWvD4T3AwDDuh9MjBeB+8nFiwX-Cv+13Mw@mail.gmail.com>
	<CAOy7-nMMyk3kMc9aShigxuvdB5O3S+B319SCR36kzM0ZTmSQ6w@mail.gmail.com>
	<20111103192532.GX31337@atomide.com>
	<4EB3D0FE.2080400@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39790 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1KHCHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 21:07:32 -0500
Received: by wwi36 with SMTP id 36so29488wwi.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 18:07:31 -0800 (PST)
In-Reply-To: <4EB3D0FE.2080400@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Philip,

On Fri, Nov 4, 2011 at 7:48 PM, Philip Balister <philip@balister.org> wrote:
> On 11/03/2011 03:25 PM, Tony Lindgren wrote:
>> * James <angweiyang@gmail.com> [111023 18:13]:
>>> Dear all,
>>>
>>> I'm learning embedded linux development and need help on my task.
>>>
>>> I'm trying to communicate with a FPGA via the GPMC bus on my Overo FE
>>> board and need assistance with writing a simple device driver & test
>>> application that uses the GPMC bus to read & write a WORD size data
>>> and also a BLOCK of WORD data to the FPGA.
>>>
>>> The FPGA-OMAP3530 will be use synchronous read/write over the 16-bit
>>> datapath and CS 6.
>>> The GPMC bus is shared with an Ethernet chip and NAND chip as per
>>> Gumstix COM + TOBI/Chestnut design and these standard devices must
>>> still work as per norm.
>>>
>>> I've been searching via GMANE for similar questions but some are
>>> pointing to non-existence archives.
>>>
>>> I believe I have to develop a kernel device driver to register the
>>> FPGA and from which will expose a device node for the test
>>> application.
>>> or is there a generic GPMC driver that does it?
>>>
>>> Can someone share with me similar layout and code so that I can base
>>> my learning from a starting point?
>>>
>>> Many thanks in adv.
>>
>> Please take a look at the various arch/arm/mach-omap2/gpmc-*.c files.
>> The biggest pain is to get the timings right.
>
> Also take a look at:
>
> https://github.com/balister/linux-omap-philip/commits/e100-2.6.38-2
>
> Philip
>

I've been reading the codes from your e100-2.6.38-2 repo as suggested
by your earlier replies to me in Gumstix Mailing List. (^^,)

In usrp1_e_init() inside board-overo.c, GPMC_CS_CONFIG7 for both CS4
and CS6 are both written with 0x00.

I couldn't understand the background/why behind this line of code as
the Use-case in the TRM writes the base address of the device to it.

Do you have some timing diagram or documents that explains the data
flow / interactions / protocol between the FPGA and Overo as reference
to the codes?

Many many thanks in adv.

-- 
Regards,
James
