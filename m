From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
Date: Fri, 26 Oct 2012 11:17:51 -0700
Message-ID: <87fw51hzcg.fsf@deeprootsystems.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51998 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965847Ab2JZSRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 14:17:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2097930pad.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 11:17:18 -0700 (PDT)
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com> (Mike
	Turquette's message of "Wed, 3 Oct 2012 18:16:00 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Hi Mike,

Mike Turquette <mturquette@ti.com> writes:

> From: Mike Turquette <mturquette@linaro.org>
>
> This series creates a new callback for struct voltagedomain,
> .get_voltage.  This fetches the voltage from hardware, if possible, and
> returns it to the caller.  We use this call to populate
> voltdm->nominal_volt at boot time.

I pointed out a couple nitpicky things on individual patches, but
otherwise this direction and motiviation for this series looks OK by me.

Just some minor comments about the structure of the series.  I tend to
prefer combining the introduction of a new function with it's usage.  It
makes review and understanding much easier, IMO.  If there are reasons
to keep them separate, that's fine too.  Just describe the reasons in
the cover letter.

Thanks,

Kevin
