From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: AM3517evm
Date: Thu, 29 Mar 2012 16:59:29 +0200
Message-ID: <4F7478D1.5080708@visionsystems.de>
References: <CAFu+nvFt8BcO1pDD6CXXM056WYG9AQDTv-boc7xF0C2JuHAyYw@mail.gmail.com> <4F5E0036.105@visionsystems.de> <20120315154335.GA29645@animalcreek.com> <4F621048.2090003@visionsystems.de> <20120315164221.GB29645@animalcreek.com> <20120315165245.GC29645@animalcreek.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:48951 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab2C2O7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 10:59:40 -0400
In-Reply-To: <20120315165245.GC29645@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: "George C. Huntington, III" <george.huntingtoniii@gmail.com>, linux-omap@vger.kernel.org, mporter@ti.com

Am 15.03.2012 17:52, schrieb Mark A. Greer:
> On Thu, Mar 15, 2012 at 09:42:21AM -0700, Mark A. Greer wrote:
>> On Thu, Mar 15, 2012 at 04:52:40PM +0100, Yegor Yefremov wrote:
>>> Am 15.03.2012 16:43, schrieb Mark A. Greer:
>>>> On Mon, Mar 12, 2012 at 02:55:02PM +0100, Yegor Yefremov wrote:
>>>>> Am 09.03.2012 18:22, schrieb George C. Huntington, III:
>>>>>> I would like to make the newer kernel (3.x) work with the AM3517EVM.
>>>>>> I have a 2.6.32 and a 2.6.33 that run well on the board, but the
>>>>>> recent kernels have kernel panics before even running init.  where
>>>>>> should I start?  is there a better place to pursue this?
>>>>> Have you tried this one? http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary
>>>>>
>>>>> I have this one booting one month ago, but I checked out the kernel today and it hangs somewhere:
>>>>>
>>>>> Starting kernel ...
>>>>>
>>>>> Uncompressing Linux... done, booting the kernel.
>>>> This looks like you have your console device set to ttyS2 instead of ttyO2.
>>>>
>>>> Which branch of that repository did you use?
>>> My kernel params: CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200" and I force them, so bootloader has nothing to say.
>>>
>>> I'm using master branch.
>> I just booted the latest master branch (b8fe178) with the hack below.
>> (Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw
>> rootfstype=ext3 rootwait)
> I meant to add that I booted an am3517evm.

Is frame buffer working? I can boot with the latest linux-omap version, but as soon as I enable omapfb, kernel freezes before making any output to the serial console. Have I missed some DSS/DPI patches?

Best regards,
Yegor
