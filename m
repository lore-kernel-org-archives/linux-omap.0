From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
 hang
Date: Thu, 26 Nov 2009 15:11:21 +0000
Message-ID: <20091126151121.GC9351@rakim.wolfsonmicro.main>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
 <20091126102230.GB27562@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39604 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753953AbZKZPLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Nov 2009 10:11:16 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

On Thu, Nov 26, 2009 at 08:26:44PM +0530, Aggarwal, Anuj wrote:

> driver, although I am not sure if the problem is in the audio driver. 
> When tried to capture, using NFS as storage, it gives overrun error and comes out with:
> arecord: pcm_read:1617: read error: Input/output error

> It happen always after ~20 sec, file size ~5MB. Tried with multiple
> configurations in arecord but no use.
> When tried: arecord -f cd /dev/null, it works fine. Same issue doesn't 
> come too when I try to store the captured audio file on a MMC card.

> Any idea what could be the problem? Why arecord goes for a toss after a 
> single overrun error and why it is happening always after ~20 sec? Is
> there something which can be tried to narrow down the problem?

Sounds like you've narrowed the problem down to a performance issue with
NFS writeout - it's probably having trouble keeping up with your I/O
rate.  This isn't 100% surprising with smaller systems, sometimes tuning
the NFS configuration can resolve the issue but sometimes the hardware
is just underspecified.

arecord is a pretty basic program and doesn't try terribly hard to
recover from errors.
