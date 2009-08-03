From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 03 Aug 2009 16:00:32 +0200
Message-ID: <4A76ED80.6040001@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl> <20090803112950.3fb6cda9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59607 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbZHCOAq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Aug 2009 10:00:46 -0400
In-Reply-To: <20090803112950.3fb6cda9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, Arun K S <arunks@mistralsolutions.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

Jarkko Nikula wrote:
> On Mon, 3 Aug 2009 03:32:04 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> 
>> This patch tries to correct the problem of full duplex mode not working
>> over a single McBSP based CPU DAI.
>>
>> Created against linux-2.6.31-rc5.
>> Tested on Amstrad Delta.
>>
> Do you have some specific test case how to trigger this? I haven't
> seen this on 2420 or 34xx (e.g. with 'arecord -d 1 -f dat |aplay') but
> I have no doubt that this can happen on 1510. At least this doesn't
> cause any harm on Beagle so I'm fine with the fix.

Hi,
I made more testing on my OMAP1510 and found out that I could get your 
example usage working without my patch, but only if started like this:

	arecord -D hw:0,0 -f S16_LE|aplay -D hw:0,0

If I start the same with "-D hw:0,0" omitted from aplay, it doesn't work 
any longer, waiting forever. It definitelly doesn't work if I start 
capture and playback one after another, no matter which one goes first 
(record while playing or play while recording). So it looks like 
starting both streams simultaneously can do the job, but a short delay 
breaks it.

With my patch, it seems to work fine for me in all cases.

Jarkko, have you ever tried it on your OMAP2/3 with parallel playback 
and capture started one after another, not simultaneously?

Arun, can your snd-soc-osk9512 work on OMAP1610 in full duplex mode 
without any limitations?

If the problem appears to be OMAP1510 or AMS_DELTA specific, I can add a 
check for a machine or cpu type to avoid braking unaffected machines.

Thanks,
Janusz

