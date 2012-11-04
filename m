From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Sun, 4 Nov 2012 18:37:44 +0100
Message-ID: <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
	<CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
	<20121001154451.GI4840@atomide.com>
	<CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
	<CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:48990 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab2KDRhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 12:37:46 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so1979538eaa.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Nov 2012 09:37:44 -0800 (PST)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>

On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:

> I completely understood this named modes, I have added named
> modes like this in am335x-xxx.dts files

I do not understand how the pinctrl-single dts files work actually,
so please get Tony to review this part.

> I think "pinctrl-1" state will be used in driver
> suspend/resume calls.

Hopefully, I think you should test the code and monitor the
system to make sure the right thing happens.

> I have the pinmux/conf settings for default state but fully
> optimized pinmux/conf values in idle & suspend states are not
> available yet.

You have defined a "sleep" state which is what should be used
for suspend? Or do you mean that you do have a state but
you're just not defining it to the most optimal setting yet?

> Even though if I add here, I am unable to test
> these pins in suspend state because suspend/resume of AM35xx
> is not added yet

Aha.

> I have two options now
> - add only default states for now, I can add reset of
> the state details once suspend/resume is supported.
> - add same values in all the states, modify those once
> suspend/resume is added for AM335x.

The OMAP maintainer gets to choose how this is to be done,
it's none of my business :-)

Yours,
Linus Walleij
