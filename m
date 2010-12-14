From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5 v3] OMAP: idle path errata fixes
Date: Mon, 13 Dec 2010 19:49:31 -0800
Message-ID: <87k4jdypx0.fsf@deeprootsystems.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38640 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839Ab0LNDth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 22:49:37 -0500
Received: by gyb11 with SMTP id 11so98462gyb.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 19:49:36 -0800 (PST)
In-Reply-To: <1291395818-8639-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 3 Dec 2010 11:03:33 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Charulatha Varadarajan <charu@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tao Hu <tghk48@motorola.com>, Tony Lindgren <tony@atomide.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Hi Nishanth,

Nishanth Menon <nm@ti.com> writes:

> as discussed in [1], here is step 2 - idle path errata fixes.
> this is the next rev incorporating comments from V2 post
> of this series.

I had a couple small comments on individual patches.

In addition, in the next series, can you report the platforms it was
tested on, and how it was tested (retention idle/suspend, off
idle/suspend, CPUidle enabled?, etc.)

I tested this series (and Jean's cleanup patch) on 34xx/n900 with
retention idle & suspend and off idle & suspend with and without CPUidle
enabled.)

Also, when posting an updated series, can you update the version of all
patches in the series, even if they are unchanged?  This makes more
more explicit versioning, keeps things clearer in patchwork and avoids
problems with dumb mailers who thread by subject only.

Also, please Cc linux-arm-kernel when posting the next version. 

Thanks,

Kevin
