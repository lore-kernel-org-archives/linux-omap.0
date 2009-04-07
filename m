From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap_wdt: modprobe fails
Date: Tue, 7 Apr 2009 06:58:18 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037BC87391@dlee02.ent.ti.com>
References: <49DB34AE.3090100@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45087 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbZDGL6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 07:58:32 -0400
In-Reply-To: <49DB34AE.3090100@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Roger Quadros
> Sent: Tuesday, April 07, 2009 6:11 AM

>    modprobe omap_wdt fails in omap PM branch. below is the trace log.
> any idea why?
>
>    i wonder weather fails in master too.

Looks like it. I had noticed it broken in one older tree a while back.

The probe routine at omap_wdt_disable() touches registers without trying to enable the clocks to the module.  Before this a clk_get happens but no clk_enable.

314         platform_set_drvdata(pdev, wdev);
315
316         omap_wdt_disable(wdev);

Actually there were a number of bugs here.  The only reason the probe works at all is because the boot loader turned the clock on to stop it.  If you make sure its shut off in loader you will crash here normally.

Some fixes were made in an older tree which you can draw from to fix it.

http://git.omapzoom.org/?p=repo/omapkernel.git;a=commitdiff;h=c1753c36b04db34660b6df94e5f395401985f0da

Regards,
Richard W.

