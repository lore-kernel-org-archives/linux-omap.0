From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 18:14:05 +0300
Message-ID: <20090803181405.6249b843.jhnikula@gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<20090803112950.3fb6cda9.jhnikula@gmail.com>
	<4A76ED80.6040001@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:58293 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbZHCPM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 11:12:57 -0400
Received: by ewy10 with SMTP id 10so3095452ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 08:12:57 -0700 (PDT)
In-Reply-To: <4A76ED80.6040001@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Arun K S <arunks@mistralsolutions.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Mon, 03 Aug 2009 16:00:32 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Hi,
> I made more testing on my OMAP1510 and found out that I could get your 
> example usage working without my patch, but only if started like this:
> 
> 	arecord -D hw:0,0 -f S16_LE|aplay -D hw:0,0
> 
> If I start the same with "-D hw:0,0" omitted from aplay, it doesn't work 
> any longer, waiting forever. It definitelly doesn't work if I start 
> capture and playback one after another, no matter which one goes first 
> (record while playing or play while recording). So it looks like 
> starting both streams simultaneously can do the job, but a short delay 
> breaks it.
> 
> With my patch, it seems to work fine for me in all cases.
> 
So it looks that McBSP-DMA for another stream cease to work if there is
more than certain delay between first stream start and second one but
omap_mcbsp_pollwrite or _pollread will clear the error condition. Can
you debug is this due clearing the possible XSYNC_ERR, waiting for
transmit/receive confirmation or playing with data registers there?

> Jarkko, have you ever tried it on your OMAP2/3 with parallel playback 
> and capture started one after another, not simultaneously?
> 
Yes I have. Like recording into file (arecord /dev/shm/foo) and start
playing it after some time (aplay /dev/shm/foo) or playing a file and
start recording into another.

> If the problem appears to be OMAP1510 or AMS_DELTA specific, I can add a 
> check for a machine or cpu type to avoid braking unaffected machines.
> 
I'm thinking can your platform show some existing problem not noted
before... but yes, check for 1510 would be bit safer now and is also
kind of revisit comment why 1510 needs special handling.


-- 
Jarkko
