From: John Sarman <johnsarman@gmail.com>
Subject: Re: TI OMAP 3503 GPIO signal I/O standard for interfacing with FPGA
Date: Fri, 14 Aug 2009 16:12:45 -0400
Message-ID: <bb2708720908141312h55cf4466m411be898ebafb5ce@mail.gmail.com>
References: <BD5F061C-76EC-40EF-93D6-5C64860EBEA7@mac.com>
	 <bb2708720908120554m33caeb32v4d13da69d1e94e7d@mail.gmail.com>
	 <3E9F21C0-53FC-4673-BE6B-BD1DC9B8D3EC@mac.com>
	 <bb2708720908130614p6ded4627o848631cfb0d3eaa4@mail.gmail.com>
	 <A7754699-2C29-4524-B85B-396EB1F63E16@mac.com>
	 <bb2708720908140550g349cc340kb3d436d6b634fe1e@mail.gmail.com>
	 <4A85B788.4040305@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:65233 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbZHNUMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 16:12:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so1477129and.1
        for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 13:12:45 -0700 (PDT)
In-Reply-To: <4A85B788.4040305@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Aug 14, 2009 at 3:14 PM, Philip Balister<philip@balister.org> w=
rote:
> John Sarman wrote:
>>
>> On Thu, Aug 13, 2009 at 9:29 AM, Elvis Dowson<elvis.dowson@mac.com> =
wrote:
>>>
>>> Hi John,
>>>
>>> On Aug 13, 2009, at 5:14 PM, John Sarman wrote:
>>>
>>>>
>>>> <snip from omap 35xx page>
>>>> =A0General Purpose Memory Controller (GPMC)
>>>>
>>>> =A0* 16-bit Wide Multiplexed Address/Data Bus
>>>> =A0* Up to 8 Chip Select Pins With 128M-Byte Address Space per Chi=
p Select
>>>> Pin
>>>> =A0* Glueless Interface to NOR Flash, NAND Flash (With ECC Hamming
>>>> Code Calculation), SRAM and Pseudo-SRAM
>>>> =A0* Flexible Asynchronous Protocol Control for Interface to Custo=
m
>>>> Logic (FPGA, CPLD, ASICs, etc.)
>>>> =A0* Nonmultiplexed Address/Data Mode (Limited 2K-Byte Address Spa=
ce)
>>>> </snip from omap 35xx page>
>>>
>>> Thanks for the info, I've read that section on the GPMC. I'm going =
to
>>> attempt this in stages. First I'll implement a simple protocol betw=
een
>>> the
>>> OMAP and the FPGA, e.g. use GPIOs to signal read and write operatio=
ns,
>>> and
>>> the serial UART0 to transfer data to a memory location for the FPGA=
 to
>>> process and return the result.
>>>
>>> Since the TI OMAP uses 1.8v signalling, I can directly interface it=
 with
>>> the
>>> Virtex-5 and get a simple prototype up and running.
>>>
>>> After that, create a TI OMAP GPMC to PLB v4.6 Bus Bridge, to make t=
he
>>> GPMC
>>> requests appear in the FPGA PLB bus, so that it can access the FPGA
>>> devices
>>> and peripherals connected to the PLB bus. I'm using the gumstix Ove=
ro for
>>> these tests, and the GPMC signals are not available on the Palo43 o=
r
>>> summit
>>> expansion boards. It is available on the Overo J4/J6 connector thou=
gh,
>>> but
>>> that needs a custom board to bring those signals out.
>>>
>>> Do you know if any other TI OMAP 35xx development board exposes the=
 GPMC
>>> connectors? I just want to finish the software/firmware part before
>>> starting
>>> work on a custom expansion board.
>>
>>
>> I had to build a custom board for my project, I would recommend taki=
ng
>> that approach if possible.
>
> Gumstix Overo?

Yeah using the Overo. I whipped up a board with 4 port USB Host, 1
OTG, the smsc911x ethernet controller. and msp430 to control some
peripherials, 3rd MMC, etc, etc.
My favorite part was the 70 Watt dual power supply (5V,3.3V).   The
gumstix uses about 1-2 watts so a little overkill on the supply, but
it can cook right through a pencil lead :)

Gumstix site has excellent docs to be able to build an expansion
board.  Makes more sense with these fine pitch connectors to build a
proper test board rather than try to bread board up two demo boards.

John

>
> Philip
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
