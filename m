From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 01 Apr 2013 11:10:57 -0700
Message-ID: <20130401181057.8177.19688@quantum>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
 <20130328212739.13785.44736@quantum> <20130328223513.GA19470@kahuna>
 <51596725.9060109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:61416 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab3DASLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 14:11:04 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so1158354dak.2
        for <linux-omap@vger.kernel.org>; Mon, 01 Apr 2013 11:11:03 -0700 (PDT)
In-Reply-To: <51596725.9060109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, andrii.tseglytskyi@ti.com

Andrii,

Sorry to nitpick further but this your replies look very non-standard.
Typically a right chevron and a space is used to indent replies instead
of a tab.  Something like this:
https://wiki.openstack.org/wiki/MailingListEtiquette#Reply_Level_Indication

Quoting Andrii Tseglytskyi (2013-04-01 03:53:25)
> In case if VC/VP use clock notifier to scale voltage, there is no guarantee of
> order.
> The only option which I see is to create ABB API and call it from OMAP
> regulator during OPP change.
> 

I doubt that is the only option.  Do you mean it is the only option to
quickly get it working right now?

The VC & VP code should be converted to the regulator framework if not
already.  After that is done there are some options for how ABB is
handled.

The VC & VP regulator driver could directly call the api's you list
below in their .set_voltage callback.

Additionally if the regulator is reentrant then ABB could be modeled as
a regulator itself and the VC or VP .set_voltage callback could perhaps
call regulator_set_mode(abb_reg, FBB_MODE).

Creating a regulator for each ABB instance may be overkill or may not be
overkill... that IP has been around since 3630 so several chips use it.

> omap_abb_pre_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);
> omap_abb_post_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);
> 
> Mike, do you agree to proceed in this way? Also I need you opinion about files
> placement. Now it is placed in
> 

The above code looks like a quick solution to me.  The long-term
upstream path for this code needs be decided first.  If everything is
going to get converted to the regulator framework then I do not agree to
proceed that way.

Let's figure out what is happening to the VC/VP code first and then
figure out what to do about ABB.

Regards,
Mike

> drivers/power/avs/abb.c
> 
> And header will be added to
> include/linux/power/abb.h
> 
> Regards,
> Andrii
