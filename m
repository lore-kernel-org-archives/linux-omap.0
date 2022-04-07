Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D170C4332F
	for <linux-omap@archiver.kernel.org>; Thu,  7 Apr 2022 08:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiDGISO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 7 Apr 2022 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiDGIRp (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2022 04:17:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22DBD1F6BE0;
        Thu,  7 Apr 2022 01:15:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9A61F8125;
        Thu,  7 Apr 2022 08:13:19 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:15:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] clocksource/drivers/timer-ti-dm: Update defines for
 am6 for inline functions
Message-ID: <Yk6drKxwOSVdrKp+@atomide.com>
References: <20220407071006.37031-1-tony@atomide.com>
 <20220407071006.37031-2-tony@atomide.com>
 <9671f0a5-6860-8a75-d65e-345ce890cd88@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9671f0a5-6860-8a75-d65e-345ce890cd88@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [220407 08:01]:
> On 07/04/2022 09:10, Tony Lindgren wrote:
> > @@ -251,7 +251,8 @@ int omap_dm_timers_active(void);
> >    * The below are inlined to optimize code size for system timers. Other code
> >    * should not need these at all.
> >    */
> > -#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
> > +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS) || \
> > +	defined(CONFIG_ARCH_K3)
> 
> Why not replace the above by CONFIG_OMAP_DM_TIMER ?

Hmm that's a good question for why it was not that way earlier.

This series changes things for tristate "OMAP dual-mode timer driver" if
ARCH_K3 || COMPILE_TEST though. So the inline stubs are still needed for
COMPILE_TEST it seems.

Regards,

Tony
