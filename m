From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 5 Nov 2012 08:27:33 -0800
Message-ID: <20121105162733.GK4953@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
 <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
 <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751378Ab2KEQ1r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 11:27:47 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>

* Linus Walleij <linus.walleij@linaro.org> [121104 09:39]:
> On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> > I have two options now
> > - add only default states for now, I can add reset of
> > the state details once suspend/resume is supported.
> > - add same values in all the states, modify those once
> > suspend/resume is added for AM335x.
> 
> The OMAP maintainer gets to choose how this is to be done,
> it's none of my business :-)

Either way is fine with me as long as the changes have been
tested and you don't have to redo things once you have
suspend and resume working.

Regards,

Tony
