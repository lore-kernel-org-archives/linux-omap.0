From: Arun KS <arunks@mistralsolutions.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 10:57:26 -0700
Message-ID: <dfeb90390908031057u2a3b81a0ob4194006f26babc6@mail.gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	 <20090803112950.3fb6cda9.jhnikula@gmail.com>
	 <4A76ED80.6040001@tis.icnet.pl>
	 <dfeb90390908031053o14b4583fh83e4306253a13944@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:35202 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbZHCR50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 13:57:26 -0400
Received: by qyk34 with SMTP id 34so3094947qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 10:57:26 -0700 (PDT)
In-Reply-To: <dfeb90390908031053o14b4583fh83e4306253a13944@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li, Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>

CCing Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>

Hope he has one osk.

On Mon, Aug 3, 2009 at 10:53 AM, Arun KS <arunks@mistralsolutions.com> =
wrote:
>
>
> On Mon, Aug 3, 2009 at 7:00 AM, Janusz Krzysztofik <jkrzyszt@tis.icne=
t.pl> wrote:
>>
>> Jarkko Nikula wrote:
>>>
>>> On Mon, 3 Aug 2009 03:32:04 +0200
>>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>>>
>>>> This patch tries to correct the problem of full duplex mode not wo=
rking
>>>> over a single McBSP based CPU DAI.
>>>>
>>>> Created against linux-2.6.31-rc5.
>>>> Tested on Amstrad Delta.
>>>>
>>> Do you have some specific test case how to trigger this? I haven't
>>> seen this on 2420 or 34xx (e.g. with 'arecord -d 1 -f dat |aplay') =
but
>>> I have no doubt that this can happen on 1510. At least this doesn't
>>> cause any harm on Beagle so I'm fine with the fix.
>>
>> Hi,
>> I made more testing on my OMAP1510 and found out that I could get yo=
ur example usage working without my patch, but only if started like thi=
s:
>>
>> =A0 =A0 =A0 =A0arecord -D hw:0,0 -f S16_LE|aplay -D hw:0,0
>>
>> If I start the same with "-D hw:0,0" omitted from aplay, it doesn't =
work any longer, waiting forever. It definitelly doesn't work if I star=
t capture and playback one after another, no matter which one goes firs=
t (record while playing or play while recording). So it looks like star=
ting both streams simultaneously can do the job, but a short delay brea=
ks it.
>>
>> With my patch, it seems to work fine for me in all cases.
>>
>> Jarkko, have you ever tried it on your OMAP2/3 with parallel playbac=
k and capture started one after another, not simultaneously?
>>
>> Arun, can your snd-soc-osk9512 work on OMAP1610 in full duplex mode =
without any limitations?
>
>
> Janusz,
>
> Haven't done testing in full duplex mode.
> I don't have access to osk5912 board now. If someone has got osk and =
do the testing it ll be good. It=A0 ll take at least another 2 more mon=
th for me to do the testing on osk.
>
> Regards,
> Arun
>
>>
>>
>> If the problem appears to be OMAP1510 or AMS_DELTA specific, I can a=
dd a check for a machine or cpu type to avoid braking unaffected machin=
es.
>>
>> Thanks,
>> Janusz
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
