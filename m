From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
 hang
Date: Fri, 27 Nov 2009 11:47:19 +0000
Message-ID: <20091127114719.GE29821@rakim.wolfsonmicro.main>
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
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46849 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751012AbZK0LrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 06:47:14 -0500
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

Incidentally, it'd be good to get the fixes for the CODEC driver (at
least the infinite loop one) in sooner rather than later - there's a
clear bug there which it'd good to try to get into 2.6.32.
