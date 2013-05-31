From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Fri, 31 May 2013 12:31:43 -0700
Message-ID: <871u8nymhs.fsf@linaro.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
	<1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
	<874ndk5sse.fsf@linaro.org> <51A8BF17.4050209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:62487 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928Ab3EaTbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 15:31:46 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so2724977pbc.2
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 12:31:46 -0700 (PDT)
In-Reply-To: <51A8BF17.4050209@ti.com> (Grygorii Strashko's message of "Fri,
	31 May 2013 18:17:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hi Grygorii,

Grygorii Strashko <grygorii.strashko@ti.com> writes:

[...]

> I've a question:
> Why don't add API in "Kernel/Base PM" framework for context lost detection?
> Like pm_was_ctx_lost().

I'm not aware of any proposals to do this in a generic way.  Feel free
to propose one if you're so moved.

One complexity is that such a call is not needed on platforms that use
generic power domains (not OMAP). With gen_pd, the runtime PM callbacks
do not get called unless the power domains actually lose power.  So for
gen_pd, you assume context has been lost when your runtime PM callbacks
are called.

This is a bit different than how we've done it on OMAP, and there's been
some work in exploring how to adapt OMAP to gen_pd, but there's not
anyone actively working on it at the moment.

That being said, I'm still leaning towards simply removing the context
loss logic from all the OMAP drivers.  This feature adds a relatively
minor optimization, and a more configurable optimization could be done
using runtime PM autosuspend timeouts (configurable from userspace.)
Combined with the fact that adoption of gen_pd means we don't need it,
I'm included to drop it all together.

Kevin
