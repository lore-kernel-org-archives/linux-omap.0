From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/2] OMAP2PLUS: DSS2: Clock Source Changes
Date: Tue, 8 Mar 2011 18:24:07 +0200
Message-ID: <1299601447.2131.16.camel@deskari>
References: <1299585035-26931-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078Ab1CHQYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 11:24:12 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28GOC5k019139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 10:24:12 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p28GOCik001146
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 10:24:12 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p28GOCYJ005334
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 10:24:12 -0600 (CST)
In-Reply-To: <1299585035-26931-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-08 at 05:50 -0600, Taneja, Archit wrote:
> There are clocks on OMAP4 within DSS2 which can have multiple clock sources.
> This cleans up the existing way of selecting/getting the clock sources and add
> some of the new clock sources for OMAP4.
> 
> Applies over:
> http://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> Archit Taneja (2):
>   OMAP2PLUS: DSS2: Cleanup clock source related code
>   OMAP4: DSS2: Clock source changes for OMAP4

The set looks good. I'll apply it tomorrow morning after some testing.

But something for future patches:

The naming of the functions could be made clearer. We have logic clock
for the LCD outputs but also for DISPC. So for example dispc_lclk_rate()
could be dispc_lcd_lclk_rate(), to make sure it's not called when the
caller needs to know the lclk of dispc. And it looks too similar to
dispc_fclk_rate() which returns clock for dispc core, easily giving the
impression that these two are linked.

And similarly dispc_pclk_rate() could be dispc_lcd_pclk_rate(), to make
clear that it's not for example venc pixel clock.

Perhaps there are also other functions whose name could be more specific
now that we have separate clocks for dispc core and the lcd paths.

 Tomi


