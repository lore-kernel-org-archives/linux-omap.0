From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Fri, 19 Jun 2009 13:20:37 +0200
Message-ID: <4A3B7485.5060601@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	 <20090605165531.7d0c4522.jhnikula@gmail.com>	 <200906060028.01600.jkrzyszt@tis.icnet.pl>	 <20090608094028.415e6ec3.jhnikula@gmail.com>	 <4A2E7921.7090200@tis.icnet.pl> <4A364B1A.5040905@tis.icnet.pl>	 <20090615181633.4570426f.jhnikula@gmail.com>	 <4A37AFA9.4080403@tis.icnet.pl>	 <20090618090712.8f8ecd53.jhnikula@gmail.com>	 <4A3A27C8.60005@tis.icnet.pl> <df7d0fbb0906182050x1f58da96u9bac334a363bbed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:52259 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbZFSLUu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Jun 2009 07:20:50 -0400
In-Reply-To: <df7d0fbb0906182050x1f58da96u9bac334a363bbed0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun K S <arunks@mistralsolutions.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090618 14:52]:
>> Tony Lindgren wrote:
>>> On omap1, DSP needs to be powered and idled before some mcbsp clocks can
>>> be used. Or at least needs to be powered up.
>> AFAICS there is no DSP code in mainline at all, so the answer is no, DSP  
>> was likely not powered up at all. For several weeks I was trying to do  
>> what was impossible :/. But fortunatelly, I have learned a lot ;).
> 
> We at least used to have code to power and idle the DSP even without the
> dspgateway compiled in.. Sorry I don't remember the details. But most
> likely you need to have the dspgateway patch enabled.

Tony,
Thanks for clarifying things.

Arun K S wrote:
> On Thu, Jun 18, 2009 at 4:40 AM, Janusz
> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>> ... I retried the new driver on commit
>> 90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoiusly seen
>> hangup. I found that it was omap_mcbsp_request() never returning back from.
> 
> I faced the same issue while writing ASoC driver for tlv320aic23b codec.
> 
> You can have a look at this thread:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03852.html
> 
> It may help.

Arun,
Thanks, it's good to hear not only me having this problem ;). So what is 
the current status of your osk driver? What tree do you use, what extra 
patches do you apply to make it actually working?

---------------------------

After all, could someone please give me an advise, what tree, even with 
buggy omap1510 mcbsp/dsp support, should I base my work on for best 
results? Omap? Sound? Mainline? I mean not only easy getting the driver 
working, but also giving it the best possible path into the mainline.

Thanks,
Janusz
