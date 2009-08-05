From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Wed, 05 Aug 2009 15:14:42 +0200
Message-ID: <4A7985C2.1040403@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl> <20090803181405.6249b843.jhnikula@gmail.com> <200908042246.09919.jkrzyszt@tis.icnet.pl> <200908050945.22160.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38437 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933713AbZHENOx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Aug 2009 09:14:53 -0400
In-Reply-To: <200908050945.22160.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Arun K S <arunks@mistralsolutions.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

Peter Ujfalusi wrote:
> On Tuesday 04 August 2009 23:46:09 ext Janusz Krzysztofik wrote:
> 
>> For both playback start while capturing and capture start while playing,
>> XSYNC_ERR/RSYNC_ERR is clear
>> and XRDY/RRDY is ready,
> 
> This means that XRDY/RRDY is set (1)?

Yes, trasmit/recieve confirmed at first while(!(readw(...) & XRDY/RRDY)) 
attempt.

> In case of playback start while capture: What is the state of the XEMPTY bit 
> (SPCR2:2)? Is it 0? It should.

Have not checked, but will do for completness.

> I think the reason is quite simple: on OMAP1 the DMA request is edge sensitive 
> (compared to OMAP2 and OMAP3 where it is level based). This means:

Good recap.

> The danger with the pollwrite/pollread is:
> If the stream is not mono, than you kind of ensure a certain channel shift 
> (channel switch in case of stereo stream).

Good point, I was trying break all not mono.

>> If my analysis is correct, the best solution I can see would be starting
>> McBSP transfer for one direction only, not both, so the opposite direction
>> can be started when needed. That requires deeper and wider OMAP knowledge
>> and a change in omap_mcbsp_start() API though. I am not in a position to
>> deal with this myself, I'm afraid.
> 
> I agree, this would be the best solution for the problem.

I was also considering omap_mcbsp_restart(id, direction) as a more 
conservative solution, but now, after Jarkko has subbmitted his patch on 
omap_mcbsp_start(), it's not an option any longer, I think.

Cheers,
Janusz

