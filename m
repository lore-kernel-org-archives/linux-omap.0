From: Philip Balister <philip@balister.org>
Subject: Re: Simple GPMC device driver with basic User application
Date: Fri, 04 Nov 2011 07:48:14 -0400
Message-ID: <4EB3D0FE.2080400@balister.org>
References: <CAOy7-nNxRgB21JSFcWvD4T3AwDDuh9MjBeB+8nFiwX-Cv+13Mw@mail.gmail.com> <CAOy7-nMMyk3kMc9aShigxuvdB5O3S+B319SCR36kzM0ZTmSQ6w@mail.gmail.com> <20111103192532.GX31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:14730 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754029Ab1KDLy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 07:54:57 -0400
In-Reply-To: <20111103192532.GX31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: James <angweiyang@gmail.com>, linux-omap@vger.kernel.org

On 11/03/2011 03:25 PM, Tony Lindgren wrote:
> * James <angweiyang@gmail.com> [111023 18:13]:
>> Dear all,
>>
>> I'm learning embedded linux development and need help on my task.
>>
>> I'm trying to communicate with a FPGA via the GPMC bus on my Overo FE
>> board and need assistance with writing a simple device driver & test
>> application that uses the GPMC bus to read & write a WORD size data
>> and also a BLOCK of WORD data to the FPGA.
>>
>> The FPGA-OMAP3530 will be use synchronous read/write over the 16-bit
>> datapath and CS 6.
>> The GPMC bus is shared with an Ethernet chip and NAND chip as per
>> Gumstix COM + TOBI/Chestnut design and these standard devices must
>> still work as per norm.
>>
>> I've been searching via GMANE for similar questions but some are
>> pointing to non-existence archives.
>>
>> I believe I have to develop a kernel device driver to register the
>> FPGA and from which will expose a device node for the test
>> application.
>> or is there a generic GPMC driver that does it?
>>
>> Can someone share with me similar layout and code so that I can base
>> my learning from a starting point?
>>
>> Many thanks in adv.
> 
> Please take a look at the various arch/arm/mach-omap2/gpmc-*.c files.
> The biggest pain is to get the timings right.

Also take a look at:

https://github.com/balister/linux-omap-philip/commits/e100-2.6.38-2

Philip
