From: Tony Lindgren <tony@atomide.com>
Subject: Re: McSPI3 on the BeagleBoard
Date: Wed, 18 Feb 2009 16:53:37 -0800
Message-ID: <20090219005336.GD31436@atomide.com>
References: <499B4B64.30109@balister.org> <200902171918.45146.david-b@pacbell.net> <499CAA27.5020500@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50986 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZBSAxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 19:53:39 -0500
Content-Disposition: inline
In-Reply-To: <499CAA27.5020500@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Philip Balister <philip@balister.org> [090218 16:39]:
> David Brownell wrote:
>> On Tuesday 17 February 2009, Philip Balister wrote:
>>> A number of people have tried using the McSPI3 interface with the 
>>> spidev driver. Running the spidev_test program shows data coming out 
>>> of the interface, but when we connect the SIMO to SOMI pins, the 
>>> spidev_test program shows only 0's. Someone tried wiring SOMI to 
>>> +volts and still only saw 0 read.
>>
>> I took a quick glance, and the pinmuxing looks sort of OK if
>> you ignore the names ... use the right balls, not XXX:
>>
>> +       AE2_3430_MCSPI3_CLK,
>> +       AG5_3430_MCSPI3_SIMO,
>> +       AH5_3430_MCSPI3_SOMI,
>> +       AF4_3430_MCSPI3_CS0,
>> +       AG4_3430_MCSPI3_CS1,
>>
>> I suggest you start with a more focussed patch, only setting
>> up McSPI3.  For one thing, the MMC2 pinmuxing will interfere
>> with this set of MCSPI3 configurations.
>>
>> Also, start with a less aggressive bit rate than 48 MHz; that
>> may be OK on a well designed board, but breadboards tend to
>> show flakiness at much over 10 MHz.
>
> OK, more results:
>
> 1) I do not intend for this to go into the kernel, well unless there is  
> an outcry from beagle users :)

Sure we should integrate it, people need it!

> Steve Sakoman suggested I do the pinmux setup in u-boot and furnished me  
> with a small u-boot patch. Using this patch and removing the pinmux  
> stuff from the kernel patch lead to working spidev_test.

The pin muxing should be also available in the kernel especially for
boards that have multiple options for the pins.

> The 48 MHz is the max rate, spidev_test defaults to 500 kHz. (but it  
> appears to work at 48 MHz also.
>
> Thanks for taking a look at this!

How about add a cmdline option where you override the spi ports in
use?

> PS: I love photos: http://www.flickr.com/photos/32615155@N00/3291304854/

Hmm, I can't quite see from the photo where you have wired the cat's
tail to.. :)

Tony
