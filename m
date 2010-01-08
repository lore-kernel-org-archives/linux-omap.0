From: Philip Balister <philip@balister.org>
Subject: Re: [PATCH] omap: Fix cmdline muxing (Re: New pinmux)
Date: Fri, 08 Jan 2010 13:59:13 -0500
Message-ID: <4B478081.4060809@balister.org>
References: <4B474F9B.9020409@balister.org> <20100108180031.GB6831@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:22369 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753404Ab0AHS7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 13:59:16 -0500
In-Reply-To: <20100108180031.GB6831@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/08/2010 01:00 PM, Tony Lindgren wrote:
> * Philip Balister<philip@balister.org>  [100108 07:35]:
>> I am trying to work out how to use the new pinmux code on my
>> Overo+Summit system. I have a recent git running with the new pinmux
>> code built. I am trying to configure the mcspi1_clk pin on the
>> expansion connector as gpio_171 with the following:
>>
>> root@overo:~# dmesg |grep mux
>>
>> Kernel command line: console=ttyS2,115200n8 vram=12M
>> omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y
>> omapdss.def_display=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3
>> rootwait omap_mux=mcspi1_clk.gpio_171=0x0
>>
>> And this is what happens :(
>>
>> mux: Could not set signal mcspi1_clk
>>
>> mux: Setting signal i2c3_scl.i2c3_scl 0x0118 ->  0x0100
>>
>> Any suggestions?
>
> Sounds like the cmdline options got broken by some changes
> I did to limit everything to happen as __init..
>
> Can you please try the following patch?

The patch solved the problem, thanks! Great work guys, this will really 
help people working with boards with expansion connectors like the 
Beagle and Overo.

Tony, do you need a signoff from me for this? Not to sure what the 
procedure is.

Philip
