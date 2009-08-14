From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] OMAP3: PM: Ensure MUSB is accessible before we attempt to reset it
Date: Fri, 14 Aug 2009 11:11:20 -0700
Message-ID: <87fxbu8dvb.fsf@deeprootsystems.com>
References: <1250196401-24433-1-git-send-email-jon-hunter@ti.com>
	<87prazcq5g.fsf@deeprootsystems.com> <4A859DF7.1070303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:33032 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbZHNSLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 14:11:22 -0400
Received: by pxi34 with SMTP id 34so408507pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 11:11:23 -0700 (PDT)
In-Reply-To: <4A859DF7.1070303@ti.com> (Jon Hunter's message of "Fri\, 14 Aug 2009 12\:25\:11 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Kevin Hilman wrote:
>> Jon, you're raising the bar and spoiling us with such descriptive
>> changelogs.  If everyone was as thorough as you, the world would be a
>> merrier place. :)
>>
>> Thanks, pushing to PM branch and pm-2.6.29.
>>
>> Kevin
>
> No problem. You are welcome. Just an FYI, but for 2.6.29, I was doing
> some testing this morning and I found that I needed to make the
> following change to the patch to make it work for 2.6.29. You are
> probably aware already as this makes the patch similar to your
> original patch for mmc-reset.
>
> -	dev_set_name(dev, "musb_hdrc");
> -	otg_clk = clk_get(dev, "ick");
> +	otg_clk = clk_get(dev, "hsotgusb_ick");

Ah yes, I thought of that when I first saw the patch but forgot to do
that on pm-2.6.29.

Thanks, pushing to pm-2.6.29.

Kevin
