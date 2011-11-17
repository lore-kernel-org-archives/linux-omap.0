From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 10/11] omap3+: use lp params for calculating clock setup times
Date: Wed, 16 Nov 2011 16:10:37 -0800
Message-ID: <87hb23622q.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-11-git-send-email-t-kristo@ti.com>
	<87lirv600c.fsf@ti.com> <1321377742.2854.8.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42569 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701Ab1KQAKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 19:10:42 -0500
Received: by ywt34 with SMTP id 34so402341ywt.31
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 16:10:40 -0800 (PST)
In-Reply-To: <1321377742.2854.8.camel@sokoban> (Tero Kristo's message of "Tue,
	15 Nov 2011 19:22:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

[...]

> One question though, do you want to have the auto_ret / auto_off
> support along with these changes? Some of the code in this set is only
> used when the auto_ret / auto_off is in, and it also makes it a bit
> more easier to test the resulting stuff.

Yes, it would be helpful to include that for better testing.  You can
add that as separate patches at the end of the series.

Thanks,

Kevin
