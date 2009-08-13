From: John Sarman <johnsarman@gmail.com>
Subject: Re: TI OMAP 3503 GPIO signal I/O standard for interfacing with FPGA
Date: Thu, 13 Aug 2009 09:14:28 -0400
Message-ID: <bb2708720908130614p6ded4627o848631cfb0d3eaa4@mail.gmail.com>
References: <BD5F061C-76EC-40EF-93D6-5C64860EBEA7@mac.com>
	 <bb2708720908120554m33caeb32v4d13da69d1e94e7d@mail.gmail.com>
	 <3E9F21C0-53FC-4673-BE6B-BD1DC9B8D3EC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50483 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZHMNO2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 09:14:28 -0400
Received: by yxe5 with SMTP id 5so922379yxe.33
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 06:14:28 -0700 (PDT)
In-Reply-To: <3E9F21C0-53FC-4673-BE6B-BD1DC9B8D3EC@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Aug 12, 2009 at 10:13 AM, Elvis Dowson<elvis.dowson@mac.com> wr=
ote:
> Hi John,
>
> On Aug 12, 2009, at 4:54 PM, John Sarman wrote:
>
>> Use LVCMOS at 1.8V =A0if you can not use 1.8 V (get another FPGA, ju=
st
>> kidding) =A0then you will need a buffer (level translator) between t=
hem.
>
> Thanks for the info. I think I have support for LVCMOS at 1.8v on the
> Virtex-5. :-)
>
> BTW, what about the GPMC controller, does same signal I/O standard ap=
ply?

LVCMOS  Single ended standard IO for low power low voltage.
LVTTL  Single ended standard IO for compatiblity with older
technologies, can sink souce more current and have higher voltage
tolerances.
HSTL  differential pair, no good for GPMC
SSTL  SSTL_18 Series Stub Terminated, used with DDR II memory;
requires Vddq =3D 1.8v, Vt =3D 0.5 x Vddq.  Worth doing research to see=
 if
this would make sense for the GPMC.
 GTL is a backplane Ghz IO only swings to 1.2V
 PCI for interfacing with the PCI bus, so again probably not.

I would look into SSTL if you are going to interface the FPGA with the
OMAP as if the FPGA appears as a memory device.  Not 100% sure though.

<snip from omap 35xx page>
   General Purpose Memory Controller (GPMC)

    * 16-bit Wide Multiplexed Address/Data Bus
    * Up to 8 Chip Select Pins With 128M-Byte Address Space per Chip Se=
lect Pin
    * Glueless Interface to NOR Flash, NAND Flash (With ECC Hamming
Code Calculation), SRAM and Pseudo-SRAM
    * Flexible Asynchronous Protocol Control for Interface to Custom
Logic (FPGA, CPLD, ASICs, etc.)
    * Nonmultiplexed Address/Data Mode (Limited 2K-Byte Address Space)
</snip from omap 35xx page>

John
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
