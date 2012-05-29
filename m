From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP4: add support for TPS62361 PMIC
Date: Tue, 29 May 2012 14:29:15 -0700
Message-ID: <87ehq2ekwk.fsf@ti.com>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:35023 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755921Ab2E2V3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 17:29:18 -0400
Received: by pbbrr13 with SMTP id rr13so7023420pbb.12
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 14:29:16 -0700 (PDT)
In-Reply-To: <1336139842-845-1-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 4 May 2012 16:57:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> This set adds support for TPS62361 PMIC, which is used to power
> MPU voltagedomain on OMAP4460 boards. These patches apply on top
> of 3.4 + my voltagedomain fixes set to avoid adding redundant code.

Hmm... do you have an updated version of your voltagedomain fixes?  Or
are you waiting for me to review something?  I thought I had been
through them already, but if I have not, they slipped throught the
cracks.  I'm sorry.  Can you please update/repost?

Thanks.

Kevin

> Working tree available here for interested parties:
>
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.4-voltdm-tps-v1
>
> Tree has been tested with:
> - omap3beagle board
> - omap4panda es board (OMAP4460)
> - omap4blaze board (OMAP4430)
>
> Tested modifying the voltage levels on all core regulators (vdd1...vdd3)
> and measuring that the voltages do actually change.
>
> Patch #1 was needed before the voltages could be modified on a panda
> board es device, otherwise the timing for the I2C channel was so bogus
> it usually failed. The values used were taken from an android tree and
> are based on TI analysis.
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
