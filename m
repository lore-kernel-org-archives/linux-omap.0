From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
 hang
Date: Thu, 26 Nov 2009 15:29:33 +0000
Message-ID: <20091126152933.GD9351@rakim.wolfsonmicro.main>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
 <20091126102230.GB27562@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
 <20091126151121.GC9351@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC329C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48170 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751148AbZKZP32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Nov 2009 10:29:28 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC329C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

On Thu, Nov 26, 2009 at 08:52:08PM +0530, Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] I am still surprised how this could be a NFS writeout issue
> as we are seeing a consistent read/write rate of 2Mbps over tftp. When dd
> command is used for read/write to further check NFS performance, 2Mbps for write and 4Mbps for read is observed.
> Does that still mean nfs is the culprit? What could be tweaked in audio/network driver to avoid this problem, any suggestions?

There can also be issues with the way the data gets pushed into NFS
interacting poorly - it's not just the raw data rate that's in play
here, it's also things like how often the writes are done and how big
they are.  Possibly also overhead from interacting with the ethernet
chip but that's not normally an issue for anything modern.

The fact that this only happens when NFS is in use seems a fairly clear
pointer to an interacton there.

> [Aggarwal, Anuj] Any other utility to try capture which does error
> recovering too?

Not for the console off the top of my head, and TBH I don't really know
how good the error handling is in the various apps.  You could also try
playing with the buffer size options in arecord.
