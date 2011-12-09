From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 01/15] OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Fri, 09 Dec 2011 10:07:39 -0800
Message-ID: <87wra5fwk4.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39194 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667Ab1LISHz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 13:07:55 -0500
Received: by mail-yx0-f180.google.com with SMTP id r8so3274099yen.11
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 10:07:52 -0800 (PST)
In-Reply-To: <1322236188-19456-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> Every PMIC has it's own eccentricities, For example, one of the
> PMIC has MSB set to 1 for a specific function - voltage enable!
> using an hardcoded value specific for TWL when copied over to
> such an implementation causes the system to crash as the MSB bit
> was 0 and the voltage got disabled!.
>
> Instead we use actual values and depend on the convertion routines
> to abstract out the eccentricities of each PMIC.
>
> With this, we can now move the voltages to a common location in
> voltage.h as they are no longer dependent on PMICs and expect the
> PMIC's conversion routines to set a cap if the voltage is out of
> reach for the PMIC.

Nice.

> Reported-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Also needs your sign-off, since you're on the delivery path now.

Kevin
