From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Fri, 04 Jan 2013 16:36:15 +0000
Message-ID: <50E704FF.107@communistcode.co.uk>
References: <50C5E23D.5040605@communistcode.co.uk>  <20121210135337.GA10219@arwen.pp.htv.fi>  <50C5F6A8.5060701@communistcode.co.uk>  <20121210145947.GK11038@arwen.pp.htv.fi>  <50C5FD73.1000408@communistcode.co.uk>  <20121210183500.GB14303@arwen.pp.htv.fi>  <50C70846.7010207@communistcode.co.uk> <87y5h4r4ul.fsf@gmail.com>  <50C75E54.2080805@communistcode.co.uk> <50C7671B.80504@communistcode.co.uk> <1357310801.23039.24.camel@coredoba.hi.pengutronix.de> <50E7019E.5090109@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:49969 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062Ab3ADQeA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 11:34:00 -0500
In-Reply-To: <50E7019E.5090109@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ml@communistcode.co.uk
Cc: =?UTF-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>, Ben Gamari <bgamari.foss@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org, mporter@ti.com

On 04/01/13 16:21, Jack Mitchell wrote:
> On 04/01/13 14:46, Jan L=C3=BCbbe wrote:
>> Hi,
>>
>> On Tue, 2012-12-11 at 17:02 +0000, Jack Mitchell wrote:
>>> On 11/12/12 16:24, Jack Mitchell wrote:
>>>> On 11/12/12 15:22, Ben Gamari wrote:
>>>>> Jack Mitchell <ml@communistcode.co.uk> writes:
>>>>>> Thank you, the reordering dma patch fixed the dma issue I was=20
>>>>>> having!
>>>>>> However, the bad news, I now get the same results for the dma an=
d
>>>>>> non-dma spidev test. While the scope shows the SPI clk and data =
is
>>>>>> fine,
>>>>>> the reading from the program still shows 0x00 for all words.
>>>>>>
>>>>> Just to make sure this has been thought of: I've seen this sort o=
f
>>>>> behavior in the past when the CLK pin wasn't configured as an inp=
ut.
>> *snip*
>>
>>> My bad! The jumper bridge had come loose, it works now! Yippee!
>>>
>>> root@beaglebone:~# ./spidev -D /dev/spidev2.0
>>> spi mode: 0
>>> bits per word: 16
>>> max speed: 24000000 Hz (24000 KHz)
>>>
>>> FF FF FF FF FF FF
>>> 40 00 00 00 00 95
>>> FF FF FF FF FF FF
>>> FF FF FF FF FF FF
>>> FF FF FF FF FF FF
>>> DE AD BE EF BA AD
>>> F0 0D
>>> root@beaglebone:~#
>>>
>>> Thanks everyone, and do I need to submit any patches to clear this=20
>>> all up?
>>>
>>> Currently all I see is changing the clk pins from output to input (=
if
>>> this is a valid change?).
>> I just stumbled over the same problem and have not seen any patch fo=
r
>> this fix. Have I missed something or should I send a patch? Which wo=
uld
>> be the correct base for such a patch?
>>
>> Regards,
>> Jan
>
> I didn't submit a patch for this but easily could. I was confused=20
> about what tree to base it against as at the time (may still be the=20
> same) DT SPI for AM335x was not in a mainline tree. I hoped someone=20
> would pick it up when posting DT SPI for mainline....
>

I've just had confirmation from Matt Porter on IRC that this change wil=
l=20
be present in the next iteration of his DMA Engine series, which I=20
believe brings in the DT SPI support.

Cheers All,
Jack

--=20

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
