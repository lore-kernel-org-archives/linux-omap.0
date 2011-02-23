From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: omap: pm: assumptions on TWL and SmartReflex.
Date: Thu, 24 Feb 2011 00:02:01 +0530
Message-ID: <AANLkTimxp74FpmNaCsS9V3L8jMdC5_f28Gnd9YxqNMnJ@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:37694 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924Ab1BWScZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 13:32:25 -0500
Received: by mail-wy0-f173.google.com with SMTP id 29so3965321wyb.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 10:32:23 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 23, 2011 at 19:57, Premi, Sanjeev <premi@ti.com> wrote:
> Hi all,
>
> While trying to suport TPS65023 with AM3517 processor, i realize
> that much of the code has implicit assumption on usage of TWLx0y0
> PMIC and Smartreflex.
Looking at the data sheet, single SCLK, SDAT makes me think that you
are potentially attempting SR Class2 here. am I right?

The other potential usage is configure the chip over vcbypass and then
use class3 with reg address 0x6, 0x8 for DCDC1 and LDO1/2-> though i
am not sure how you'd use SR for LDO1/2 with 200mA and non linear
value2voltage.. the other possibility is you have two independent
TPS65023 chips on each rail..
may be you could briefly explain how you are integrating it all up to
understand the weakness of the datastructures involved..

> Check the definition of omap_volt_pmic_info and omap_volt_data.
>
> Just to "hack" support we can fill *don't care* values for the
> fields not supported and wrap processing under if (cpu_is_....())
> checks; but this doesn't appear to be a good solution.
yes, there are improvements possible. we probably need to see your
usage to comeup with something that works for all of us
>
> Also, the PMIC specific code doesn't really belong to mach-omap2.
> OR was there a specific reason to keep it here??
potentially - but there are PMIC specific parameters that need to be
configured for the SR driver to function as well..

Regards,
Nishanth Menon
