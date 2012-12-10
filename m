From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Mon, 10 Dec 2012 14:50:16 +0000
Message-ID: <50C5F6A8.5060701@communistcode.co.uk>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:53312 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab2LJOsA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 09:48:00 -0500
In-Reply-To: <20121210135337.GA10219@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Felipe,

On 10/12/12 13:53, Felipe Balbi wrote:
> Hi,
>
> On Mon, Dec 10, 2012 at 01:23:09PM +0000, Jack Mitchell wrote:
>> Hi,
>>
>> I am currently having issues with the SPI driver on the beaglebone
>> using the 3.7-rc8 kernel[1]. I have probed the SPI pins and I have
>> found that writing works however reading doesn't. When using DMA the
>> program seems to lock hard and no data is sent on the bus. I am
>> testing the bus using spidev and the spidev_test[2] application,
>> however I first came across spi issues with a custom spi driver which
>> stopped working when I transitioned from 3.2-psp to 3.7-rc8.
>>
>> The current output I am seeing from the spidev_test program is just a
>> series of 0x00 data, which looks to me like no data is getting in at
>> all. The spidev_test program is not using DMA as the buffer size is
>> too low, so I forced the dma on when buffer size is > 1 and the
>> program hangs hard with the system still responding to other
>> commands.I have briged the pins 18 and 21 on the BeagleBone P9
>> header.
>>
>> Has anyone seen issues like this, or if not if someone could please
>> test the latest 3.7-rc8 from [1] and let me know if it works for them
>> and the issue is at my end.
>>
>> To get spidev working with devicetree I applied the patch from [3]
>> and changed the dtb as in the patch pasted below.
>>
>> [1] https://github.com/beagleboard/kernel/tree/3.7
>> [2] http://lxr.linux.no/#linux+v3.6.9/Documentation/spi/spidev_test.c
>> [3] http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg09958.html
> do you have any debugging output from that driver ? It would be cool to
> see if DMA is at least being kicked properly for small transfers.

When I run the spidev program with dma for transfers > 1, the program 
hangs and the only output in dmesg is:

[   12.613952] libphy: 4a101000.mdio:00 - Link is Up - 100/Full <---- 
Last line from initial log in [2]
[   47.669202] spidev spi1.0: setup: speed 24000000, sample leading 
edge, clk normal
[   47.669246] spidev spi1.0: setup mode 0, 8 bits/w, 24000000 Hz max --> 0
[   47.669260] spidev spi1.0: spi mode 00
[   47.669283] spidev spi1.0: setup: speed 24000000, sample leading 
edge, clk normal
[   47.669300] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --> 0
[   47.669312] spidev spi1.0: 16 bits per word
[   47.669330] spidev spi1.0: setup: speed 24000000, sample leading 
edge, clk normal
[   47.669347] spidev spi1.0: setup mode 0, 16 bits/w, 24000000 Hz max --> 0
[   47.669358] spidev spi1.0: 24000000 Hz (max)
[   47.673811] spidev spi1.0: setup: speed 24000000, sample leading 
edge, clk normal

The initial dmesg statup log is at [2].

>
> It would also be nice to have a clear picture of what "custom spi
> driver" you're talking about.

The custom SPI driver is for connecting and reading registers from an in 
house FPGA design and can be found at [1]. It's fairly rudimentary and 
also in the development stages, I'm very new to Linux kernel programming 
so please take that into account :)

However it did work flawlessly with 3.2-psp.

>
> cheers
>

[1] http://embed.me.uk/fpgaSPI.c
[2] http://embed.me.uk/bone-log.1

Cheers,

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

