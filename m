From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] arm: mach-omap1: board-voiceblue: add missing
 include
Date: Tue, 18 Jan 2011 10:21:02 +0200
Message-ID: <20110118082102.GJ2436@legolas.emea.dhcp.ti.com>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
 <1295337165-22934-8-git-send-email-aaro.koskinen@iki.fi>
 <20110118081156.GI2436@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56671 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795Ab1ARIVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 03:21:09 -0500
Received: by yxl31 with SMTP id 31so2848500yxl.18
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 00:21:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110118081156.GI2436@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 18, 2011 at 10:11:56AM +0200, Felipe Balbi wrote:
> On Tue, Jan 18, 2011 at 09:52:45AM +0200, Aaro Koskinen wrote:
> > Eliminates the following sparse warnings:
> > 
> > 	arch/arm/mach-omap1/board-voiceblue.c:253:6: warning: symbol 'voiceblue_wdt_enable' was not declared. Should it be static?
> > 	arch/arm/mach-omap1/board-voiceblue.c:261:6: warning: symbol 'voiceblue_wdt_disable' was not declared. Should it be static?
> > 	arch/arm/mach-omap1/board-voiceblue.c:269:6: warning: symbol 'voiceblue_wdt_ping' was not declared. Should it be static?
> > 	arch/arm/mach-omap1/board-voiceblue.c:278:6: warning: symbol 'voiceblue_reset' was not declared. Should it be static?
> 
> wasn't this caused by previous patch ?

no, it wasn't. Different symbols :-p

-- 
balbi
