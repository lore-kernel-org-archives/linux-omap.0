From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: Re: ASoC audio not working on OMAP3 EVM
Date: Fri, 13 Feb 2009 15:14:02 +0530
Message-ID: <2ee9e08d0902130144qba6a130l331c663cfdaa574c@mail.gmail.com>
References: <1234424393.13374.2.camel@eenurkka-desktop>
	 <2ee9e08d0902120138p62b91989rbaf525d2efbbad21@mail.gmail.com>
	 <20090212114948.5fe50dd8.jarkko.nikula@nokia.com>
	 <E25633C1-D318-4AAC-BEA0-006034B1D619@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:33366 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZBMJoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 04:44:04 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1339525wfa.4
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 01:44:02 -0800 (PST)
In-Reply-To: <E25633C1-D318-4AAC-BEA0-006034B1D619@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,

Thanks for your help, it came out as a hardware issue. Same image
worked fine when tried on a different EVM. Now the audio is playing
fine, except that I am hearing a very light pop-noise as soon I start
the playback.

Any suggestions on removing that? It didn't occur if I play something
second time.

Thanks,
Anuj

On Thu, Feb 12, 2009 at 4:31 PM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 12 feb 2009, om 10:49 heeft Jarkko Nikula het volgende geschreven:
>
>> On Thu, 12 Feb 2009 10:38:27 +0100
>> ext Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:
>>
>>> The patch doesn't help, result is same...
>>>
>>> Any help is welcome
>>>
>> My Beagle is working fine on top of l-o head (commit
>> 70ff4a1aafd2378c9e3ff153135ba6d0bde45215) and with Steve's patch
>>
>> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=80c509fdd74f3b158267374cc55156965c8bf930
>>
>> What codec OMAP3 EVM is using? If AIC3x, then Eero's patch might help
>
> the same codec as beagle and overo (twl/tps)
>
> regards,
>
> Koen



--
Best Regards,
Anuj Aggarwal
