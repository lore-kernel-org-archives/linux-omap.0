From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Thu, 26 Nov 2009 20:52:08 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC329C@dbde02.ent.ti.com>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
 <20091126102230.GB27562@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
 <20091126151121.GC9351@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbZKZPWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 10:22:11 -0500
In-Reply-To: <20091126151121.GC9351@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Thursday, November 26, 2009 8:41 PM
> To: Aggarwal, Anuj
> Cc: 'Troy Kisky'; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> Arun KS
> Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
> hang
> 
> On Thu, Nov 26, 2009 at 08:26:44PM +0530, Aggarwal, Anuj wrote:
> 
> > driver, although I am not sure if the problem is in the audio driver.
> > When tried to capture, using NFS as storage, it gives overrun error and
> comes out with:
> > arecord: pcm_read:1617: read error: Input/output error
> 
> > It happen always after ~20 sec, file size ~5MB. Tried with multiple
> > configurations in arecord but no use.
> > When tried: arecord -f cd /dev/null, it works fine. Same issue doesn't
> > come too when I try to store the captured audio file on a MMC card.
> 
> > Any idea what could be the problem? Why arecord goes for a toss after a
> > single overrun error and why it is happening always after ~20 sec? Is
> > there something which can be tried to narrow down the problem?
> 
> Sounds like you've narrowed the problem down to a performance issue with
> NFS writeout - it's probably having trouble keeping up with your I/O
> rate.  This isn't 100% surprising with smaller systems, sometimes tuning
> the NFS configuration can resolve the issue but sometimes the hardware
> is just underspecified.
[Aggarwal, Anuj] I am still surprised how this could be a NFS writeout issue
as we are seeing a consistent read/write rate of 2Mbps over tftp. When dd
command is used for read/write to further check NFS performance, 2Mbps for write and 4Mbps for read is observed.
Does that still mean nfs is the culprit? What could be tweaked in audio/network driver to avoid this problem, any suggestions?
> 
> arecord is a pretty basic program and doesn't try terribly hard to
> recover from errors.
[Aggarwal, Anuj] Any other utility to try capture which does error 
recovering too?
