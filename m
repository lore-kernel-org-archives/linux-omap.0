From: Jack Mitchell <jack.mitchell@eumx.net>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 16:36:02 +0000
Message-ID: <50C760F2.6060701@eumx.net>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi> <50C5F6A8.5060701@communistcode.co.uk> <20121210145947.GK11038@arwen.pp.htv.fi> <50C5FD73.1000408@communistcode.co.uk> <20121210183500.GB14303@arwen.pp.htv.fi> <50C70846.7010207@communistcode.co.uk> <87y5h4r4ul.fsf@gmail.com> <50C75E54.2080805@communistcode.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:60775 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab2LKQvc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 11:51:32 -0500
In-Reply-To: <50C75E54.2080805@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ml@communistcode.co.uk
Cc: Ben Gamari <bgamari.foss@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

On 11/12/12 16:24, Jack Mitchell wrote:
> On 11/12/12 15:22, Ben Gamari wrote:
>> Jack Mitchell <ml@communistcode.co.uk> writes: 

>> <snip>
>
> Almost.
>
> I then tried spi1 and received:
>
> root@beaglebone:~# ./spidev -D /dev/spidev2.0
> spi mode: 0
> bits per word: 16
> max speed: 24000000 Hz (24000 KHz)
>
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF
> root@beaglebone:~# ./spidev_dma -D /dev/spidev2.0
> spi mode: 0
> bits per word: 8
> max speed: 500000 Hz (500 KHz)
>
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> root@beaglebone:~#
>
>

My bad! The jumper bridge had come loose, it works now! Yippee!

root@beaglebone:~# ./spidev -D /dev/spidev2.0
spi mode: 0
bits per word: 16
max speed: 24000000 Hz (24000 KHz)

FF FF FF FF FF FF
40 00 00 00 00 95
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
DE AD BE EF BA AD
F0 0D
root@beaglebone:~#

Thanks everyone, and do I need to submit any patches to clear this all up?

Currently all I see is changing the clk pins from output to input (if 
this is a valid change?).
