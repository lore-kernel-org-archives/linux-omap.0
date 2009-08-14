From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCHv2] OMAP3: PM: Ensure MUSB is accessible before we attempt
 to reset it
Date: Fri, 14 Aug 2009 12:25:11 -0500
Message-ID: <4A859DF7.1070303@ti.com>
References: <1250196401-24433-1-git-send-email-jon-hunter@ti.com> <87prazcq5g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262AbZHNRZR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Aug 2009 13:25:17 -0400
In-Reply-To: <87prazcq5g.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


Kevin Hilman wrote:
> Jon, you're raising the bar and spoiling us with such descriptive
> changelogs.  If everyone was as thorough as you, the world would be a
> merrier place. :)
> 
> Thanks, pushing to PM branch and pm-2.6.29.
> 
> Kevin

No problem. You are welcome. Just an FYI, but for 2.6.29, I was doing 
some testing this morning and I found that I needed to make the 
following change to the patch to make it work for 2.6.29. You are 
probably aware already as this makes the patch similar to your original 
patch for mmc-reset.

-	dev_set_name(dev, "musb_hdrc");
-	otg_clk = clk_get(dev, "ick");
+	otg_clk = clk_get(dev, "hsotgusb_ick");

Cheers
Jon

