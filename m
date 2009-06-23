From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 23 Jun 2009 13:58:14 +0200
Message-ID: <4A40C356.2070401@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl>	<20090608094028.415e6ec3.jhnikula@gmail.com>	<4A2E7921.7090200@tis.icnet.pl>	<4A364B1A.5040905@tis.icnet.pl>	<20090615181633.4570426f.jhnikula@gmail.com>	<4A37AFA9.4080403@tis.icnet.pl>	<20090618090712.8f8ecd53.jhnikula@gmail.com>	<4A3A27C8.60005@tis.icnet.pl> <20090622144757.f78373ae.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47858 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbZFWL63 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jun 2009 07:58:29 -0400
In-Reply-To: <20090622144757.f78373ae.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Arun K S <arunks@mistralsolutions.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Hi,

Arun K S wrote:
> On Fri, Jun 19, 2009 at 4:20 AM, Janusz
> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>> After all, could someone please give me an advise, what tree, even with
>> buggy omap1510 mcbsp/dsp support, should I base my work on for best results?
> 
> You have to use current omap tree with the patches from current sound
> tree(ASoC omap platform drivers changes) for
> testing the driver.

Arun,
Thanks, from now on I use l-o master, right? As I do my development 
using OE, I am still investigating how to set up a bb recipe to get ALSA 
git tree applied over l-o.

Arun K S wrote:
> On Fri, Jun 19, 2009 at 4:20 AM, Janusz
> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>> Arun K S wrote:
>>> On Thu, Jun 18, 2009 at 4:40 AM, Janusz
>>> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>>>> ... I retried the new driver on commit
>>>> 90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoiusly
>>>> seen
>>>> hangup. I found that it was omap_mcbsp_request() never returning back
>>>> from.
>>> I faced the same issue while writing ASoC driver for tlv320aic23b codec.
>>>
>>> You can have a look at this thread:
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03852.html
> Initially i used to add the omap_mcbsp_request()
> at the boot time, other wise it hangs up. ...
> I believe there are some patches from Russel
> for the DSP memory mapping during
> 2.6.29 kernel.

Jarkko Nikula wrote:
> On Thu, 18 Jun 2009 13:40:56 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> 
>> Then I retired the same on the commit 
>> d8376cc482b241701f7606c81ad578b90853e175 and got similiar hangup.
> 
> Can you move this boot time initialization moment around with
> xxx_initcall variants to see what is the point where block is not
> anymore accessable? Basically around the DSP power up and idle code
> (were there such code for older audio drivers?) and where unused clocks
> are disabled (functions clk_disable_unused and
> omap1_clk_disable_unused).

Arun, Jarkko,
Thanks. Fortunatelly, I can confirm that the problem of 
omap_mcbsp_request() not returning back when called too late, has been 
already solved and no longer applies to 2.6.30, be it omap or mainline, 
with or without a working dsp.

Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090618 14:52]:
>> Tony Lindgren wrote:
>>> * Peter Ujfalusi <peter.ujfalusi@nokia.com> [090618 12:03]:
>>>> On Wednesday 17 June 2009 17:12:38 ext Janusz Krzysztofik wrote:
>>>>> Janusz Krzysztofik wrote:
>>>>>> ...  got the answer from
>>>>> omap_msbsp_dump_reg(): all mcbsp1 register read operations returned
>>>>> 0xffff. So it looks like I simply get no acccess to mcbsp1 at all.
>>>>> 
>>>> One thing that I have noticed is that the McBSP1 (and 3) is under the 
>>>> DSP Public Peripherals, while McBSP2 is under MPU Public Peripherals 
>>>> (in OMAP1510).
>>>
>>> On omap1, DSP needs to be powered and idled before some mcbsp clocks can
>>> be used. Or at least needs to be powered up.
>> AFAICS there is no DSP code in mainline at all, so the answer is no, DSP  
>> was likely not powered up at all.
> 
> We at least used to have code to power and idle the DSP even without the
> dspgateway compiled in.. Sorry I don't remember the details. But most
> likely you need to have the dspgateway patch enabled.

I hacked in the prevoiusly removed dsp_common.c containing 
omap_dsp_init(), with all header files required for successfull 
compilation, and finally got my driver working on top of current l-o.

Jarkko, Peter, Mark, Tony, Arun,
Thanks for your help.


It seams that dsp_common.c with its omap_dsp_init() used to be always 
compiled into the kernel, even if the rest of dspgateway code was not 
compiled or compiled as a module. This file, initially existing in 
arch/arm/plat-omap, was moved to drivers/dsp (commit 
23ed8b5cf043a9cd40b5d415645b3543357d9a1a), and then removed completely 
(commit 2512fd29db4eb09e82d182596304c7aaf76d2c5c), together with other 
dspgateway code. Since then, McBSP ports that are DSP public peripherals 
have probably no chance to work, at least on omap1510, as I have verified.

Perhaps this single file (or its part with omap_dsp_init() at least) 
should never happen to be moved out of arch/arm/plat-omap? One of its 
related header files, dsp_common.h, has survived in the tree after it 
was moved to include/asm-arm/arch-omap/ (commit 
d23b6a447c9cd1d7376c5ec109b4be015a121eec), and then to 
arch/arm/plat-omap/include/map/.

Can I do anything to get omap_dsp_init() back into the omap tree? Could 
I just start with readding that old dsp_common.c, including any 
necessary header files, back to arch/arm/plat-omap/dsp? Or what other 
way should I take to restore omap1510 mcbsp1/3 support back?

Thanks,
Janusz

