From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/18][V3] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Thu, 03 May 2012 13:19:29 -0700
Message-ID: <87r4v1kofi.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45904 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758338Ab2ECUT1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 16:19:27 -0400
Received: by dajz8 with SMTP id z8so2069704daj.16
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 13:19:26 -0700 (PDT)
In-Reply-To: <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:32 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> With the previous changes all the states are valid, except
> the last state which can be handled by decreasing the number
> of states.

I don't think this changelog is valid anymore as you're not doing
anything to decrease the number of states.

I updated the changelog locally to this:

ARM: OMAP3: cpuidle - remove the 'valid' field

With the previous changes all the states are valid, except the last
state which is now handled at runtime by next_valid_state() based on
the errata flags.

Any problems with that?

Kevin
