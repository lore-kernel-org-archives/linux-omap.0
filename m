From: Tony Lindgren <tony@atomide.com>
Subject: Re: [QUESTION] what's the problem with CBUS ?
Date: Thu, 30 Dec 2010 12:53:31 -0800
Message-ID: <20101230205331.GF7771@atomide.com>
References: <20101227171309.GA2235@legolas.emea.dhcp.ti.com>
 <20101227171815.GB2235@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47871 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab0L3Uxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Dec 2010 15:53:55 -0500
Content-Disposition: inline
In-Reply-To: <20101227171815.GB2235@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

Sorry for the delay in responding, mostly in read-only mode this
week :)

* Felipe Balbi <balbi@ti.com> [101227 09:17]:
> >
> >What was the problem you saw with N810 which caused the need for
> >commit fc8c2f1dba400e9a0d1d82756e0e2f52dfe2f4b6, quoted below ?

Heh found it after some debugging, we need to call init_completion :)

> >Also, the rtc->reset_occured flag seems to be quite useless as it's
> >never read, only written.

Yeah looks like that can be removed.

Reverted the earlier if 0 hack and pushed the following patch
to the cbus branch.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Dec 2010 12:47:00 -0800
Subject: [PATCH] cbus: Fix retu_rtc_do_reset

We need to also call init_completion before using it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -289,6 +289,7 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 	INIT_WORK(&rtc->work, retu_rtca_expired);
 	mutex_init(&rtc->mutex);
+	init_completion(&rtc->sync);
 
 	r = retu_get_status();
 	if (!r) {
