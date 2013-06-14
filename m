From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm associated to a pwrdm
Date: Fri, 14 Jun 2013 06:59:45 -0700
Message-ID: <878v2caj3i.fsf@linaro.org>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
	<1371118124-15910-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36258 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab3FNN7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 09:59:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so682766pab.17
        for <linux-omap@vger.kernel.org>; Fri, 14 Jun 2013 06:59:48 -0700 (PDT)
In-Reply-To: <1371118124-15910-2-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Thu, 13 Jun 2013 15:38:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> The powerdomain framework expects all powerdomains to be associated with

s/expects/currently expects/

> a corresponding voltagedomain. For some SoCs' (like the already existing AM33xx
> family, or for the upcoming AM437x and DRA7 SoCs') which
> do not have a Voltage controller/Voltage Processor (neither the SR I2C
> bus to communicate with the PMIC) there is no need for a Powerdomain to have
> a voltage domain association (since they are really non scaleable, even
> though the voltage domains exist in place).

This last phrase inside the parentheses doesn't make sense to me.
Reading that makes me think that the lack of an on-chip voltage domain
means that evn an external regulators can't scale the voltage, which I
don't believe is the case.

> Extend the arch operations to add an api which the powerdomain core can
> then use to identify if a voltdm lookup and association for a powerdomain
> is really needed.

Yes, this idea looks right to me.

In addition to the wording above, a minor nit below...

[...]

> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 140c360..8ed89de 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -166,6 +166,7 @@ struct powerdomain {
>   * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
>   * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
>   * @pwrdm_wait_transition: Wait for a pd state transition to complete
> + * @pwrdm_has_voltdmi: Check if a voltdm association is needed

s/voltdmi/voltdm/

Kevin

