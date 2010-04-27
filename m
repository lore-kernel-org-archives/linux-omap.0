From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 00/22] OMAP3: PM: Smartreflex and voltage revamp
Date: Tue, 27 Apr 2010 12:18:07 -0700
Message-ID: <87ljc8hfgw.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65429 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab0D0TSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 15:18:11 -0400
Received: by pvg2 with SMTP id 2so1632409pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 12:18:10 -0700 (PDT)
In-Reply-To: <1271408597-3066-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:32\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> The main motivations behind this patch series are the following
> 1. Making smartreflex a platform driver with omap-device layer.
> 2. Separating voltage specific code from smartreflex.c and other
>    locations and consolidating them into voltage.c and voltage.h.
> 3. Smartreflex module can have Class 1 Class 2 or Class 3 implementations
>    depending on the PMIC in use. Making smartreflex.c capable
>    of handling both the Class 2 and 3  implementaions and separating out
>    class specific code into a separate class driver.
> 4. Remove dependencies on opp id in the smartreflex and
>    voltage drivers
> 5. Implementating  latest TI recommended register settings for
>   Smartreflex and Voltage processor module as well as recommended
>   sequences for enabling and disabling of Smartreflex and Voltage
>   processor modules.
> 6. Implementing VP force update method of voltage scaling which is
>    again TI hardware recommended.
>
> What this patch series does not address are
> 1. Separating PMIC specific portions from smartreflex and voltage code.
> 2. OMAP3630 and OMP4 smartreflex support.
>
> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
> and is dependent on the following patches not yet applied onto this branch.
>
>         http://patchwork.kernel.org/patch/81504/
>         http://patchwork.kernel.org/patch/81606/
>
> This patch series has been tested on OMAP3430 SDP with basic power
> management tests including the dvfs scripts.

First some general comments...

- check multi-line comment style

- use of dev_err() instead of pr_err() (or dev_* instead of pr_*)
  wherever you have a valid platform_device.  This will print messages
  with the specific SR device name so you get more detailed messages.
  It will also avoid you having to use sr_info->srid since that
  number is already part of the device name.
  
And now, IMHO, this is getting close enough, where I think it's
getting mostly ready for submission upstream.  To that end, I think
it's time to start creating this series against mainline, instead of
against the PM branch.

This is basically a rewrite, so I think it makes sense to breifly
summarize the history in the first patch, but then build from scratch
against mainline (except for SRF changes which will have to be a
separate series based on the PM branch.)

As it is, the series is getting hard to follow as there are several
things that are cleaned up from the old code and then removed later in
the series etc.  For that reason, I'd now like to see this as a fresh
series against mainline.

Actually, currnely it will have to be based on my pm-vc branch which
is a small series of VC init/setup patches that I'll be queueing for
2.6.35, but itself is based on mainline.

The SR series could broken up as follows (only a suggestion)

- Creation of voltage layer: current pm-vc branch + voltage.c

- Creation of device/platform init: hwmods, sr_device.c

- Creation of driver: smartreflex*.[ch], sr_device.c

These should each have a brief summary of history and main
contributors, but you as primary author.

Kevin
