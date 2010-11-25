From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Wed, 24 Nov 2010 17:40:17 -0800
Message-ID: <87lj4i2nb2.fsf@deeprootsystems.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42209 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0KYBkY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 20:40:24 -0500
Received: by gxk22 with SMTP id 22so216695gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 17:40:23 -0800 (PST)
In-Reply-To: <1290524213-395-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Tue, 23 Nov 2010 20:26:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Implement OMAP GPIO module in platform device model. OMAP2+ specific =
GPIO
> module uses hwmod FW.
>
> Tested on OMAP2430, OMAP44430, OMAP3430 SDP boards, OMAP4430 Blaze bo=
ard
> and zoom3 board. Verified that this patch series does not break the O=
MAP1
> build.
>
> Version History:
> ---------------
> v7 Series:
> - Use gpio iclks as main_clk in OMAP3 & OMAP4
> - Implement GPIO as a platform device (use hwmod FW for OMAP2+)
>  and the implementation is similar to current GPIO code. Does not
>  modify the gpio suspend/ resume/ prepare for odle and resume after
>  idle code and these modifications would be done in a separate patch
>  series. This was suggested by Kevin in another internal email thread=
=2E

OK, I'm ready to merge this series, and we can deal with the runtime PM
conversion in another series as that's where the tricky part lies.

However, I'd like one more rebase/retest due to some other dependencies=
=2E
Can you rebase/retest using my current pm-core branch?   That includes
several dependencies that are also targetted for 2.6.38:

- misc. PM fixes
- i2c hwmod + runtime PM conversion (my pm-hwmod-i2c branch)
- several board file changes/updates (Tony's devel-board branch)
- hwmod core fixes (Paul's hwmod_a_2.6.38 branch)
- wdt hwmod cleanups (Paul's wdt_2.6.38 branch)

Also, can you collect the acks from Beno=C3=AEt and update your changel=
ogs to
include them.  Thanks.

Please be sure your board file changes are updated for the board file
changes in the devel-board branch.

Thanks,=20

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
