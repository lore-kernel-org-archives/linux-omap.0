From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Constify watchdog_info structure
Date: Mon, 7 Mar 2011 09:39:56 +0200
Message-ID: <20110307073956.GD2522@legolas.emea.dhcp.ti.com>
References: <1299252807.21644.12.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52971 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab1CGHkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 02:40:00 -0500
Received: by mail-fx0-f45.google.com with SMTP id 11so3984833fxm.32
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 23:39:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299252807.21644.12.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 04, 2011 at 04:33:27PM +0100, Michael Buesch wrote:
> Nobody modifies the watchdog_info structure, so make it const.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
