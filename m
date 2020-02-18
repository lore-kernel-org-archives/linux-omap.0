Return-Path: <SRS0=SA7d=4G=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFAC34026
	for <linux-omap@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A2521D56
	for <linux-omap@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBROO6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:14:58 -0500
Received: from muru.com ([72.249.23.125]:55842 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgBROO5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 18 Feb 2020 09:14:57 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0EB0C8043;
        Tue, 18 Feb 2020 14:15:39 +0000 (UTC)
Date:   Tue, 18 Feb 2020 06:14:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        agx@sigxcpu.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com,
        jjhiblot@ti.com
Subject: Re: LED backlight on Droid 4 and others
Message-ID: <20200218141452.GF35972@atomide.com>
References: <20200105183202.GA17784@duo.ucw.cz>
 <20200106084549.GA14821@dell>
 <20200211172900.GH64767@atomide.com>
 <20200212201638.GB20085@amd>
 <20200218135219.GC3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218135219.GC3494@dell>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [200218 13:52]:
> On Wed, 12 Feb 2020, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > > It would be good to get LED backlight to work in clean way for 5.6
> > > > > kernel.
> > > ...
> > > > > [If you have an idea what else is needed, it would be welcome; it
> > > > > works for me in development tree but not in tree I'd like to
> > > > > upstream.]
> > > > > 
> > > > > Lee, would you be willing to take "backlight: add led-backlight
> > > > > driver"? Would it help if I got "leds: Add managed API to get a LED
> > > > > from a device driver" and "leds: Add of_led_get() and led_put()" into
> > > > > for_next tree of the LED subsystem?
> > > > 
> > > > It looks like you have an open question from Tony on v10.
> > > > 
> > > > Is that patch orthogonal, or are there depend{ants,encies}?
> > > 
> > > Uhh looks like we messed up a bit with integration. Now droid4
> > > LCD backlight can no longer be enabled at all manually in v5.6-rc1
> > > without the "add led-backlight driver" patch.. Should we just
> > > merge it to fix it rather than start scrambling with other
> > > temporary hacks?
> > 
> > We should just merge the "add led-backlight driver". Everything should
> > be ready for it. I'm sorry if I broke something working, I was not
> > aware it worked at all.
> > 
> > Unfortunately, this is backlight code, not LED, so I can't just merge it.
> 
> Please go ahead.  Apply my Acked-by and merge away ASAP.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

OK best to merge the driver via the LED tree:

Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
