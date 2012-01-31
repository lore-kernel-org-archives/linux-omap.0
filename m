From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 09:29:13 -0800
Message-ID: <87mx93ok5y.fsf@ti.com>
References: <20120130093931.11027.31048.stgit@dusk>
	<20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46033 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378Ab2AaR3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 12:29:16 -0500
Received: by mail-vx0-f182.google.com with SMTP id m1so303476vcm.41
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 09:29:15 -0800 (PST)
In-Reply-To: <878vkopw2o.fsf@ti.com> (Kevin Hilman's message of "Mon, 30 Jan
	2012 16:14:23 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Paul,

Kevin Hilman <khilman@ti.com> writes:

> Paul Walmsley <paul@pwsan.com> writes:
>
>> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> pwrdm_pre_transition(), which appears a few lines after these calls,
>> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
>> need to do it twice.
>
> It looks like these two for OMAP4 are surpurfluous since the immediately
> follow a call to pwrdm_pre_transition() as well.
>
> Santosh/Rajendra, please confirm/ack.

So after the discussion, do you want to fold this into the original
patch, or do you want a separate patch?

Kevin
