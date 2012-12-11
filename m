From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 15:23:48 +0000
Message-ID: <50C75004.4060706@communistcode.co.uk>
References: <50C5E23D.5040605@communistcode.co.uk> <20121210135337.GA10219@arwen.pp.htv.fi> <50C5F6A8.5060701@communistcode.co.uk> <20121210145947.GK11038@arwen.pp.htv.fi> <50C5FD73.1000408@communistcode.co.uk> <20121210183500.GB14303@arwen.pp.htv.fi> <50C70846.7010207@communistcode.co.uk> <20121211102011.GG19367@arwen.pp.htv.fi> <50C70D42.8030400@communistcode.co.uk> <20121211114810.GH19367@arwen.pp.htv.fi> <20121211142725.GA17708@arwen.pp.htv.fi>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:54226 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab2LKPVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 10:21:32 -0500
In-Reply-To: <20121211142725.GA17708@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

On 11/12/12 14:27, Felipe Balbi wrote:
> Hi again,
>
> On Tue, Dec 11, 2012 at 01:48:10PM +0200, Felipe Balbi wrote:
>> On Tue, Dec 11, 2012 at 10:38:58AM +0000, Jack Mitchell wrote:
>>> On 11/12/12 10:20, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Tue, Dec 11, 2012 at 10:17:42AM +0000, Jack Mitchell wrote:
>>>>
>>>> <big snip>
>>>>
>>>>> Shubhro, Felipe,
>>>>>
>>>>> Thank you, the reordering dma patch fixed the dma issue I was having!
>>>>> However, the bad news, I now get the same results for the dma and
>>>>> non-dma spidev test. While the scope shows the SPI clk and data is
>>>>> fine, the reading from the program still shows 0x00 for all words.
>>>> <removed spidev_test output>
>>>>
>>>>> dmesg shows nothing of interest apart from the spi bus setting up.
>>>>> Any ideas?
>>>>>
>>>>> To iterate for my own sanity; I have bridged pins 18 and 21 on the P9
>>>>> header which should be the d0 and d1 spi data pins for spi0. This
>>>>> result of 0x00 usually comes from a result of not joining the pins,
>>>>> but I can assure you they are joined!
>>>>>
>>>>> Thank you for the help so far.
>>>> according to the schematics [1], those pins are muxed as UART2_TXD and
>>>> I2C1_SDA, have you remuxed them properly ? Can you try with pins 29 and
>>>> 30 on the same header ? That's SPI1, so you will have to add DT data for
>>>> spidev on that bus too.
>>>>
>>>> [1] http://beagleboard.org/static/beaglebone/latest/Docs/Hardware/BONE_SCH.pdf
>>>>
>>> No change unfortunately:
>>>
>>> root@beaglebone:~# ./spidev
>>> spi mode: 0
>>> bits per word: 16
>>> max speed: 24000000 Hz (24000 KHz)
>>>
>>> 00 00 00 00 00 00
>>> 00 00 00 00 00 00
>>> 00 00 00 00 00 00
>>> 00 00 00 00 00 00
>>> 00 00 00 00 00 00
>>> 00 00 00 00 00 00
>>> 00 00
>>>
>>> root@beaglebone:~# ./spidev -D /dev/s
>>> shm/       spidev1.0  spidev2.0  stderr     stdin      stdout
>>> root@beaglebone:~# ./spidev -D /dev/spidev2.0
> one thing caught my attention, shouldn't you be passing '-l' argument
> here for loopback testing ? That would mean you need to make sure your
> "spi->mode" has SPI_LOOP flag set. Currently there is no way to do that
> via DeviceTree (AFAICT), so please apply ths patch to your tree and set
> spi-loopback; property for your spidev entry:
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 296015e..1949586 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -55,6 +55,8 @@ contain the following properties.
>       		chip select active high
>   - spi-3wire       - (optional) Empty property indicating device requires
>       		    3-wire mode.
> +- spi-loopback    - (optional) Empty property indicating device requires
> +    		    loopback mode.
>   
>   If a gpio chipselect is used for the SPI slave the gpio number will be passed
>   via the cs_gpio
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 3f1b9ee..6bcdc03 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -868,6 +868,8 @@ static void of_register_spi_devices(struct spi_master *master)
>   			spi->mode |= SPI_CS_HIGH;
>   		if (of_find_property(nc, "spi-3wire", NULL))
>   			spi->mode |= SPI_3WIRE;
> +		if (of_find_property(nc, "spi-loopback", NULL))
> +			spi->mode |= SPI_LOOP;
>   
>   		/* Device speed */
>   		prop = of_get_property(nc, "spi-max-frequency", &len);
>

I get the following error when I apply this patch and add spi-loopback.

&spi0 {
   status = "okay";
   pinctrl-names = "default";
   pinctrl-0 = <&spi0_pins>;

   spidev0: spidev@0 {
   compatible = "linux,spidev";
   reg = <0>;
   spi-max-frequency = <24000000>;
   spi-loopback;
   };

};

[    1.093565] omap2_mcspi 48030000.spi: registered master spi1
[    1.094491] spi spi1.0: setup: unsupported mode bits 20
[    1.100035] omap2_mcspi 48030000.spi: can't setup spi1.0, status -22
[    1.106715] spi_master spi1: spi_device register error 
/ocp/spi@48030000/spidev@0
[    1.115030] omap2_mcspi 481a0000.spi: registered master spi2
[    1.115710] spi spi2.0: setup: unsupported mode bits 20
[    1.121225] omap2_mcspi 481a0000.spi: can't setup spi2.0, status -22
[    1.127903] spi_master spi2: spi_device register error 
/ocp/spi@481a0000/spidev@0

I have run this test many times before and have never needed to use a 
loopback...

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

