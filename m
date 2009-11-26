From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Thu, 26 Nov 2009 20:26:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
 <20091126102230.GB27562@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51648 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbZKZO4x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 09:56:53 -0500
In-Reply-To: <20091126102230.GB27562@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Thursday, November 26, 2009 3:53 PM
> To: Aggarwal, Anuj
> Cc: 'Troy Kisky'; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> Arun KS
> Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
> hang
> 
> On Thu, Nov 26, 2009 at 08:31:11AM +0530, Aggarwal, Anuj wrote:
> 
> > I have already tried that but it doesn't fix the problem entirely.
> > Still, I was not able to playback properly because the bias settings
> > were not handled correctly and as you can see, it writes to some
> > invalid registers too (all registers don't exist between 0 and
> ARRAY_SIZE).
> 
> Please also note the following patch which is queued for 2.6.32:
> 
> commit 50b6bce59d154b5db137907a5c0ed45a4e7a3829
> Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Date:   Mon Nov 23 13:11:53 2009 +0000
> 
>     ASoC: Fix suspend with active audio streams
> 
[Aggarwal, Anuj] I am also seeing one more problem with the original 
driver, although I am not sure if the problem is in the audio driver. 
When tried to capture, using NFS as storage, it gives overrun error and comes out with:
arecord: pcm_read:1617: read error: Input/output error

It happen always after ~20 sec, file size ~5MB. Tried with multiple
configurations in arecord but no use.
When tried: arecord -f cd /dev/null, it works fine. Same issue doesn't 
come too when I try to store the captured audio file on a MMC card.

Any idea what could be the problem? Why arecord goes for a toss after a 
single overrun error and why it is happening always after ~20 sec? Is
there something which can be tried to narrow down the problem?

