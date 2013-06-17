From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 0/2] Remove unused voltagedomain data for AM33xx
Date: Mon, 17 Jun 2013 07:32:49 -0700
Message-ID: <87wqps959q.fsf@linaro.org>
References: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:57094 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3FQOcx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 10:32:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so2818272pbb.6
        for <linux-omap@vger.kernel.org>; Mon, 17 Jun 2013 07:32:53 -0700 (PDT)
In-Reply-To: <1371474983-29296-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Mon, 17 Jun 2013 18:46:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> Hi,
>
> The powerdomain framework currently expects to always have a voltagedomain
> associated with a given powerdomain. We already have AM33xx which
> has no Voltage Controller/Voltage Processor as part of PRCM.
> There are more SoCs' to follow starting with AM437x and DRA7xx
> which do not have VC/VP. All these SoCs', hence do not support any
> form of auto-scaling of voltages, that was possible on earlier OMAPs'
> using the VFSM to trigger an i2c communication to the PMIC automatically
> on hitting a low power state.
>
> Instead of adding dummy voltage domain data files, like was done for the
> AM33xx case, make the powerdomain framework aware of the fact that some
> SoCs' might not really have support for auto-scaling of voltages in hw.
>
> Patches are based of 3.10-rc6 and are boot tested on am335x bone.
>
> Rajendra Nayak (2):
>   ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
>     associated to a pwrdm
>   ARM: AM33xx: Remove the unused voltagedomain data

Thanks, queuing up this series with ack from Santosh and tested-by from
Afzal.  I'll try, but not sure if it can make it for v3.11.

Kevin
