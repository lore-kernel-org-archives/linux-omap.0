From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap: Implement common omap_has_feature
Date: Fri, 9 Jul 2010 10:08:11 +0300
Message-ID: <20100709070811.GD24913@atomide.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
 <20100708093755.16352.75290.stgit@baageli.muru.com>
 <4C35E630.4070204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab0GIHIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 03:08:15 -0400
Content-Disposition: inline
In-Reply-To: <4C35E630.4070204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [100708 17:46]:
> Tony Lindgren had written, on 07/08/2010 04:37 AM, the following:
> >
> >@@ -112,6 +114,12 @@ void omap_get_die_id(struct omap_die_id *odi)
> > 	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
> > }
> >+u32 omap2_has_feature(u32 feat_mask)
> >+{
> >+	/* REVISIT: Add necessary omap2 feature tests here */
> >+	return ((feat_mask & omap_features) == feat_mask);
> >+}
> >+
>
> I did consider this path initially,
> a) Additional functional call overhead here. some of the calls to
> has_feature() will get called through pretty active paths, we would
> like it to be minimized to compile time optimized inline function as
> much as possible.(no reason why this cant me a inline macro in
> cpu.h?) -

Well it should not matter how slow this code is, it should only be
used to initialize things during __init.

Any code doing detection after initialization is wrong.

Regards,

Tony
