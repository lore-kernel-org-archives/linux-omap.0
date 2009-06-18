From: Tony Lindgren <tony@atomide.com>
Subject: Re: Progress in adding ams-delta support to ASoC?
Date: Thu, 18 Jun 2009 13:21:44 +0300
Message-ID: <20090618102141.GH8482@atomide.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A37AFA9.4080403@tis.icnet.pl> <4A38F9D6.5000803@tis.icnet.pl> <200906181202.11414.peter.ujfalusi@nokia.com> <20090618075820.GG8482@atomide.com> <4A3A2A5E.6090307@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49160 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZFRMVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 08:21:54 -0400
Content-Disposition: inline
In-Reply-To: <4A3A2A5E.6090307@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090618 14:52]:
> Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@nokia.com> [090618 12:03]:
>>> On Wednesday 17 June 2009 17:12:38 ext Janusz Krzysztofik wrote:
>>>> Janusz Krzysztofik wrote:
>>>>> After all, it is more and more likely that the problem is not dma, but
>>>>> mcbsp just not shifting any data for some mysterious reason.
>>>> I finally did what I should have already done before: learned about
>>>> dynamic debugging, turned it on and probably got the answer from
>>>> omap_msbsp_dump_reg(): all mcbsp1 register read operations returned
>>>> 0xffff. So it looks like I simply get no acccess to mcbsp1 at all. Now I
>>>> wonder if I can close this thread with a conclusion that mcbsp1 on
>>>> opam15xx is simply not yet supported by the mainline kernel that I have
>>>> based my work on.
>>> Hmmm, this is quite unexpected.
>>> Can you access to mcbsp2 or 3 registers, or only the mcbsp1 registers 
>>> are not accessible?
>>> One thing that I have noticed is that the McBSP1 (and 3) is under the 
>>> DSP Public Peripherals, while McBSP2 is under MPU Public Peripherals 
>>> (in OMAP1510).
>>> I have to check it further what this actually means...
>>
>> Hmmm, do you have the DSP code compiled (and loaded)?
>>
>> On omap1, DSP needs to be powered and idled before some mcbsp clocks can
>> be used. Or at least needs to be powered up.
>
> AFAICS there is no DSP code in mainline at all, so the answer is no, DSP  
> was likely not powered up at all. For several weeks I was trying to do  
> what was impossible :/. But fortunatelly, I have learned a lot ;).

We at least used to have code to power and idle the DSP even without the
dspgateway compiled in.. Sorry I don't remember the details. But most
likely you need to have the dspgateway patch enabled.

Tony
