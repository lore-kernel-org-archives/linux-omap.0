From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH] omap: zoom2: fix build break due to ASoC changes
Date: Sat, 2 Oct 2010 02:13:32 +0530
Message-ID: <415b0d914dc4b97c64ed2917bc9cf030@mail.gmail.com>
References: <1285965011-17384-1-git-send-email-gadiyar@ti.com> <20101001203605.GE21157@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55396 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753371Ab0JAUni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:43:38 -0400
Received: by mail-wy0-f179.google.com with SMTP id 42so4133470wyb.24
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 13:43:37 -0700 (PDT)
In-Reply-To: <20101001203605.GE21157@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Mark Brown wrote:
> On Sat, Oct 02, 2010 at 02:00:11AM +0530, Anand Gadiyar wrote:
> > Commit f0fba2ad1b6 (ASoC: multi-component - ASoC
> > Multi-Component Support) in linux-next as of 20101001
> > broke omap builds with the following errors.
>
> Acked-by: Mark Brown <brooonie@opensource.wolfsonmicro.com>
>
> since it fixes build breakage but it looks like it'll result in reduced
> functionality so a nicer fix would be good.
>

Looking through the archives, it appears the build break was already
addressed
by two patches from Jarkko. Sorry, I didn't see those earlier.

https://patchwork.kernel.org/patch/202322/
https://patchwork.kernel.org/patch/202332/

I've minor issues with those patches, so I'll follow up separately
on that thread.

- Anand
