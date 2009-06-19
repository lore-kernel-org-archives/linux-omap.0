From: Arun K S <arunks@mistralsolutions.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Fri, 19 Jun 2009 11:55:33 -0700
Message-ID: <df7d0fbb0906191155u75e3c8bdlee26dce267889287@mail.gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	 <20090608094028.415e6ec3.jhnikula@gmail.com>
	 <4A2E7921.7090200@tis.icnet.pl> <4A364B1A.5040905@tis.icnet.pl>
	 <20090615181633.4570426f.jhnikula@gmail.com>
	 <4A37AFA9.4080403@tis.icnet.pl>
	 <20090618090712.8f8ecd53.jhnikula@gmail.com>
	 <4A3A27C8.60005@tis.icnet.pl>
	 <df7d0fbb0906182050x1f58da96u9bac334a363bbed0@mail.gmail.com>
	 <4A3B7485.5060601@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:35186 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbZFSTAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 15:00:38 -0400
In-Reply-To: <4A3B7485.5060601@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Fri, Jun 19, 2009 at 4:20 AM, Janusz
Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
> Tony Lindgren wrote:
>>
>> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090618 14:52]:
>>>
>>> Tony Lindgren wrote:
>>>>
>>>> On omap1, DSP needs to be powered and idled before some mcbsp cloc=
ks can
>>>> be used. Or at least needs to be powered up.
>>>
>>> AFAICS there is no DSP code in mainline at all, so the answer is no=
, DSP
>>> =A0was likely not powered up at all. For several weeks I was trying=
 to do
>>> =A0what was impossible :/. But fortunatelly, I have learned a lot ;=
).
>>
>> We at least used to have code to power and idle the DSP even without=
 the
>> dspgateway compiled in.. Sorry I don't remember the details. But mos=
t
>> likely you need to have the dspgateway patch enabled.
>
> Tony,
> Thanks for clarifying things.
>
> Arun K S wrote:
>>
>> On Thu, Jun 18, 2009 at 4:40 AM, Janusz
>> Krzysztofik<jkrzyszt@tis.icnet.pl> wrote:
>>>
>>> ... I retried the new driver on commit
>>> 90e758af52ba803cba233fabee81176d99589f09 and confirmed the prevoius=
ly
>>> seen
>>> hangup. I found that it was omap_mcbsp_request() never returning ba=
ck
>>> from.
>>
>> I faced the same issue while writing ASoC driver for tlv320aic23b co=
dec.
>>
>> You can have a look at this thread:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg03852.html
>>
>> It may help.
>
> Arun,
> Thanks, it's good to hear not only me having this problem ;). So what=
 is the
> current status of your osk driver? What tree do you use, what extra p=
atches
> do you apply to make it actually working?

Currently osk driver works fine on 2.6.31. Initially i used to add the
omap_mcbsp_request()
at the boot time, other wise it hangs up. Audio in current mainline
tree works fine for osk5912
with out any such hacks. I believe there are some patches from Russel
for the DSP memory mapping during
2.6.29 kernel.

>
> ---------------------------
>
> After all, could someone please give me an advise, what tree, even wi=
th
> buggy omap1510 mcbsp/dsp support, should I base my work on for best r=
esults?
> Omap? Sound? Mainline? I mean not only easy getting the driver workin=
g, but
> also giving it the best possible path into the mainline.

You have to use current omap tree with the patches from current sound
tree(ASoC omap platform drivers changes) for
testing the driver.
Somebody correct me if i am wrong.

>
> Thanks,
> Janusz
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
