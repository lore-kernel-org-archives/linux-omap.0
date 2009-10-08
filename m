From: Tony Lindgren <tony@atomide.com>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins for
	omap7xx)
Date: Thu, 8 Oct 2009 09:51:26 -0700
Message-ID: <20091008165125.GE7417@atomide.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com> <4ACB7EC0.3010401@ti.com> <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com> <87hbucp6ng.fsf@deeprootsystems.com> <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com> <878wfop4rc.fsf@deeprootsystems.com> <20091007174750.GG7899@atomide.com> <4ACD4F40.5020707@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60917 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbZJHQwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 12:52:12 -0400
Content-Disposition: inline
In-Reply-To: <4ACD4F40.5020707@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Philip Balister <philip@balister.org> [091007 19:32]:
> On 10/07/2009 10:47 AM, Tony Lindgren wrote:
>> * Kevin Hilman<khilman@deeprootsystems.com>  [091006 15:18]:
>>> "Menon, Nishanth"<nm@ti.com>  writes:
>>>
>>>>> -----Original Message-----
>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>>>>
>>>>>>>>         W17_7XX_USB_VBUSI,
>>>>>>>> +
>>>>>>>> +       /* MMC */
>>>>>>>> +       MMC_7XX_CMD,
>>>>>>>> +       MMC_7XX_CLK,
>>>>>>>> +       MMC_7XX_DAT0,
>>>>>>>
>>>>>>> probably a dumb question ->  but should'nt these go off to bootloader
>>>>>>> perhaps?
>>>>>>>
>>>>>>
>>>>>> Perhaps, although we use either EOL (for HTC Wizard) or Haret to boot,
>>>>>> and they don't set up the right mux configuration for our board.
>>>>>>
>>>>>> This way though, we don't have to worry about the boot loader -- we
>>>>>> can set it up right regardless of who boots us.
>>>>>
>>>>> I agree with Cory.
>>>>>
>>>>> I prefer that mux settings go into the kernel, even if they are setup
>>>>> in the bootloader already.  It's better to have redundancy than wonder
>>>>> what to do if changing boot loaders.
>>>>>
>>>> Probably opening up a can of worms.. Are the rules different for OMAP3?
>>>> Should'nt we have all mux done at kernel so that kernel is loader
>>>> independent?
>>>
>>> Yes, we should.  My preference is to always have muxing in the kernel.
>>
>> Agreed. We still should support bootloader only muxing too.
>>
>> BTW, I've been thinking about the following sets of patches for the next
>> merge window:
>>
>> 1. Do the include directories for mach-omap1 and mach-omap2 as suggested
>>     by Russell earlier
>
> Does anyone have a reference to Russell's suggestion?

Here's a link to the thread discussing the earlier header changes:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15087.html

Regards,

Tony


> Philip
>
>
>>
>> 2. Move all mux code to only live under arch/arm/*omap*/ and make sure
>>     drivers don't call omap_cfg_reg() any longer
>>
>> 3. Remove the enumeration for the mux and require all the boards to
>>     register the pins they'll use
>>
>> After these it should be trivial to improve the mux code further. The
>> steps 2&  3 above will be most likely breaking things for some boards,
>> so help will be needed with testing.
>>
>> Regards,
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


