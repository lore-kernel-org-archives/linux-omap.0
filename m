From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 16:24:52 +0000
Message-ID: <50C75E54.2080805@communistcode.co.uk>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi> <50C5F6A8.5060701@communistcode.co.uk> <20121210145947.GK11038@arwen.pp.htv.fi> <50C5FD73.1000408@communistcode.co.uk> <20121210183500.GB14303@arwen.pp.htv.fi> <50C70846.7010207@communistcode.co.uk> <87y5h4r4ul.fsf@gmail.com>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:50936 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2LKQWf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 11:22:35 -0500
In-Reply-To: <87y5h4r4ul.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

On 11/12/12 15:22, Ben Gamari wrote:
> Jack Mitchell <ml@communistcode.co.uk> writes:
>
>> Shubhro, Felipe,
>>
>> Thank you, the reordering dma patch fixed the dma issue I was having!
>> However, the bad news, I now get the same results for the dma and
>> non-dma spidev test. While the scope shows the SPI clk and data is fine,
>> the reading from the program still shows 0x00 for all words.
>>
> Just to make sure this has been thought of: I've seen this sort of
> behavior in the past when the CLK pin wasn't configured as an input.
>
> Cheers,
>
> - Ben
>

Ok, Ben, well spotted indeed! I changed the dtsi to use INPUT_PULLUP 
instead of OUTPUT_PULLUP and wallah!

   am3358_pinmux: pinmux@44e10800 {
     spi0_pins: pinmux_spi0_pins {
       pinctrl-single,pins = <
         0x150 *0x30*      /* spi0_sclk.gpio0_2, INPUT_PULLUP | MODE0 
*/<------------ changed to INPUT
         0x154 0x30      /* spi0_d0.gpio0_3, INPUT_PULLUP | MODE0 */
         0x158 0x10      /* spi0_d1.i2c1_sda, OUTPUT_PULLUP | MODE0 */
         0x15c 0x10      /* spi0_cs0.i2c1_scl, OUTPUT_PULLUP | MODE0 */
       >;
     };
     spi1_pins: pinmux_spi1_pins {
       pinctrl-single,pins = <
         0x190 *0x33*  /* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3 
*/ <------------ changed to INPUT
         0x194 0x33  /* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
         0x198 0x13  /* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
         0x19c 0x13  /* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
       >;
     };


root@beaglebone:~# ./spidev
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
root@beaglebone:~# ./spidev_dma
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)

FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00
FF 00 FF 00 FF 00

We are in business!

Almost.

I then tried spi1 and received:

root@beaglebone:~# ./spidev -D /dev/spidev2.0
spi mode: 0
bits per word: 16
max speed: 24000000 Hz (24000 KHz)

FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF
root@beaglebone:~# ./spidev_dma -D /dev/spidev2.0
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)

FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
FF FF FF FF FF FF
root@beaglebone:~#


-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

