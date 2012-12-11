From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 10:38:58 +0000
Message-ID: <50C70D42.8030400@communistcode.co.uk>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi> <50C5F6A8.5060701@communistcode.co.uk> <20121210145947.GK11038@arwen.pp.htv.fi> <50C5FD73.1000408@communistcode.co.uk> <20121210183500.GB14303@arwen.pp.htv.fi> <50C70846.7010207@communistcode.co.uk> <20121211102011.GG19367@arwen.pp.htv.fi>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:44148 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab2LKKgo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 05:36:44 -0500
In-Reply-To: <20121211102011.GG19367@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

On 11/12/12 10:20, Felipe Balbi wrote:
> Hi,
>
> On Tue, Dec 11, 2012 at 10:17:42AM +0000, Jack Mitchell wrote:
>
> <big snip>
>
>> Shubhro, Felipe,
>>
>> Thank you, the reordering dma patch fixed the dma issue I was having!
>> However, the bad news, I now get the same results for the dma and
>> non-dma spidev test. While the scope shows the SPI clk and data is
>> fine, the reading from the program still shows 0x00 for all words.
> <removed spidev_test output>
>
>> dmesg shows nothing of interest apart from the spi bus setting up.
>> Any ideas?
>>
>> To iterate for my own sanity; I have bridged pins 18 and 21 on the P9
>> header which should be the d0 and d1 spi data pins for spi0. This
>> result of 0x00 usually comes from a result of not joining the pins,
>> but I can assure you they are joined!
>>
>> Thank you for the help so far.
> according to the schematics [1], those pins are muxed as UART2_TXD and
> I2C1_SDA, have you remuxed them properly ? Can you try with pins 29 and
> 30 on the same header ? That's SPI1, so you will have to add DT data for
> spidev on that bus too.
>
> [1] http://beagleboard.org/static/beaglebone/latest/Docs/Hardware/BONE_SCH.pdf
>

No change unfortunately:

root@beaglebone:~# ./spidev
spi mode: 0
bits per word: 16
max speed: 24000000 Hz (24000 KHz)

00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00

root@beaglebone:~# ./spidev -D /dev/s
shm/       spidev1.0  spidev2.0  stderr     stdin      stdout
root@beaglebone:~# ./spidev -D /dev/spidev2.0
spi mode: 0
bits per word: 16
max speed: 24000000 Hz (24000 KHz)

00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00 00 00 00 00
00 00
root@beaglebone:~#

Cheers,
Jack.


-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

