From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
 hang
Date: Fri, 27 Nov 2009 11:42:46 +0000
Message-ID: <20091127114245.GD29821@rakim.wolfsonmicro.main>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
 <20091126102230.GB27562@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
 <20091126151121.GC9351@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC329C@dbde02.ent.ti.com>
 <20091126152933.GD9351@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC33B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59482 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752376AbZK0Lmk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 06:42:40 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC33B6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

On Fri, Nov 27, 2009 at 01:37:54PM +0530, Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] We were able to fine tune NFS and use arecord to capture
> large files. But some more problems cropped up when tried to suspend /
> resume. Basic playback is working fine wrt suspend/resume. But capture,
> either tried independently or with playback, is creating a system wide
> hang. I fixed that infinite-loop in resume path but I believe something
> else needs cleanup too.
> Any pointers? 

Have you got CONFIG_DETECT_SOFTLOCKUP turned on?  With any luck that
will at least pinpoint where the code has locked up.  Otherwise it's
going to be a case of bisection via printk().

A contrast and compare of the hardware initialisation on initial boot
compared to coming out of suspend might identify the problem.  If the
playback is working it's *probably* something missing in the CPU init
that's specific to capture.
