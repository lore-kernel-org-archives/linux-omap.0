From: John Sarman <johnsarman@gmail.com>
Subject: Re: TI OMAP 3503 GPIO signal I/O standard for interfacing with FPGA
Date: Fri, 14 Aug 2009 08:50:54 -0400
Message-ID: <bb2708720908140550g349cc340kb3d436d6b634fe1e@mail.gmail.com>
References: <BD5F061C-76EC-40EF-93D6-5C64860EBEA7@mac.com>
	 <bb2708720908120554m33caeb32v4d13da69d1e94e7d@mail.gmail.com>
	 <3E9F21C0-53FC-4673-BE6B-BD1DC9B8D3EC@mac.com>
	 <bb2708720908130614p6ded4627o848631cfb0d3eaa4@mail.gmail.com>
	 <A7754699-2C29-4524-B85B-396EB1F63E16@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:61973 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702AbZHNMuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 08:50:54 -0400
Received: by yxe5 with SMTP id 5so1822375yxe.33
        for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 05:50:55 -0700 (PDT)
In-Reply-To: <A7754699-2C29-4524-B85B-396EB1F63E16@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Aug 13, 2009 at 9:29 AM, Elvis Dowson<elvis.dowson@mac.com> wro=
te:
> Hi John,
>
> On Aug 13, 2009, at 5:14 PM, John Sarman wrote:
>
>>
>>
>> <snip from omap 35xx page>
>> =A0General Purpose Memory Controller (GPMC)
>>
>> =A0 * 16-bit Wide Multiplexed Address/Data Bus
>> =A0 * Up to 8 Chip Select Pins With 128M-Byte Address Space per Chip=
 Select
>> Pin
>> =A0 * Glueless Interface to NOR Flash, NAND Flash (With ECC Hamming
>> Code Calculation), SRAM and Pseudo-SRAM
>> =A0 * Flexible Asynchronous Protocol Control for Interface to Custom
>> Logic (FPGA, CPLD, ASICs, etc.)
>> =A0 * Nonmultiplexed Address/Data Mode (Limited 2K-Byte Address Spac=
e)
>> </snip from omap 35xx page>
>
> Thanks for the info, I've read that section on the GPMC. I'm going to
> attempt this in stages. First I'll implement a simple protocol betwee=
n the
> OMAP and the FPGA, e.g. use GPIOs to signal read and write operations=
, and
> the serial UART0 to transfer data to a memory location for the FPGA t=
o
> process and return the result.
>
> Since the TI OMAP uses 1.8v signalling, I can directly interface it w=
ith the
> Virtex-5 and get a simple prototype up and running.
>
> After that, create a TI OMAP GPMC to PLB v4.6 Bus Bridge, to make the=
 GPMC
> requests appear in the FPGA PLB bus, so that it can access the FPGA d=
evices
> and peripherals connected to the PLB bus. I'm using the gumstix Overo=
 for
> these tests, and the GPMC signals are not available on the Palo43 or =
summit
> expansion boards. It is available on the Overo J4/J6 connector though=
, but
> that needs a custom board to bring those signals out.
>
> Do you know if any other TI OMAP 35xx development board exposes the G=
PMC
> connectors? I just want to finish the software/firmware part before s=
tarting
> work on a custom expansion board.


I had to build a custom board for my project, I would recommend taking
that approach if possible.

>
> Best regards,
>
> Elvis
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
